//
//  JYield.m
//  Yield
//
//  Created by 蔡杰 on 2017/11/13.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import "JYield.h"
#import <objc/runtime.h>

const void * JYieldKey;

@interface JYield ()

@property(nonatomic, strong) dispatch_queue_t queue;
@property(nonatomic, strong)dispatch_group_t execution;
@property(nonatomic, strong)dispatch_semaphore_t productionEnter;
@property(nonatomic, strong)dispatch_semaphore_t productionLeave;

@property(nonatomic, strong) id nextObject;
@property(nonatomic, strong) NSMutableArray *remainingObjects;
@property(nonatomic, assign) BOOL shouldTerminate;

@end

@implementation JYield

- (instancetype)init {
    return nil;
}

- (instancetype)initWithTarget:(NSObject *)target block:(void (^)(id))block {
    if (self = [super init]) {
        
        
        //设置执行优先级与当前线程一致
        dispatch_queue_t queue = dispatch_queue_create(nil,DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t refrenceQueue = dispatch_get_global_queue(qos_class_self(), 0);
        dispatch_set_target_queue(queue, refrenceQueue);
        self.queue = queue;
        
        self->_execution = dispatch_group_create();
        self->_productionEnter = dispatch_semaphore_create(0);
        self->_productionLeave = dispatch_semaphore_create(0);
        
        [self associateWithTarget:target];

        dispatch_group_enter(self->_execution);
        
        __weak JYield *weakSelf = self;
        __weak NSObject *weakTarget = target;
        dispatch_async(queue, ^{
            NSObject *strongtarget = weakTarget;
            JYield *strongSelf = weakSelf;
            
            dispatch_semaphore_wait(strongSelf->_productionEnter, DISPATCH_TIME_FOREVER);
            if ( ! strongSelf->_shouldTerminate) {
                block(strongtarget);
            }
            [strongSelf deassociateFromTarget:target];
            strongSelf->_shouldTerminate = YES;
            dispatch_semaphore_signal(strongSelf->_productionLeave);
            dispatch_group_leave(strongSelf->_execution);
        });
    }
        
    return self;
}

- (void)associateWithTarget:(NSObject *)target {
    objc_setAssociatedObject(target, JYieldKey, self, OBJC_ASSOCIATION_ASSIGN);
}

- (void)deassociateFromTarget:(NSObject *)target {
    objc_setAssociatedObject(target, JYieldKey, nil, OBJC_ASSOCIATION_ASSIGN);
}

+ (nullable JYield *)associatedWithTarget:(NSObject *)target {
    //TODO: Support multiple (recursive) enumerations at once.
    return objc_getAssociatedObject(target, JYieldKey);
}

- (void)dealloc {
    self->_shouldTerminate = YES;
    dispatch_semaphore_signal(self->_productionEnter);
    dispatch_group_wait(self->_execution, DISPATCH_TIME_FOREVER);
}

+ (BOOL)shouldReturnAfterYielding:(nullable id)next fromTarget:(NSObject *)target {
    if (next == nil)
        return NO; //! Skip yielded nils.
    
    __unsafe_unretained JYield *yield = [self associatedWithTarget:target];
    [yield setNextObject:(id)next]; // Silence nullable warning.
    return yield->_shouldTerminate;
}


#pragma mark -

- (BOOL)hasNextObject {
    return (self.nextObject != nil || self.shouldTerminate );
}

- (id)nextObject {
    while (![self hasNextObject]) {
        dispatch_semaphore_signal(self.productionEnter);
        dispatch_semaphore_wait(self.productionLeave, DISPATCH_TIME_FOREVER);
        
    }
    id next = self.nextObject;
    self.nextObject = nil;
    return next;
}

- (void)setNextObject:(id)next {
    if (self->_remainingObjects) {
        [self->_remainingObjects addObject:next];
    }
    else {
        self.nextObject = next;
        dispatch_semaphore_signal(self->_productionLeave);
        dispatch_semaphore_wait(self->_productionEnter, DISPATCH_TIME_FOREVER);
    }
}

- (NSArray *)allObjects {
    NSMutableArray *remaining = [NSMutableArray new];
    self->_remainingObjects = remaining;
    
    dispatch_semaphore_signal(self->_productionEnter);
    dispatch_group_wait(self->_execution, DISPATCH_TIME_FOREVER);
    
    self->_remainingObjects = nil;
    return remaining;
}

@end

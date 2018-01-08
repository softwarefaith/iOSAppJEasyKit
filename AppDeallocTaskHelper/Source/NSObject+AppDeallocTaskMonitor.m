//
//  NSObject+AppDeallocTaskMonitor.m
//  AppDeallocTaskHelper
//
//  Created by 蔡杰 on 2018/1/4.
//  Copyright © 2018年 蔡杰. All rights reserved.
//

#import "NSObject+AppDeallocTaskMonitor.h"
#include <libkern/OSAtomic.h>
#include <stdatomic.h>
#import <pthread.h>
#import <objc/runtime.h>

static const char DeallocTaskModelKey; // Associated object key
const NSUInteger DeallocTaskIllegalIdentifier = 0; // illegal identifier

@interface DeallocTaskMonitor : NSObject

@property (nonatomic, assign) pthread_mutex_t lock;//多线程 抱在tasks 安全
@property (nonatomic, strong) NSMutableDictionary *tasks; //保存执行任务
@property (nonatomic, unsafe_unretained) id target;//原对象，是unsafe_unretained的，保证始终不为nil，所以也建议不要在任务Block里面调用target的方法

@property (nonatomic,assign, readonly,getter=isAsyn) BOOL asyn;

@end

@implementation DeallocTaskMonitor

- (instancetype)initWithTarget:(id)target asyn:(BOOL) asyn{
    self = [super init];
    if (self) {
        _target = target;
        
        _asyn = asyn;
        
        if (_asyn) {
            pthread_mutex_init(&_lock,NULL);
        }
        _tasks = [[NSMutableDictionary alloc] init];
    
    }
    return self;
}

- (NSUInteger)addDeallocTask:(DeallocTaskBlock)taskBlock {
    
    static volatile int64_t  globalIdentifier = 0;
    if (!taskBlock) {
        return DeallocTaskIllegalIdentifier;
    }
    //为了保证自增的Key的线程安全，同时平衡性能
    NSUInteger newIdentifier = (NSUInteger)OSAtomicIncrement64(&globalIdentifier);
    NSNumber *newIdentifierNumber = @(newIdentifier);
    if (newIdentifierNumber) {
        
        if (self.isAsyn) pthread_mutex_lock(&_lock);
        [_tasks setObject:[taskBlock copy] forKey:newIdentifierNumber];
        if (self.isAsyn) pthread_mutex_unlock(&_lock);
        
        return newIdentifier;
    } else {
        return DeallocTaskIllegalIdentifier;
    }
    
}

- (BOOL)removeTaskWithIdentifier:(NSUInteger)identifier {
    
    if (identifier == DeallocTaskIllegalIdentifier) {
        return NO;
    }
    
    NSNumber *removeIdentierNumber = [NSNumber numberWithUnsignedInteger:identifier];
    if (removeIdentierNumber) {

        if (self.isAsyn)  pthread_mutex_lock(&_lock);
        [_tasks removeObjectForKey:removeIdentierNumber];
        if(self.isAsyn)   pthread_mutex_unlock(&_lock);
        return YES;
    }
    return NO;
}

- (void)removeAllTasks {
   if (self.isAsyn)  pthread_mutex_lock(&_lock);
    [_tasks removeAllObjects];
    if (self.isAsyn) pthread_mutex_unlock(&_lock);
}

- (void)dealloc {
    
    [_tasks enumerateKeysAndObjectsUsingBlock:^(NSNumber *identifier,DeallocTaskBlock block, BOOL * _Nonnull stop) {
        block(_target, identifier.unsignedIntegerValue);
    }];
    if (self.isAsyn) pthread_mutex_destroy(&_lock);
}

@end

@implementation NSObject (AppDeallocTaskMonitor)

- (NSUInteger)addDeallocTask:(DeallocTaskBlock)taskBlock  asyn:(BOOL)asyn{
    
    if (!taskBlock) {
        return DeallocTaskIllegalIdentifier;
    }
    
    DeallocTaskMonitor *model = nil;
    
    
    if(asyn) {
    
    @synchronized (self) {
        model = objc_getAssociatedObject(self, &DeallocTaskModelKey);
        if (!model) {
            model = [[DeallocTaskMonitor alloc] initWithTarget:self asyn:YES];
            objc_setAssociatedObject(self, &DeallocTaskModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
        
    } else{
        
        model = objc_getAssociatedObject(self, &DeallocTaskModelKey);
        if (!model) {
            model = [[DeallocTaskMonitor alloc] initWithTarget:self asyn:NO];
            objc_setAssociatedObject(self, &DeallocTaskModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    NSUInteger newIdentifier = [model addDeallocTask:taskBlock];
    return newIdentifier;
}

- (NSUInteger)synAddDeallocTask:(DeallocTaskBlock)taskBlock {
    return [self addDeallocTask:taskBlock asyn:NO];
}

- (NSUInteger)asynAddDeallocTask:(DeallocTaskBlock)taskBlock {
    
    return [self addDeallocTask:taskBlock asyn:YES];
    
}

- (BOOL)removeDeallocTaskByIdentifier:(NSUInteger)identifier {
    DeallocTaskMonitor *model = objc_getAssociatedObject(self, &DeallocTaskModelKey);
    if (model) {
        return [model removeTaskWithIdentifier:identifier];
    } else {
        return NO;
    }
}

- (void)removeAllDeallocTasks {
    DeallocTaskMonitor *model = objc_getAssociatedObject(self, &DeallocTaskModelKey);
    if (model) {
        [model removeAllTasks];
    }
}

@end

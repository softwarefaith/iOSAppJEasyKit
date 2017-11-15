//
//  JYield.h
//  Yield
//
//  Created by 蔡杰 on 2017/11/13.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Used to wrap method call in NSEnumerator that can be used in for-in loop. Example: for (id x in Yieldable(self, produceObjects:100)) {…}
#define Yieldable(target, invocation) \
((NSEnumerator *)({ \
[[Yielder alloc] initWithTarget:target block:^(typeof(target) innerTarget) { \
[innerTarget invocation]; \
}]; \
}))

//! Use from within a void method to produce multiple values.
#define yield(x) \
((void)({ \
if ([Yielder shouldReturnAfterYielding:(x) fromTarget:(self)]) \
return; \
}))


NS_ASSUME_NONNULL_BEGIN

@interface JYield : NSEnumerator

- (instancetype)initWithTarget:(NSObject *)target block:(void (^)(id))block;

+ (BOOL)shouldReturnAfterYielding:(nullable id)next fromTarget:(NSObject *)target;


@end

NS_ASSUME_NONNULL_END


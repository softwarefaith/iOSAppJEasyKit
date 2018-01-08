//
//  NSObject+AppDeallocTaskMonitor.h
//  AppDeallocTaskHelper
//
//  Created by 蔡杰 on 2018/1/4.
//  Copyright © 2018年 蔡杰. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 土土哥博客:http://tutuge.me/2017/03/11/TTGDeallocTaskHelper/
 利用Associated Object：
 Associated Object会在对象释放时自动释放，所以可以用来“挂载”要执行的任务。

 给对象添加Associated Object
 在Associated Object里面保存要执行的任务Block
 实现Associated Object的dealloc方法，在Associated Object释放的时候，批量执行之前添加的Block
 
 对象dealloc ARC下内部处理机制:
 object_cxxDestruct释放对象的ivar、property
 _object_remove_assocations释放对象的Associated Object
 objc_clear_deallocating重置所有指向对象的weak指针为空
 
 Associated Object是在第二步被释放的，这个时候，原对象的属性已被release，并且，Associated Object对象自己的dealloc不一定在什么时候会被调用（比如加到了autorelease pool里面），所以，不建议在任务Block里面调用target原对象的方法。
 
 */

typedef void (^DeallocTaskBlock)(__unsafe_unretained id object, NSUInteger identifier);

extern const NSUInteger DeallocTaskIllegalIdentifier;


@interface NSObject (AppDeallocTaskMonitor)

- (NSUInteger)synAddDeallocTask:(DeallocTaskBlock)taskBlock;

//支持多线程,内部加锁保护
- (NSUInteger)asynAddDeallocTask:(DeallocTaskBlock)taskBlock;

- (BOOL)removeDeallocTaskByIdentifier:(NSUInteger)identifier;


- (void)removeAllDeallocTasks;

@end

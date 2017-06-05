//
//  NSString+Calculate.h
//
//  Created by  on 16/8/25.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

/*
   字符串 数字精确计算，主要使用NSDecimalNumber
 */

@interface NSString (calculate)
//加
- (NSString *)calculateByAdding:(NSString *)stringNumer;
//减
- (NSString *)calculateBySubtracting:(NSString *)stringNumer;
//乘
- (NSString *)calculateByMultiplying:(NSString *)stringNumer;
//除
- (NSString *)calculateByDividing:(NSString *)stringNumer;
//幂运算
- (NSString *)calculateByRaising:(NSUInteger)power;
//四舍五入
- (NSString *)calculateByRounding:(NSUInteger)scale;
//是否相等
- (BOOL)calculateIsEqual:(NSString *)stringNumer;
//是否大于
- (BOOL)calculateIsGreaterThan:(NSString *)stringNumer;
//是否小于
- (BOOL)calculateIsLessThan:(NSString *)stringNumer;
//转成小数
- (double)calculateDoubleValue;







@end

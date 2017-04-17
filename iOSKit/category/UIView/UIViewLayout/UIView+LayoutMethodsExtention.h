//
//  UIView+LayoutMethodExtention.h
//  FrameLayout
//
//  Created by 蔡杰 on 2017/4/17.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LayoutMethods.h"


/*
 math 函数说明:
 round：如果参数是小数，则求本身的四舍五入。
 ceil：如果参数是小数，则求最小的整数但不小于本身.
 floor：如果参数是小数，则求最大的整数但不大于本身.
 
 */

@interface UIView (LayoutMethodsExtention)

/**
* Return the x coordinate on the screen.
*/
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;


@end

//
//  UIView+MethodExtention.h
//  FrameLayout
//
//  Created by 蔡杰 on 2017/4/17.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (MethodExtention)

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/*
 
 return ViewController of view
 */

- (UIViewController *)viewController;




@end

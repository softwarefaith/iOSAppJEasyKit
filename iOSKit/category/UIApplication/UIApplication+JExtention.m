//
//  UIApplication+JExtention.m
//  iOSKit-OC
//
//  Created by 蔡杰 on 2017/4/24.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import "UIApplication+JExtention.h"

@implementation UIApplication (JExtention)
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentShowedViewContrller
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}
@end

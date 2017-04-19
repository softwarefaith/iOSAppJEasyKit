//
//  UINavigationBar+JStyleExtention.h
//  RTRootNavigationController
//
//  Created by 蔡杰 on 2017/4/19.
//  Copyright © 2017年 rickytan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (JStyleExtention)



/** 设置导航栏背景颜色*/
- (void)style_setNavigationBarBackgroundColor:(UIColor *)color;

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)style_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)style_setNavigationBarVerticalOffsetY:(CGFloat)offsetY;

/**
 重置还原NavigationBar
 */
- (void)style_resetNavigationBar;

@end

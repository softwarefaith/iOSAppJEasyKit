//
//  UIView+JEasyUIFrameInstaller.h
//  FrameLayout
//
//  Created by 蔡杰 on 2017/4/20.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEasyFramer.h"
NS_ASSUME_NONNULL_BEGIN


@interface UIView (JEasyUIFrameInstaller)

- (void)easy_installFrames:(void(^)(JEasyFramer * make))frameMaker;

@end

NS_ASSUME_NONNULL_END

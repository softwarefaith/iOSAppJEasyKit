//
//  UIImage+JRoundRectImage.h
//  JAPPKit
//
//  Created by 蔡杰Alan on 16/7/19.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JRoundRectImage)

+ (UIImage *)imageOfRoundRectWithImage: (UIImage *)image
                                  size: (CGSize)size
                                radius: (CGFloat)radius;

+ (UIImage *)imageUserToCompressForSizeImage:(UIImage *)image newSize:(CGSize)siz;
@end

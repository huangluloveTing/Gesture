//
//  UIButton+Custom.h
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)

+(instancetype) buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame;

- (void) changeBorderLayerWithConerRadius:(CGFloat)radius color:(UIColor *)color with:(CGFloat)width;

@end

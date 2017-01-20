//
//  UIButton+Custom.m
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

+ (instancetype) buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = frame;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    return btn;
}

- (void)changeBorderLayerWithConerRadius:(CGFloat)radius color:(UIColor *)color with:(CGFloat)width {
    [self layerBorderRadius:radius width:width color:color];
}

@end

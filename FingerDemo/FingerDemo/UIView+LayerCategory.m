//
//  UIView+LayerCategory.m
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "UIView+LayerCategory.h"

@implementation UIView (LayerCategory)

- (void) layerBorderRadius:(CGFloat)raduis width:(CGFloat)width color:(UIColor *)color {
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = raduis;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

@end

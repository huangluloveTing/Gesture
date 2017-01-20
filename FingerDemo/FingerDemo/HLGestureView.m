//
//  HLGestureView.m
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "HLGestureView.h"

@interface HLGestureView ()

@property (nonatomic ,strong) HLGView *gView;

//保存上次的密码字符串
@property (nonatomic ,copy) NSString *lastPass;

@end

@implementation HLGestureView

- (HLGView *)gView {
    if (!_gView) {
        _gView = [[HLGView alloc] initWithFrame:self.bounds];
        _gView.backgroundColor = [UIColor whiteColor];
    }
    
    return _gView;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.gView];
        __weak typeof(self) weakSelf = self;
        self.gView.block = ^(NSString *pas ) {
            if (pas.length >= 4) {
                weakSelf.lastPass = pas;
                NSLog(@"pass + %@",pas);
            }
        };
    }
    
    return self;
}

- (void)bindAttributesInGestureView {
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(borderColorInHLGView:resultState:)]) {
            self.gView.circleColor_no_selected = [self.delegate borderColorInHLGView:self resultState:NumberPad_Normal];
        }
        
        if ([self.delegate respondsToSelector:@selector(borderColorInHLGView:resultState:)]) {
            self.gView.circleColor_selected = [self.delegate borderColorInHLGView:self resultState:NumberPad_Selected];
        }
        
        if ([self.delegate respondsToSelector:@selector(backColorInHLGView:resultState:)]) {
            self.gView.circleBackColor_no_selected = [self.delegate backColorInHLGView:self resultState:NumberPad_Normal];
        }
        
        if ([self.delegate respondsToSelector:@selector(backColorInHLGView:resultState:)]) {
            self.gView.circleBackColor_selected = [self.delegate backColorInHLGView:self resultState:NumberPad_Selected];
        }
        
//        if ([self.delegate respondsToSelector:@selector(lineColorInHLGView:resultState:)]) {
//            self.gView.pathLineColor = [self.delegate lineColorInHLGView:self resultState:DrawLine_Moving];
//        }
//        
//        if ([self.delegate respondsToSelector:@selector(lineColorInHLGView:resultState:)]) {
//            
//        }
        
        
    }
    
}



@end

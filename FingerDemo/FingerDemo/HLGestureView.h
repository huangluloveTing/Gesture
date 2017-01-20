//
//  HLGestureView.h
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLGestureViewDelegate;

typedef NS_ENUM (NSInteger , RetryResultState) {
    Result_Success = 1,
    Result_Faile
};

typedef NS_ENUM(NSInteger , GestureBtnStatus){
    NumberPad_Normal = 1,
    NumberPad_Selected
};

//typedef NS_ENUM(NSInteger , DrawLineStatus) {
//    DrawLine_Before = 1,
//    DrawLine_Moving,
//    DrawLine_Done
//};

@interface HLGestureView : UIView

@property (nonatomic ,assign) id<HLGestureViewDelegate> delegate;

@end

@protocol HLGestureViewDelegate <NSObject>

@optional
- (UIColor *)borderColorInHLGView:(HLGestureView *)view resultState:(GestureBtnStatus)state; //圆形数字按钮的边框颜色
- (UIColor *)backColorInHLGView:(HLGestureView *)view resultState:(GestureBtnStatus)state;  //圆形数字按钮的背景颜色
//- (UIColor *)lineColorInHLGView:(HLGestureView *)view resultState:(DrawLineStatus)state;   //手势线的颜色
//- (CGFloat)lineWidthInHLGView:(HLGestureView *)view resultState:(DrawLineStatus)state;     //手势线的宽度


@end

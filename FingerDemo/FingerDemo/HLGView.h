//
//  HLGView.h
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ResultBlock)(NSString *);

typedef NS_ENUM(NSInteger , DrawLineStatus) {
    DrawingLine = 1,
    DrawLineDone
};

@protocol HLGViewDelegate;


@interface HLGView : UIView

//按钮没有被选中的边框颜色
@property (nonatomic ,strong) UIColor *circleColor_no_selected;

//按钮被选中的边框颜色
@property (nonatomic ,strong) UIColor *circleColor_selected;

//按钮没有被选中的背景颜色
@property (nonatomic ,strong) UIColor *circleBackColor_no_selected;

//按钮选中后的背景颜色
@property (nonatomic ,strong) UIColor *circleBackColor_selected;

@property (nonatomic ,strong) ResultBlock block;

@property (nonatomic ,assign) id<HLGViewDelegate> delegate;

@end

@protocol HLGViewDelegate <NSObject>

- (UIColor *)lineColorInHLGView:(HLGView *)view drawStatus:(DrawLineStatus)status;

@end


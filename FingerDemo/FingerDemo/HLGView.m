//
//  HLGView.m
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "HLGView.h"

#define BTN_WIDTH (80 * SCR_RADIO)

@interface HLGView ()

@property (nonatomic ,strong) NSArray *allBtns;

//被选中的点
@property (nonatomic ,strong) NSMutableArray *selectedButtton;

//当手指移动在某个按钮范围内的按钮
@property (nonatomic ,strong) UIButton *selectingBtn;

@property (nonatomic ,assign) CGPoint nowPoint;

@property (nonatomic ,assign) CGFloat movingLineWidth;

//线条的颜色
@property (nonatomic ,strong) UIColor *pathLineColor;

//线的宽度
@property (nonatomic ,assign) CGFloat linePathWidth;

@end

@implementation HLGView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.circleColor_selected = [UIColor darkGrayColor];
        self.circleColor_no_selected = [UIColor lightGrayColor];
        self.circleBackColor_selected = [UIColor redColor];
        self.circleBackColor_no_selected = [UIColor whiteColor];
        self.pathLineColor = [UIColor redColor];
        self.linePathWidth = 5.0f;
        self.selectingBtn = [UIButton new];
        [self configViews];
    }
    return self;
}

- (void) configViews {
    
    self.allBtns = [NSArray array];
    self.selectedButtton = [NSMutableArray array];
    CGFloat padding_H = (self.frame.size.width - BTN_WIDTH * 3) / 4 ;
    CGFloat padding_V = (self.frame.size.height - BTN_WIDTH * 3) / 4 ;
    NSMutableArray *btns = [NSMutableArray array];
    
    for (int i = 0 ; i < 9; i ++) {
        
        NSInteger col = i % 3;
        
        NSInteger row = i / 3;
        
        CGRect frame = CGRectMake(padding_H * (col + 1) + BTN_WIDTH * col, (row+ 1) * padding_V + BTN_WIDTH * row , BTN_WIDTH, BTN_WIDTH);
        
        UIButton *fingerBtn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%d",i + 1] titleColor:[UIColor darkGrayColor] frame:frame];
        
        [fingerBtn changeBorderLayerWithConerRadius:BTN_WIDTH / 2 color:self.circleColor_no_selected with:4];
        fingerBtn.backgroundColor = self.circleBackColor_no_selected;
        
        [fingerBtn setTag:i];
        fingerBtn.userInteractionEnabled = NO;
        
        [self addSubview:fingerBtn];
        [btns addObject:fingerBtn];
        
        NSLog(@"btnCenter : %@",NSStringFromCGPoint(fingerBtn.center));
    }
    
    self.allBtns = btns;
}

#pragma mark - 当前手指触碰的点是否在给定的button 内
- (BOOL) pointContainInBtn:(CGPoint)point {

    CGFloat minSpace = MAXFLOAT;
    
    for (UIButton *btn in self.allBtns) {
        
        CGPoint btnCenter = btn.center;
        //计算给定点的距离到btn 的中心点的距离小于btn 的corRadius
        CGFloat space_x = ABS(point.x - btnCenter.x);
        CGFloat space_y = ABS(point.y - btnCenter.y);
        CGFloat space = sqrt(space_x * space_x  + space_y * space_y);
        
        if (minSpace > space) {
            minSpace = space;
            self.selectingBtn = btn;
        }
    }
    return minSpace < BTN_WIDTH / 2;
}

#pragma mark - 判断正被触碰的按钮是否已经保存在被选中按钮的数组里
- (BOOL) selectedBtnIsContainsBtn:(UIButton *)btn {
    
    for (UIButton *conBtn in self.selectedButtton) {
        if (conBtn == self.selectingBtn) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.selectedButtton removeAllObjects];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    NSLog(@"begin : %@",NSStringFromCGPoint(point));
    self.nowPoint = point;
    
    if ([self pointContainInBtn:point] && ![self selectedBtnIsContainsBtn:self.selectingBtn]) {
        [self.selectedButtton addObject:self.selectingBtn];
    }
    
    [self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    self.nowPoint = point;
    
    if ([self pointContainInBtn:point] && ![self selectedBtnIsContainsBtn:self.selectingBtn]) {
        [self.selectedButtton addObject:self.selectingBtn];
    }
    
    //当移动手势时，所显示的颜色
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineColorInHLGView:drawStatus:)]) {
        self.pathLineColor = [self.delegate lineColorInHLGView:self drawStatus:DrawingLine];
    }
    
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.nowPoint = ((UIButton *)[self.selectedButtton lastObject]).center;
    if (self.selectedButtton.count < 4) {
        [self.selectedButtton removeAllObjects];
    }
    if (self.block) {
        
        NSString *pass = ([self getCurrentPass]&&[self getCurrentPass].length > 0) ? [self getCurrentPass] : @"";
        
        self.block(pass);
    }
    
    //手势结束时，手势线的颜色
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineColorInHLGView:drawStatus:)]) {
        self.pathLineColor = [self.delegate lineColorInHLGView:self drawStatus:DrawLineDone];
    }
    
    [self setNeedsDisplay];
    [self removeAllGestureLine];
}

#pragma mark - draw
- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.pathLineColor set];
    CGContextSetLineWidth(context, self.linePathWidth);
    
    for (UIButton *btn in self.allBtns) {
        
        btn.backgroundColor = self.circleBackColor_no_selected;
        btn.layer.borderColor = self.circleColor_no_selected.CGColor;
    }
    
    if (self.selectedButtton.count > 0) {

        CGPoint firstPoint = ((UIButton *)[self.selectedButtton firstObject]).center;
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        for (UIButton *btn in self.selectedButtton) {
            
            btn.backgroundColor = self.circleBackColor_selected;
            btn.layer.borderColor = self.circleColor_selected.CGColor;
            CGContextAddLineToPoint(context, btn.center.x, btn.center.y);
        }
        
        CGContextAddLineToPoint(context, self.nowPoint.x, self.nowPoint.y);
        CGContextStrokePath(context);
    }
    
}

#pragma mark - setter
- (void) setCircleColor_selected:(UIColor *)circleColor_selected {
    _circleColor_selected = circleColor_selected;
}

- (void) setCircleColor_no_selected:(UIColor *)circleColor_no_selected {
    _circleColor_no_selected = circleColor_no_selected;
}

- (void) setCircleBackColor_selected:(UIColor *)circleBackColor_selected {
    _circleBackColor_selected = circleBackColor_selected;
}

- (void) setCircleBackColor_no_selected:(UIColor *)circleBackColor_no_selected {
    _circleBackColor_no_selected = circleBackColor_no_selected;
}

- (void) setLinePathWidth:(CGFloat)linePathWidth {
    _linePathWidth = linePathWidth;
}

- (void) setPathLineColor:(UIColor *)pathLineColor {
    _pathLineColor = pathLineColor;
}

#pragma mark -
- (NSString *) getCurrentPass {
    
    NSMutableString *str = [NSMutableString string];
    
    for (UIButton *btn in self.selectedButtton) {
        [str appendString:[NSString stringWithFormat:@"%@",btn.titleLabel.text]];
    }
    
    return str;
}

#pragma mark - 手势结束，n 秒后，手势线条消失
- (void) removeAllGestureLine {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.selectedButtton removeAllObjects];
        [self setNeedsDisplay];
    });
}

@end

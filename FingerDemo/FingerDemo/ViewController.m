//
//  ViewController.m
//  FingerDemo
//
//  Created by 黄露 on 2017/1/20.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "ViewController.h"
#import "HLGestureView.h"

@interface ViewController ()

@property (nonatomic ,strong) HLGestureView *gestureView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gestureView = [[HLGestureView alloc] initWithFrame:self.view.bounds];
    self.gestureView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.gestureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

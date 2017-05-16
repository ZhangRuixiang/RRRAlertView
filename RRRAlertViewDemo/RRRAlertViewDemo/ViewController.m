//
//  ViewController.m
//  RRRAlertViewDemo
//
//  Created by 张瑞想 on 2017/1/9.
//  Copyright © 2017年 张瑞想. All rights reserved.
//

#import "ViewController.h"
#import "RRRAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addView];
}

- (void)type1 {
    // 只有两个item
    RRRAlertView *alert1 = [[RRRAlertView alloc] initWithTitle:@"这是自定义的alertView" message:@"你可以随意修改字体颜色大小，怎么高兴怎么来" cancelButtonTitle:@"取消" otherButtonTitles:@"确定1",nil];
    // 实现block，等待回调
    alert1.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
        NSLog(@"****点击了 item %ld****",(long)index);
    };
}

- (void)type2 {
    // 多个item
    RRRAlertView *alert = [[RRRAlertView alloc] initWithTitle:@"这是自定义的alertView" message:@"你可以随意修改字体颜色大小，怎么高兴怎么来" cancelButtonTitle:@"取消" otherButtonTitles:@"确定1",@"确定2",@"确定3",nil];
    // 实现block，等待回调
    alert.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
        NSLog(@"****%ld****",(long)index);
    };
}
- (void)addView{
    
    // 简单样式
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = CGPointMake(self.view.center.x, self.view.center.y);
    [btn setTitle:@"简单样式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(type1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    // 复杂样式
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor purpleColor];
    btn2.frame = CGRectMake(0, 0, 100, 30);
    btn2.center = CGPointMake(self.view.center.x, self.view.center.y + CGRectGetHeight(btn.frame) + 20);
    [btn2 setTitle:@"复杂样式" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(type2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

@end

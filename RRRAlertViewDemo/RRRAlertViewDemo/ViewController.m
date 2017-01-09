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

    
    // 延时1s
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addView];
    });

}
- (void)addView{

    
    // 只有两个item
    RRRAlertView *alert1 = [[RRRAlertView alloc] initWithTitle:@"这是自定义的alertView" message:@"你可以随意修改字体颜色大小，怎么高兴怎么来" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定1",nil];
    // 实现block，等待回调
    alert1.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
        NSLog(@"****点击了 item %ld****",(long)index);
    };
    
    
    
    
    
    
    
    // 多个item
    
//    RRRAlertView *alert = [[RRRAlertView alloc] initWithTitle:@"这是自定义的alertView" message:@"你可以随意修改字体颜色大小，怎么高兴怎么来" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定1",@"确定2",@"确定3",nil];
//    // 实现block，等待回调
//    alert.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
//        NSLog(@"****%ld****",(long)index);
//    };
}

@end

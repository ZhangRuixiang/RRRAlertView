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
}
- (IBAction)simpleType:(id)sender {
    
    // 只有两个item
    RRRAlertView *alert1 = [[RRRAlertView alloc] initWithTitle:@"倔强的提示" message:@"RRRAlertView 是一个可以自定义的提示控件，你可以随意修改字体颜色大小，你高兴就好" cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    // 实现block，等待回调
    alert1.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
        NSLog(@"****点击了 item %ld****",(long)index);
    };
}
- (IBAction)complexType:(id)sender {
    
    // 多个item
    RRRAlertView *alert = [[RRRAlertView alloc] initWithTitle:@"倔强的提示" message:@"RRRAlertView 是一个可以自定义的提示控件，你可以随意修改字体颜色大小，你高兴就好" cancelButtonTitle:@"取消" otherButtonTitles:@"小明",@"小红",@"小兰",nil];
    
    // 实现block，等待回调
    alert.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
        NSLog(@"****%ld****",(long)index);
    };
}



@end

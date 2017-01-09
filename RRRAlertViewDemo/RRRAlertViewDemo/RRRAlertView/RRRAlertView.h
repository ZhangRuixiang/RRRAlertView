//
//  RRRAlertView.h
//  RRRAlertViewDemo
//
//  Created by 张瑞想 on 2017/1/4.
//  Copyright © 2017年 张瑞想. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRRAlertView : UIView

typedef void(^RRRAlertViewBlock)(RRRAlertView *alertView ,NSInteger index);

@property (nonatomic, copy)  RRRAlertViewBlock indexBlock;

- (instancetype)initWithTitle:( NSString *)title message:( NSString *)message delegate:( id )delegate cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:( NSString *)otherButtonTitles, ...;

@end



//
//  RRRAlertView.m
//  RRRAlertViewDemo
//
//  Created by 张瑞想 on 2017/1/4.
//  Copyright © 2017年 张瑞想. All rights reserved.
//

#import "RRRAlertView.h"
#import "UILabel+Size.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

CGFloat lineMargin = 0.5;
CGFloat margin = 25;
CGFloat btnHeight = 44;

enum tag {
    beginTag = 101,
};

@interface RRRAlertView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSMutableArray *otherButtonTitles;
@property (nonatomic, strong) UIButton *maskView;
@property (nonatomic, assign) NSInteger buttonIndex;

@end


@implementation RRRAlertView

/**
 title
 message
 1. 取消 确定
 2. 取消
 3. 取消 确定 确定 确定。。。
 4.     确定
 5.     确定 确定 确定。。。
 */
- (instancetype)initWithTitle:( NSString *)title message:( NSString *)message cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:( NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _buttonIndex = 0;
        _title = title;
        _message = message;
        _cancelButtonTitle = cancelButtonTitle;
        
        if (otherButtonTitles.length > 0) {
            _otherButtonTitles = [NSMutableArray array];
            
            NSString *eachItem = otherButtonTitles;
            va_list argumentList ;
            va_start(argumentList, otherButtonTitles);
            do {
                if (eachItem) {
                    [_otherButtonTitles addObject:eachItem];
                }
            } while ((eachItem = va_arg(argumentList, NSString *)));
            va_end(argumentList);
        }
        
        
        [self initWindow];
    }
    return self;
}

#pragma mark - event response

- (void)cancelButtonAction
{
    [_maskView removeFromSuperview];
    [self removeFromSuperview];
    
    _buttonIndex = 0;
    
    if (self.indexBlock) {
        // 传参
        self.indexBlock(self,_buttonIndex);
        
    }
    
}


- (void)otherButtonAction:(UIButton *)button
{
    [_maskView removeFromSuperview];
    [self removeFromSuperview];
    
    // 有取消
    if (_cancelButtonTitle.length > 0) {
        _buttonIndex = button.tag - beginTag + 1;
    } else {
        _buttonIndex = button.tag - beginTag;
    }
    
    
    if (self.indexBlock) {
        // 传参
        self.indexBlock(self,_buttonIndex);
    }
}

// 初始化
- (void)initWindow
{
    self.layer.cornerRadius = 10;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
   
    
    // mask
    _maskView = [[UIButton alloc] initWithFrame:window.bounds];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    [window addSubview:_maskView];
    [_maskView addSubview:self];

    
    CGFloat spaceX = 0.0;
    CGFloat spaceY = 0.0;

    CGFloat height = 0;
    
    
    // title
    if (_title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.text = _title;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];

        CGSize size = [titleLabel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - margin*2, MAXFLOAT)];
        titleLabel.frame = CGRectMake(spaceX, spaceY, size.width, size.height);
        titleLabel.center = CGPointMake((SCREEN_WIDTH - margin*2)/2.0, titleLabel.center.y);
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        height += size.height;
        spaceY += CGRectGetHeight(titleLabel.frame);
    }
    
    // message
    if (_message.length > 0) {
        UILabel *messageLabel = [[UILabel alloc] init];
        [self addSubview:messageLabel];
        messageLabel.text = _message;
        messageLabel.numberOfLines = 0;
        CGSize size = [messageLabel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - margin*2, MAXFLOAT)];
        messageLabel.frame = CGRectMake(spaceX, spaceY, size.width, size.height);
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.center = CGPointMake((SCREEN_WIDTH - margin*2)/2.0, messageLabel.center.y);
        messageLabel.textColor = [UIColor lightGrayColor];
        
        height += size.height;
        spaceY += CGRectGetHeight(messageLabel.frame);
    }
    
    
    // 横线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    line.frame = CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin);
    
    height += 1;
    spaceY += 1;
    
    
    // 取消 确定
    if (_cancelButtonTitle.length > 0 && _otherButtonTitles.count == 1) {
        
        // 取消 ===============================
        CGRect fram = CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2)/2, btnHeight);
        [self addCancelButtonWithFram:fram];
       
        spaceX += fram.size.width;
        
        // 竖线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        line.frame = CGRectMake((SCREEN_WIDTH - margin*2)/2,spaceY, lineMargin, btnHeight);
        
        spaceX += 1;
        
        // 确定 ===============================
        [self addOtherButtonWithTag:beginTag title:_otherButtonTitles[0] fram:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2)/2, btnHeight)];
        
        height += btnHeight;

    }
    
    
    // 取消
    //     确定
    if (_cancelButtonTitle.length == 0 || _otherButtonTitles.count == 0) {
        
        CGRect fram = CGRectMake(0, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight);

        // 确定 ===============================
        if (_cancelButtonTitle.length == 0) {
            [self addOtherButtonWithTag:beginTag title:_otherButtonTitles[0] fram:fram];
        }
        
        // 取消 ===============================
        if (_otherButtonTitles.count == 0) {
            [self addCancelButtonWithFram:fram];
        }
        
        height += btnHeight;
    }
    
    
    // 取消 确定 确定 确定。。。
    if (_cancelButtonTitle.length > 0 && _otherButtonTitles.count > 1) {
        
        // 确定 ===============================
        spaceX = 0;
        
        for (int i = 0; i < _otherButtonTitles.count; i ++) {
            if (i > 0) {
                spaceY += btnHeight;
                // 横线
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:line];
                line.frame = CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin);
                
            }
            height += btnHeight;
            
            [self addOtherButtonWithTag:beginTag + i title:_otherButtonTitles[i] fram:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight)];
        }
        
        spaceY += btnHeight;
        
        // 横线
        [self addHorizontalLineWithFram:CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin)];
        
        // 取消 ===============================
        [self addCancelButtonWithFram:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight)];

        height += btnHeight;
    }
   
    
    // 确定 确定 确定。。。
    if (_cancelButtonTitle.length == 0 && _otherButtonTitles.count > 1) {
        // 确定 ===============================
        spaceX = 0;
        
        for (int i = 0; i < _otherButtonTitles.count; i ++) {
            if (i > 0) {
                spaceY += btnHeight;
                // 横线
                [self addHorizontalLineWithFram:CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin)];
            }
            height += btnHeight;
            
            [self addOtherButtonWithTag:beginTag + i title:_otherButtonTitles[i] fram:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight)];
        }
        
        height -= btnHeight;
    }
    
    
    // self
    self.frame = CGRectMake(margin, 0, SCREEN_WIDTH - margin*2, height);
    self.center = _maskView.center;
}

#pragma mark - private methods
- (void)addCancelButtonWithFram:(CGRect)fram
{
    // 取消 ===============================
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:fram];
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelButton.tag = beginTag;
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
}

- (void)addOtherButtonWithTag:(NSInteger )tag title:(NSString *)title fram:(CGRect)fram
{
    // 确定 ===============================
    UIButton *otherButton = [[UIButton alloc] initWithFrame:fram];
    otherButton.tag = tag;
    [otherButton setTitle:title forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    otherButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [otherButton addTarget:self action:@selector(otherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:otherButton];
}

- (void)addHorizontalLineWithFram:(CGRect)fram
{
    // 横线
    UIView *line = [[UIView alloc] initWithFrame:fram];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
}
@end

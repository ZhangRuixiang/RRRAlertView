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

CGFloat controlsMargin = 10;
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
 2. 取消/确定
 3. 取消 确定 确定 确定。。。
 4.     确定 确定 确定。。。
 */
- (instancetype)initWithTitle:( NSString *)title message:( NSString *)message cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:( NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleFont = 17;
        _titleColor = [self hexStringToColor:@"#666666"];
        _messageFont = 14;
        _messageColor = [self hexStringToColor:@"#999999"];
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
    _buttonIndex = 0;
    
    if (self.indexBlock) {
        
        // 传参
        self.indexBlock(self,_buttonIndex);
        
    }
    
    [_maskView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)otherButtonAction:(UIButton *)button
{
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
    
    [_maskView removeFromSuperview];
    [self removeFromSuperview];
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
    spaceX += controlsMargin;

    CGFloat spaceY = 0.0;
    spaceY += controlsMargin;

    CGFloat height = 0;
    height += controlsMargin;
    
    // title
    if (_title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.text = _title;
        titleLabel.font = [UIFont boldSystemFontOfSize:_titleFont];
        titleLabel.textColor = _titleColor;
        
        CGSize size = [titleLabel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - margin*2, MAXFLOAT)];
        titleLabel.frame = CGRectMake(spaceX, spaceY, size.width, size.height);
        titleLabel.center = CGPointMake((SCREEN_WIDTH - margin*2)/2.0, titleLabel.center.y);
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        spaceY += CGRectGetHeight(titleLabel.frame);
        spaceY += controlsMargin;
        height += size.height;
        height += controlsMargin;
    }
    
    // message
    if (_message.length > 0) {
        UILabel *messageLabel = [[UILabel alloc] init];
        [self addSubview:messageLabel];
        messageLabel.font = [UIFont systemFontOfSize:_messageFont];
        messageLabel.textColor = _messageColor;
        messageLabel.text = _message;
        
        CGSize size = [messageLabel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - margin*2 - controlsMargin*2, MAXFLOAT)];
        messageLabel.frame = CGRectMake(spaceX, spaceY, size.width, size.height);
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        messageLabel.center = CGPointMake((SCREEN_WIDTH - margin*2 - controlsMargin*2)/2.0, messageLabel.center.y);
        
        spaceX -= controlsMargin;
        spaceY += CGRectGetHeight(messageLabel.frame);
        spaceY += controlsMargin;
        height += size.height;
        height += controlsMargin;
    }
    
    
    // 横线
    [self addHorizontalLineWithframe:CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin)];
    
    height += 1;
    spaceY += 1;
    
    
    // 取消 确定
    if (_cancelButtonTitle.length > 0 && _otherButtonTitles.count == 1) {
        
        // 取消 ===============================
        CGRect frame = CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2)/2, btnHeight);
        [self addCancelButtonWithFrame:frame];
       
        spaceX += frame.size.width;
        
        // 竖线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        line.frame = CGRectMake((SCREEN_WIDTH - margin*2)/2,spaceY, lineMargin, btnHeight);
        
        spaceX += 1;
        
        // 确定 ===============================
        [self addOtherButtonWithTag:beginTag title:_otherButtonTitles[0] frame:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2)/2, btnHeight)];
        
        height += btnHeight;

    }
    
    
    // 取消/确定
    if (_cancelButtonTitle.length == 0 || _otherButtonTitles.count == 0) {
        
        CGRect frame = CGRectMake(0, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight);

        // 确定 ===============================
        if (_cancelButtonTitle.length == 0) {
            [self addOtherButtonWithTag:beginTag title:_otherButtonTitles[0] frame:frame];
        }
        
        // 取消 ===============================
        if (_otherButtonTitles.count == 0) {
            [self addCancelButtonWithFrame:frame];
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
                [self addHorizontalLineWithframe:CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin)];
                
            }
            height += btnHeight;
            
            [self addOtherButtonWithTag:beginTag + i title:_otherButtonTitles[i] frame:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight)];
        }
        
        spaceY += btnHeight;
        
        // 横线
        [self addHorizontalLineWithframe:CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin)];
        
        // 取消 ===============================
        [self addCancelButtonWithFrame:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight)];

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
                [self addHorizontalLineWithframe:CGRectMake(0,spaceY, SCREEN_WIDTH - margin*2, lineMargin)];
            }
            height += btnHeight;
            
            [self addOtherButtonWithTag:beginTag + i title:_otherButtonTitles[i] frame:CGRectMake(spaceX, spaceY,  (SCREEN_WIDTH - margin*2), btnHeight)];
        }
        
        height -= btnHeight;
    }
    
    
    // self
    self.frame = CGRectMake(margin, 0, SCREEN_WIDTH - margin*2, height);
    self.center = _maskView.center;
}

#pragma mark - private methods
- (void)addCancelButtonWithFrame:(CGRect)frame
{
    // 取消 ===============================
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:frame];
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor:[self hexStringToColor:@"#0062FD"] forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelButton.tag = beginTag;
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
}

- (void)addOtherButtonWithTag:(NSInteger )tag title:(NSString *)title frame:(CGRect)frame
{
    // 确定 ===============================
    UIButton *otherButton = [[UIButton alloc] initWithFrame:frame];
    otherButton.tag = tag;
    [otherButton setTitle:title forState:UIControlStateNormal];
    [otherButton setTitleColor:[self hexStringToColor:@"#FE3A35"] forState:UIControlStateNormal];
    otherButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [otherButton addTarget:self action:@selector(otherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:otherButton];
}

- (void)addHorizontalLineWithframe:(CGRect)frame
{
    // 横线
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
}

- (UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end

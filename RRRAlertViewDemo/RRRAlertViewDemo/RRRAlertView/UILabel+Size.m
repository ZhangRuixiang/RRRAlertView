//
//  UILabel+Size.m
//  RRRAlertViewDemo
//
//  Created by 张瑞想 on 2017/1/9.
//  Copyright © 2017年 张瑞想. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)
- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize;
}
@end

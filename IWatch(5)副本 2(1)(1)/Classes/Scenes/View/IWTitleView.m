//
//  IWTitleView.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍 All rights reserved.
//  导航栏内容(我的...);

#import "IWTitleView.h"

@implementation IWTitleView

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    [self setTitle:title forState:UIControlStateNormal];
    
    NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
    CGFloat titleW = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    
    self.width = titleW + self.titleEdgeInsets.left + self.currentImage.size.width;
}


@end

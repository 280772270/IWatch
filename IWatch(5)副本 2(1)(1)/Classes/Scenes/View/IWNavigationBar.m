//
//  IWNavigationBar.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//自定义导航栏(navigation)

#import "IWNavigationBar.h"

@implementation IWNavigationBar
-(void)layoutSubviews
{
    
   [super layoutSubviews];
for (UIButton *button in self.subviews) {
    if (![button isKindOfClass:[UIButton class]])continue;
    if (button.centerX < self.width * 0.5) {
        //修改导航栏左侧按钮距离
        button.x = 10;
    }
    else if(button.centerX > self.width * 0.5 )
    {
        //导航栏右侧按钮距离
        button.x = self.width - button.width -10;
    }
    
}
}

@end

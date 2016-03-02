//
//  UIBarButtonItem+IWExtension.m
//  IWatch
//
//  Created by 陈萍 on 15/11/7.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "UIBarButtonItem+IWExtension.h"
#import "UIView+IWExtension.h"
@implementation UIBarButtonItem (IWExtension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end

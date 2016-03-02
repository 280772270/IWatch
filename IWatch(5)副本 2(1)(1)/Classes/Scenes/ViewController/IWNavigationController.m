//
//  IWNavigationController.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//自定义导航栏控制器

#import "IWNavigationController.h"
#import "IWNavigationBar.h"
@interface IWNavigationController ()

@end

@implementation IWNavigationController



+(void)initialize
{
   UINavigationBar *apperarance = [UINavigationBar appearance];
//设置导航栏背景
//    UIImage *bacImage = [UIImage imageNamed:@"blackk@2x.png"];
//    UIView *bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, screenFrame.size.width, 44)];
//    UIImageView *imagBac = [[UIImageView alloc]initWithFrame:bacView.frame];
//    [imagBac setImage:[UIImage imageNamed:@"nav.jpg"]];
//    UIImage *nnavImage = [UIImage imageNamed:@"NavPic.png"];

    if ([UIScreen mainScreen].bounds.size.width == (CGFloat)375) {
        
        [apperarance setBackgroundImage:[UIImage imageNamed:@"NavPic.png"] forBarMetrics:UIBarMetricsDefault];
    }else if ([UIScreen mainScreen].bounds.size.width == (CGFloat)320){
        [apperarance setBackgroundImage:[UIImage imageNamed:@"5s版title.png"] forBarMetrics:UIBarMetricsDefault];
    }

//    [apperarance addSubview:bacView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //换为自定义导航栏
    [self setValue:[[IWNavigationBar alloc] init] forKey:@"navigationBar"];
    
}


@end

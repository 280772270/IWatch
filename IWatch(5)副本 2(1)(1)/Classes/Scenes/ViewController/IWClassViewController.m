//
//  IWClassViewController.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
// 分类界面控制器

#import "IWClassViewController.h"
@interface IWClassViewController ()
@end

@implementation IWClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createdUI];
}

//更新UI
-(void)createdUI
{
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *Topimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
    UIImage *image = [UIImage imageNamed:@"bg_nav"];
    Topimageview.image = image;
    [self.view addSubview:Topimageview];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    backbutton.frame = CGRectMake(10, 25, 30, 30);
    [backbutton setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
    [self.view addSubview:backbutton];
    [backbutton addTarget:self action:@selector(backDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}
//返回上一页
-(void)backDidClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"back");
    }];

}

@end

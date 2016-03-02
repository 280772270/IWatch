//
//  IWAdViewController.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//封面界面

#import "IWAdViewController.h"
#import "IWMenuViewController.h"
@interface IWAdViewController ()

@end

@implementation IWAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    //背景图片
    UIImageView *bg = [[UIImageView alloc]init];
    bg.image = [UIImage imageNamed:@"1.png"];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    //图片渐现设置
    bg.alpha = 0;
    [UIView animateWithDuration:2.0f animations:^{
        bg.alpha = 1;
    }];
    //广告图片(真实广告要通过网络加载)
    UIImageView *ad = [[UIImageView alloc]init];
    ad.image = [UIImage imageNamed:@"广告图片"];
    ad.width = 280;
    ad.height = 300;
    ad.centerX = self.view.width *0.5;
    ad.y = 60;
    [self.view addSubview:ad];
    
    //设置进入主页button
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(150, 300, 75, 40);
    [button1 setTitle:@"进入IW" forState:UIControlStateNormal];
    [self putin];
}
//button点击事件进入主页
-(void)putin
{
    //经过0.1秒后进入主界面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Main"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

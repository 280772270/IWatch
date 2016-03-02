//
//  IWLeftMenu.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//左侧菜单栏

#import "IWLeftMenu.h"

@interface IWLeftMenu ()
@property(nonatomic,weak)UIButton *selectedButton;

@end
@implementation IWLeftMenu
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
//        CGFloat alph = 0.2;
        
        UIButton *newsButton = [self setupButWithIcon:nil title:@"  Watch"  withTag:0];
        [self buttonClick:newsButton];
        
        [self setupButWithIcon:nil title:@"  Watched"withTag:1];
//        [self setupButWithIcon:@"下载白0" title:@"  Mine"  withTag:2];
        
       // [self setupButWithIcon:@"sidebar_nav_video" title:@"设置工具"  withTag:3];
        //[self setupButWithIcon:@"sidebar_nav_comment" title:@"" bgcolo:HMColorRGBA(170,172,73,alpha) withTag:4];
        //[self setupButWithIcon:@"sidebar_nav_radio" title:@"" bgcolo:HMColorRGBA(190,62,119,alpha) withTag:5];
        
    }
    return self;
}

-(UIButton *)setupButWithIcon:(NSString *)icon title:(NSString *)title withTag:(NSInteger)tag
{
    UIButton *but = [[UIButton alloc]init];
    but.tag = tag;
    [but addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:17];
    //设置高亮的时候不要让图标变色
    but.adjustsImageWhenHighlighted = NO;
    UIColor *bgcolor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    //设置按钮选中的背景
    [but setBackgroundImage:[UIImage imageWithColor:bgcolor] forState:UIControlStateSelected];
    //设置小图片与内容间距
    but.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //设置按钮的内容左对齐
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //设置按钮与边界距离
    but.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [self addSubview:but];
    return but;
    
}

-(void)setDelegate:(id<LeftmenuDelegate>)delegate
{
    _delegate = delegate;
    [self buttonClick:[self.subviews firstObject]];
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮的frame
    long btnCount = self.subviews.count;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    for (int i = 0 ; i < btnCount; i ++) {
        UIButton *but = self.subviews[i];
        but.width = btnW;
        but.height = btnH;
        but.y = i * btnH;
    }
    
}



#pragma mark   监听按钮的点击事件
-(void)buttonClick:(UIButton *)button
{
    //1,通知代理
    if ([self.delegate respondsToSelector:@selector(leftMenu:didSelectedButtonFormIndex:toIndex:)]) {
        [self.delegate leftMenu:self didSelectedButtonFormIndex:(int)self.selectedButton.tag toIndex:(int)button.tag];
//        NSLog(@"%ld", button.tag);
    }
    //2,控制按钮状态
    self.selectedButton.selected = NO;
    button.selected= YES;
    self.selectedButton = button;
}






@end

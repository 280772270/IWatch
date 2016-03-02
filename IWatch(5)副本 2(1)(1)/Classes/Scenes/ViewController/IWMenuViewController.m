//
//  IWMenuViewController.m
//  IWatch
//
//  Created by 陈萍on 15/11/5.
//  Copyright © 2015年 陈萍 All rights reserved.
//主控制器

#import "IWMenuViewController.h"
#import "IWLeftMenu.h"
#import "IWNavigationController.h"
#import "IWCollectionViewController.h"
#import "IWCacheViewController.h"
#import "IWSetViewController.h"
#import "UIView+IWExtension.h"
#import "FZListViewController.h"
#import "IWRankingViewController.h"
#import "IWTitleView.h"
#import "IWClassViewController.h"
#define listUrlStr @"http://baobab.wandoujia.com/api/v1/categories.Bak?"
#define postUrl @"http://baobab.wandoujia.com/api/v1/ranklist.bak?strategy=";
#define FZcovertag 100
#define FZLeftMenuW 150
#define FZLeftMenuH 500
#define FZLeftMenuY 60
@interface IWMenuViewController ()<LeftmenuDelegate>
{
    BOOL _flag;
}
@property(nonatomic,strong)IWNavigationController *showingNavigationController;
@property(nonatomic,weak)IWLeftMenu *leftmeu;
@property(nonatomic,strong)UIView *myView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation IWMenuViewController

- (void)viewDidLoad {
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, 64, screenFrame.size.width, screenFrame.size.height-64);
    UIImageView *myviewImaView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"myView"]];
    myviewImaView.frame = CGRectMake(0, 0, self.myView.frame.size.width, self.myView.frame.size.height);
    [self.myView insertSubview:myviewImaView atIndex:1];
    self.dataArr = [NSMutableArray new];
    [self analyzing];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAllChildVcs];
    [self setleftMenu];
    _flag = NO;
    
}
-(void)analyzing{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:listUrlStr]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        for (NSDictionary *baseClassModel in dict) {
            ZZBaseClass *model = [ZZBaseClass modelObjectWithDictionary:baseClassModel];
            [self.dataArr addObject:model];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

-(void)setupAllChildVcs
{
   
    //创建子控制器(新闻控制器)
    IWRankingViewController *ranking = [[IWRankingViewController alloc]init];
    [self setupVc:ranking title:@" "];
    
    IWCacheViewController *news = [[IWCacheViewController alloc]init];
    [self setupVc:news title:@""];
    
    
    IWCollectionViewController *reading = [[IWCollectionViewController alloc]init];
    [self setupVc:reading title:@"Mine"];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//创建左侧菜单栏
-(void)setleftMenu
{
    //添加左侧菜单
    IWLeftMenu *leftmenu = [[IWLeftMenu alloc]init];
    leftmenu.delegate = self;
    
    leftmenu.height = FZLeftMenuH;
    leftmenu.width = FZLeftMenuW;
    leftmenu.y = FZLeftMenuY;
    [self.view insertSubview:leftmenu atIndex:1];
    self.leftmeu = leftmenu;
}

#pragma mark 配置背景字体颜色高亮
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)setupVc:(UIViewController *)vc title:(NSString *)title
{
    //设置背景色
    //    vc.view.backgroundColor = [UIColor blackColor];
    IWTitleView *titleview = [[IWTitleView alloc]init];
    titleview.title = title;
    vc.navigationItem.titleView = titleview;
        //左边按钮
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"lleft" target:self action:@selector(leftMenuClick:)];
    //右边按钮
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"rright" target:self action:@selector(rightMenuClick:)];
    //包装一个导航控制器
    IWNavigationController *nav = [[IWNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}
#pragma mark ---监听导航栏点击事件
//左边点击事件
-(void)leftMenuClick:(UITabBarItem *)sender
{
    if (_flag == YES) {
        return;
    }else if (_flag == NO){
        [UIView animateWithDuration:0.5 animations:^{
            //取出正在显示的导航栏控制器
            UIView *showingView = self.showingNavigationController.view;
            //缩放比例
            CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2*FZLeftMenuY;
            CGFloat scale = navH/[UIScreen mainScreen].bounds.size.height;
            //菜单左边的间距
            CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width *(1-scale)*0.5;
            CGFloat translateX = FZLeftMenuW - leftMenuMargin;
            CGFloat topMargin = [UIScreen mainScreen].bounds.size.height *(1 - scale) *0.5;
            CGFloat transLateY = FZLeftMenuY - topMargin;
            //缩放
            CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
            //平移
            CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm,
                                                                         translateX/scale, transLateY/scale);
            showingView.transform = translateForm;
            
            //添加一个遮盖
            UIButton *cover = [[UIButton alloc]init];
            [cover addTarget:self action:@selector(coverAction:) forControlEvents:UIControlEventTouchUpInside];
            cover.tag = FZcovertag;
            cover.frame = showingView.bounds;
            [showingView addSubview:cover];
            
        }];
    }
}

//添加遮盖点击事件
-(void)coverAction:(UIView *)cover
{
    [UIView animateWithDuration:0.25 animations:^{
        self.showingNavigationController.view.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}


//右边点击事件
-(void)rightMenuClick:(UIBarButtonItem *)sender
{
//    sender.image = [UIImage imageNamed:@"back"];
    if (_flag == NO) {
        self.myView.alpha = 0;
        //动画
        self.myView.center = CGPointMake(screenFrame.size.width/2, -screenFrame.size.height);
        [UIView animateWithDuration:0.7 animations:^{
            self.myView.alpha = 1;
            self.myView.center = CGPointMake(screenFrame.size.width/2, screenFrame.size.height/2 + 32);
            [self setupAllChildVcs];

        }];
        int taa = 0;
        for (int i  = 0 ; i < 3; i ++) {
            for (int j = 0; j < 4; j ++) {
                UIButton *buuu = [[UIButton alloc]init];
                buuu.frame = CGRectMake(i * screenFrame.size.width/3 + 1,2 + j * screenFrame.size.width/3 + 1 , screenFrame.size.width/3 -3, screenFrame.size.width/3 - 3);
                ZZBaseClass *model = self.dataArr[taa];
                [self setButtonWithModel:model forButton:buuu];
                buuu.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
                [buuu addTarget:self action:@selector(nsl:) forControlEvents:UIControlEventTouchUpInside];
                self.myView.backgroundColor = [UIColor whiteColor];
                [self.myView addSubview:buuu];
                buuu.tag = taa;
                taa ++;
            }
        }
        
        [self.view addSubview:self.myView];
        _flag = 1;
    }
    else if (_flag == YES)
    {
        [UIView animateWithDuration:0.7 animations:^{
//            self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"lleft" target:self action:@selector(leftMenuClick)];
            self.myView.alpha = 0.5;
            self.myView.center = CGPointMake(screenFrame.size.width/2,-1900);
        }completion:^(BOOL finished) {
            [self.myView removeFromSuperview];
            _flag = NO;
        }];
    }
}
-(void)nsl:(UIButton *)sender{
    [UIView animateWithDuration:0.7 animations:^{
        self.myView.alpha = 0.5;
        self.myView.center = CGPointMake(screenFrame.size.width/2,-1900);
    }completion:^(BOOL finished) {
        ZZBaseClass *model =  self.dataArr[sender.tag];
        FZListViewController *kVC = [[FZListViewController alloc]init];
        [self.showingNavigationController pushViewController:kVC animated:1];
        kVC.Listnames = model.name;
        [self.myView removeFromSuperview];
        _flag = NO;
    }];
    
}
//私有方法设置Button
-(void)setButtonWithModel:(ZZBaseClass *)model forButton:(UIButton*)button{
    CGSize size = button.frame.size;
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    nameLabel.textAlignment = 1;
    nameLabel.text = [NSString stringWithFormat:@"#%@",model.name];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.center = CGPointMake(size.width/2, size.height/2);
    UIImageView *bacIma = [[UIImageView alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:18];
    bacIma.frame = button.frame;
    [bacIma sd_setImageWithURL:[NSURL URLWithString:model.bgPicture]];
        [self.myView insertSubview:bacIma belowSubview:button];
    [bacIma setUserInteractionEnabled:YES];
    [button.imageView sd_setImageWithURL:[NSURL URLWithString:model.bgPicture]];
    [button addSubview:nameLabel];
}
#pragma mark --代理实现

-(void)leftMenu:(IWLeftMenu *)menu didSelectedButtonFormIndex:(int)formIndex toIndex:(int)toIndex
{
    //1,移除旧控制器
    IWNavigationController *oldNav = self.childViewControllers[formIndex];
    [oldNav.view removeFromSuperview];
    
    //2,显示添加新控制器
    IWNavigationController *newNav = self.childViewControllers[toIndex];
    [self.view addSubview:newNav.view];
    //设置新控制器的form跟旧控制器一样
    newNav.view.transform = oldNav.view.transform;
    //设置阴影
    newNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-5, 0);
    newNav.view.layer.shadowOpacity = 0.2;
    
    //3,设置当前正在显示的控制器
    self.showingNavigationController = newNav;
    
    //4,点击遮盖
    [self coverAction:[newNav.view viewWithTag:FZcovertag]];
}























@end

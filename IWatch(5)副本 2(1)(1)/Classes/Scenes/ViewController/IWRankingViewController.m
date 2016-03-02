//
//  IWRankingViewController.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//每日推荐

#import "IWRankingViewController.h"
#import "IWRankingTableView.h"
#import "IWRankingScrollView.h"
#import "FZMenuTableViewCell.h"
#import "messageViewController.h"
#define scrollwidth 5*375
#define screenFrame [UIScreen mainScreen].bounds
@interface IWRankingViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)IWRankingScrollView *scrollerVIew;
@property(nonatomic,strong)NSMutableDictionary *rootDataDict;
@property(nonatomic,strong)NSMutableArray *controllets;
//@property(nonatomic,strong)
@end

@implementation IWRankingViewController
-(void)loadView{
    [super loadView];
    [self analyzing];
    self.rootDataDict = [NSMutableDictionary new];
    self.controllets = [NSMutableArray new];
    self.count = 10;
    _scrollerVIew = [[IWRankingScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _scrollerVIew.contentSize  = CGSizeMake(screenFrame.size.width*self.count, screenFrame.size.height -32);
    _scrollerVIew.pagingEnabled = YES;
    for (NSInteger i = 0; i < self.count; i++) {
        IWRankingTableView *tableView =[[IWRankingTableView alloc]initWithFrame:CGRectMake(screenFrame.size.width *i, screenFrame.origin.y, screenFrame.size.width, screenFrame.size.height - 64)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.backgroundColor = [UIColor blackColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_scrollerVIew addSubview:tableView];
        [self.controllets addObject:tableView];
    }
    
    [self.view addSubview:_scrollerVIew];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}
-(void)analyzing{
    [[IWatchNetHelper sharedHelper]everyDayListDictionaryWithDayCount:10 withDateString:[self getdate] withPageOptional:FRONT withDidFinished:^{
        //获取到每5日列表Dict
        NSArray *dailyArr = [IWatchNetHelper sharedHelper].dialyListDict[@"dailyList"];
        //拿到5天的列表  容器初始化
        NSMutableArray *dayArr = [NSMutableArray new];
        //创建Key
        NSString *dayKey ;
        //遍历每天列表
        for (int i = 0; i < dailyArr.count; i ++) {
            //拿到每天列表的字典
            NSDictionary *TempModel = dailyArr[i];
            for (NSDictionary *ttmodel in TempModel[@"videoList"]) {
                //创建模型并且初始化
                ZZVideoList *model = [ZZVideoList modelObjectWithDictionary:ttmodel];
                //加到容器里
                [dayArr addObject:model];
                //标记一个key
                dayKey = [NSString stringWithFormat:@"%d",i];
            }
            //加到根数据库
            NSArray *tt = [NSArray arrayWithArray:dayArr];
            [self.rootDataDict setValue:tt forKey:dayKey];
            [dayArr removeAllObjects];
        }
        for (UITableView *tab in self.controllets) {
            [tab reloadData];
            [[dataBaseHelper shareInstance]setDataBase:self.rootDataDict];
        }
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (screenFrame.size.height-64)/2.5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *keysArr = [self.rootDataDict allKeys];
    for (int i = 0; i < keysArr.count ; i ++) {
        if (tableView.tag == i) {
            return 1;
        }
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *keysArr = [self.rootDataDict allKeys];
    for (int i = 0; i < keysArr.count; i ++) {
        if (tableView.tag == i) {
            NSString *key = [NSString stringWithFormat:@"%d",i];
            NSArray *arr = self.rootDataDict[key];
            return arr.count;
        }
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"FZMenuTableViewCell";
    FZMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FZMenuTableViewCell" owner:self options:nil] lastObject];
    }
    NSArray *keysArr = [self.rootDataDict allKeys];
    for (int i = 0; i < keysArr.count; i ++) {
        if (tableView.tag == i) {
            NSString *key = [NSString stringWithFormat:@"%d",i];
            NSArray *arr = self.rootDataDict[key];
            ZZVideoList *model = [[ZZVideoList alloc]init];
            model = arr[indexPath.row];
            [cell receiveNews:model];
            return cell;
        }
    }
   
    return cell;
}
-(NSTimeInterval )getdate{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]* 1000;
    return a;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *key = [NSString stringWithFormat:@"%ld",[self getPage]];
    NSArray *infoArr = self.rootDataDict[key];
    ZZVideoList *model = infoArr[indexPath.row];
    messageViewController *mVC = [[messageViewController alloc]init];
    mVC.model = model;
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    [self.navigationController pushViewController:mVC animated:1];
}
-(NSInteger)getPage{
    CGFloat offsetX = _scrollerVIew.contentOffset.x;
    NSInteger page = offsetX/screenFrame.size.width ;
//    NSLog(@"%lu",page);
    return page;
}



@end

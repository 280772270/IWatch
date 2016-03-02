//
//  IWCacheViewController.m
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//收藏

#import "IWCacheViewController.h"
#import "ZZVideoList.h"
#import "FZMenuTableViewCell.h"
#import "messageViewController.h"
@interface IWCacheViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableVIew;
@end

@implementation IWCacheViewController
-(void)loadView{
    [super loadView];
    [self setUpUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.mainTableVIew reloadData];
    self.mainTableVIew.dataSource = self;
    self.mainTableVIew.delegate = self;
    self.mainTableVIew.backgroundColor = [UIColor blackColor];
    self.mainTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStyleDone target:nil action:nil];
//    NSLog(@"%@",[dataBaseHelper shareInstance].dataBaseDict);
}
-(void)setUpUI{
    self.mainTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height - 64)];
    [self.view addSubview:_mainTableVIew];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataBaseHelper shareInstance].collectArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"FZMenuTableViewCell";
    FZMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FZMenuTableViewCell" owner:self options:nil] lastObject];
    }
    ZZVideoList *model = [dataBaseHelper shareInstance].collectArr[indexPath.row];
    [cell receiveNews:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (screenFrame.size.height-64)/2.5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZVideoList *model = [dataBaseHelper shareInstance].collectArr[indexPath.row];
    messageViewController *mvc = [[messageViewController alloc]init];
    mvc.model = model;
    [self.navigationController pushViewController:mvc animated:1];
    [tableView deselectRowAtIndexPath:indexPath animated:1];
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

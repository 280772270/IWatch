//
//  FZListViewController.m
//  jiekouTestProject
//
//  Created by 陈萍 on 15/11/13.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "FZListViewController.h"
#import "FZListView.h"
#import "AFNetworking.h"
//#import "FZMenuModel.h"
#import "FZMenuTableViewCell.h"
#import "UIImageView+WebCache.h"
//#import "FZSecondViewController.h"
#import "messageViewController.h"
@interface FZListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)FZListView *fzview;
@property(nonatomic,strong)NSMutableArray *videoArray;
@end

@implementation FZListViewController

-(void)loadView
{
    
    self.fzview = [[FZListView alloc]init];
    self.fzview.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height - 64);
    self.view = self.fzview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back.png" target:self action:@selector(leftMenuClick:)];

    self.fzview.ListTableView.delegate = self;
    self.fzview.ListTableView.dataSource = self;
    NSString *str = [NSString stringWithFormat:@"http://baobab.wandoujia.com/api/v1/videos.bak?strategy=date&categoryName=%@&num=10",self.Listnames];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"%@",dict);
        for (NSDictionary *dicts in dict[@"videoList"]) {
            ZZVideoList *model = [ZZVideoList modelObjectWithDictionary:dicts];
            [self.videoArray addObject:model];
        }
        [self.fzview.ListTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}

-(NSMutableArray *)videoArray
{
    if (!_videoArray) {
        _videoArray = [[NSMutableArray alloc]init];
    }
    return _videoArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"FZMenuTableViewCell";
    FZMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FZMenuTableViewCell" owner:self options:nil] lastObject];
    }
   ZZVideoList *model = [[ZZVideoList alloc]init];
    //NSString *key = self.keysArr[indexPath.section];
    model = self.videoArray[indexPath.row];
    cell.FZTitle.text = model.title;
    cell.FZTypelable.text = [model.category stringByAppendingString:@"  /"];
    [cell.FZMenuimageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
    cell.FZTimeLable.text = [self timeStrFormTime:model.duration ];
    return cell;
}

//返回高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (screenFrame.size.height-64)/2.5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消cell选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     messageViewController*secondVC = [[messageViewController alloc]init];
    ZZVideoList *model = [[ZZVideoList alloc]init];
    //NSString *key = self.keysArr[indexPath.section];
    model = self.videoArray[indexPath.row];
//    secondVC.Urlstr = model.playUrl;
//    [self showDetailViewController:secondVC sender:nil];
    secondVC.model = model;
    [self.navigationController pushViewController:secondVC animated:1];
    
}


//转换时间格式
-(NSString *)timeStrFormTime:(float)time
{
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}

-(void)leftMenuClick:(id)sender{
    [self.navigationController popViewControllerAnimated:1];
}









@end

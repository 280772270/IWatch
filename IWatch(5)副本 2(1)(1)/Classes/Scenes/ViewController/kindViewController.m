//
//  kindViewController.m
//  IWatch
//
//  Created by 陈萍 on 15/11/16.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "kindViewController.h"
#import "FZMenuTableViewCell.h"
#import "FZMenuTableViewCell.h"
#import "messageViewController.h"
@interface kindViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTabVIew;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation kindViewController
-(void)loadView{
    [super loadView];
    self.dataArr = [NSMutableArray new];
    [self analyzing];
    [self.view addSubview:self.mainTabVIew];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTabVIew.delegate = self;
    self.mainTabVIew.dataSource = self;
    self.view.backgroundColor = [UIColor blackColor];
//    NSLog(@"%@",self.dataArr);
    [self.view addSubview:self.mainTabVIew];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back.png" target:self action:@selector(leftMenuClick:)];
    // Do any additional setup after loading the view.
}
-(void)analyzing{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.receIveUrlStr]];
//    NSLog(@"%@",self.receIveUrlStr);
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

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%lu",self.dataArr.count);
    return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (screenFrame.size.height-64)/2.5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FZMenuTableViewCell *cell = [[FZMenuTableViewCell alloc]init];
    return cell;
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

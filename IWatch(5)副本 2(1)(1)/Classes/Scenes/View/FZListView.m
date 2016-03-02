//
//  FZListView.m
//  jiekouTestProject
//
//  Created by 陈萍 on 15/11/13.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "FZListView.h"

@implementation FZListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self created];
    }
    return self;
}


-(void)created
{
    self.ListTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.ListTableView.backgroundColor = [UIColor blackColor];
    self.ListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.ListTableView];
}
@end

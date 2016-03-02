//
//  FZMenuTableViewCell.m
//  jiekouTestProject
//
//  Created by 陈萍 on 15/11/2.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "FZMenuTableViewCell.h"
@implementation FZMenuTableViewCell
-(void)receiveNews:(ZZVideoList *)model
{
    
    [self.FZMenuimageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
    self.FZTitle.font = [UIFont boldSystemFontOfSize:20.0f];
    self.FZTitle.text = model.title;
    self.FZTypelable.text = [NSString stringWithFormat:@"#%@",model.category];
    self.FZTimeLable.text = [self getTime:model.duration];//[NSString stringWithFormat:@"%.0f",model.duration];
    
}
-(NSString *)getTime:(NSInteger)time {
    NSInteger min;
    NSInteger sec;
    min = time / 60;
    sec = time % 60;
    return [NSString stringWithFormat:@"%.2ld'%.2ld\"",min,sec];
}

@end

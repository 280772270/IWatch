//
//  FZMenuTableViewCell.h
//  jiekouTestProject
//
//  Created by 陈萍on 15/11/2.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZVideoList.h"
@interface FZMenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *FZMenuimageView;
@property (weak, nonatomic) IBOutlet UILabel *FZTitle;
@property (weak, nonatomic) IBOutlet UILabel *FZTypelable;
@property (weak, nonatomic) IBOutlet UILabel *FZTimeLable;
-(void)receiveNews:(ZZVideoList *)model;
@end
//今天感觉正常了吗
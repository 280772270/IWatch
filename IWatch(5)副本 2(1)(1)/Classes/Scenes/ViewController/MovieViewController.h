//
//  MovieViewController.h
//  I Watch
//
//  Created by 陈萍 on 15/11/10.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MovieViewController : UIViewController
@property(nonatomic,strong)NSString *UrlString;
@property(nonatomic,strong)ZZVideoList *receiveModel;
@end

//
//  AppDelegate.h
//  IWatch
//
//  Created by 陈萍 on 15/11/4.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol stop <NSObject>
//@property(nonatomic,assign)id <stop>delegate;
-(void)stopPlay;

@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,assign)id <stop>delegate;

@property (strong, nonatomic) UIWindow *window;


@end


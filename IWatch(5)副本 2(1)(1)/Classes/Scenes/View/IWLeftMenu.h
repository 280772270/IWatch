//
//  IWLeftMenu.h
//  IWatch
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWLeftMenu;

@protocol LeftmenuDelegate <NSObject>

@optional
-(void)leftMenu:(IWLeftMenu *)menu didSelectedButtonFormIndex:(int)formIndex toIndex:(int)toIndex;


@end



@interface IWLeftMenu : UIView

@property(nonatomic,weak)id<LeftmenuDelegate>delegate;
@end

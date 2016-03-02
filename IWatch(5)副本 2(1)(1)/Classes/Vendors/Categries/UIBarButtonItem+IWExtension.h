//
//  UIBarButtonItem+IWExtension.h
//  IWatch
//
//  Created by 陈萍on 15/11/7.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIBarButtonItem (IWExtension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end
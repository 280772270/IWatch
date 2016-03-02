//
//  AppDelegate.m
//  IWatch
//
//  Created by 陈萍 on 15/11/4.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [dataBaseHelper shareInstance].dataBaseDict =  [[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"stop" object:nil];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(stopPlay)]) {
//        [self.delegate stopPlay];
//    }
//    else{
//        NSLog( @"no delegate");
//    }
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"play" object:nil];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults]setValue:[dataBaseHelper shareInstance].dataBaseDict forKey:@"data"];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

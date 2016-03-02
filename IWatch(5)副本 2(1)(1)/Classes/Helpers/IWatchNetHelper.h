//
//  IWatchNetHelper.h
//  IWatchNetHelper
//
//  Created by 陈萍on 15/11/5.
//  Copyright © 2015年 陈萍. All rights reserved.
//
typedef void(^returnDialyBlock)();
typedef enum {
    OFF = 0,
    NEXT ,
    FRONT
    
}pageModel;
typedef enum {
    weekly = 0,
    monthly,
    historical
}RankModel;
#import <Foundation/Foundation.h>
@interface IWatchNetHelper : NSObject
///返回单例
+(IWatchNetHelper *)sharedHelper;
///返回每日列表的字典
-(void)everyDayListDictionaryWithDayCount:(NSInteger )dayCount withDateString:(NSTimeInterval )dateInterVal withPageOptional:(pageModel )model withDidFinished:(returnDialyBlock)finish;
///返回结果字典
@property(nonatomic,strong)NSDictionary *dialyListDict;
///返回排名字典
-(void)rankListDictWithRankModel:(RankModel)model withDidFinished:(returnDialyBlock)finish;
@end

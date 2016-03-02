//
//  IWatchNetHelper.m
//  IWatchNetHelper
//
//  Created by 陈萍 on 15/11/5.
//  Copyright © 2015年 陈萍 All rights reserved.
///每日列表接口
#define dialyListStr @"http://baobab.wandoujia.com/api/v1/feed.bak?num=%ld&date=%@"
///排行接口
#define rankListStr @"http://baobab.wandoujia.com/api/v1/ranklist.bak?strategy="
#import "AFNetworking.h"
#import "IWatchNetHelper.h"
static IWatchNetHelper *helper;
@interface IWatchNetHelper() 
///每日字典的私有声明
@property(nonatomic,assign)NSInteger todaySet;
@end
@implementation IWatchNetHelper
//单例工具类初始化
+(IWatchNetHelper *)sharedHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            helper = [[IWatchNetHelper alloc]init];
    });
    return helper;
}

///每日解析
-(void)everyDayListDictionaryWithDayCount:(NSInteger)dayCount withDateString:(NSTimeInterval )dateInterVal withPageOptional:(pageModel )model withDidFinished:(returnDialyBlock)finish{
    NSString *urlStr = [NSString stringWithFormat:dialyListStr,dayCount,[self changeTime:dateInterVal withModel:model]];
    [self analyzWithUrlStr:urlStr withFinished:^{
        finish();
    }];
}
///排名解析
-(void)rankListDictWithRankModel:(RankModel)model withDidFinished:(returnDialyBlock)finish{
    NSString *toeStr;
    if (model == 0) {
        toeStr = @"weekly";
    }else if (model == 1){
        toeStr = @"monthly";
    }else if (model == 2){
        toeStr = @"historical";
    }
    NSString *rankUrlStr = [NSString stringWithFormat:@"%@%@",rankListStr,toeStr];
    [self analyzWithUrlStr:rankUrlStr withFinished:^{
        finish();
    }];
    
}
///解析的私有方法
-(void)analyzWithUrlStr:(NSString *)urlStr withFinished:(returnDialyBlock)finish{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        self.dialyListDict = dict;
        finish();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
///获取当天的时间（模式）
-(NSString *)changeTime:(NSTimeInterval )time withModel:(pageModel)model{
    if (model == 0) {
        time = time;
    }
    else if (model == 1){
       time = time + 86400000*5 ;
    }
    else if (model == 2){
        time = time - 86400000 *5;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time/ 1000.0 ];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyyMMdd"];
    NSString *str  = [objDateformat stringFromDate: date];
    return str;
}
@end

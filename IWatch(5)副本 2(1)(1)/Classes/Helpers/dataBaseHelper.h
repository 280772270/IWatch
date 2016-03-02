//
//  dataBaseHelper.h
//  IWatch
//
//  Created by 陈萍 on 15/11/11.
//  Copyright © 2015年 陈萍 All rights reserved.
//
@class ZZVideoList;
#import <Foundation/Foundation.h>
@interface dataBaseHelper : NSObject
@property(nonatomic,strong)NSDictionary *dataBaseDict;
@property(nonatomic,strong)NSMutableArray *collectArr;
+(dataBaseHelper *)shareInstance;
-(void)setDataBase:(NSDictionary *)dataBaseDict;
-(void)addCollectiObject:(ZZVideoList *)model; //withIndex:(NSInteger )page withindex:(NSInteger )flag;
@end

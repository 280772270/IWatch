//
//  dataBaseHelper.m
//  IWatch
//
//  Created by 陈萍 on 15/11/11.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "dataBaseHelper.h"
static dataBaseHelper *helper;
@implementation dataBaseHelper
+(dataBaseHelper *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[dataBaseHelper alloc]init];
    });
    return helper;
}
-(void)setDataBase:(NSDictionary *)dataBaseDict{
    self.dataBaseDict = [NSDictionary dictionaryWithDictionary:dataBaseDict];

}
-(void)addCollectiObject:(ZZVideoList *)model
{
    if ([self.collectArr containsObject:model]) {
        return;
    }else{
    [self.collectArr insertObject:model atIndex:0];
    }
}
-(NSMutableArray *)collectArr{
    if (!_collectArr) {
        self.collectArr = [NSMutableArray new];
    }
    return _collectArr;
}
@end

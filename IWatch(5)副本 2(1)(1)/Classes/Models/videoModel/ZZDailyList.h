//
//  ZZDailyList.h
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZZDailyList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double date;
@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSArray *videoList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

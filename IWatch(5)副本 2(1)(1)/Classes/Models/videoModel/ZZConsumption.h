//
//  ZZConsumption.h
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZZConsumption : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double shareCount;
@property (nonatomic, assign) double collectionCount;
@property (nonatomic, assign) double replyCount;
@property (nonatomic, assign) double playCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

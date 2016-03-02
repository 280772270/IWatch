//
//  ZZPlayInfo.h
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍 All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZZPlayInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double height;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

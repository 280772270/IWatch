//
//  ZZBaseClass.h
//
//  Created by 陈萍 on 15/11/12
//  Copyright (c) 2015 陈萍 All rights reserved.
//
///Category分类
#import <Foundation/Foundation.h>



@interface ZZBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) id alias;

@property (nonatomic, strong) NSString *bgColor;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bgPicture;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

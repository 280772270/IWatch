//
//  ZZProvider.h
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍 All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZZProvider : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

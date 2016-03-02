//
//  ZZVideoList.h
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZProvider, ZZConsumption;

@interface ZZVideoList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double videoListIdentifier;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) double idx;
//@property (nonatomic, strong) ZZProvider *provider;
@property (nonatomic, strong) NSString *videoListDescription;
@property (nonatomic, strong) NSArray *playInfo;
@property (nonatomic, strong) NSString *playUrl;
@property (nonatomic, strong) ZZConsumption *consumption;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double date;
@property (nonatomic, strong) NSString *coverForFeed;
@property (nonatomic, strong) NSString *coverForSharing;
@property (nonatomic, strong) NSString *coverBlurred;
@property (nonatomic, assign) double duration;
//@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *rawWebUrl;
@property (nonatomic, strong) NSString *coverForDetail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

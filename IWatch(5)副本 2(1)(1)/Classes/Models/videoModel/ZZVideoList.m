//
//  ZZVideoList.m
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import "ZZVideoList.h"
#import "ZZProvider.h"
#import "ZZPlayInfo.h"
#import "ZZConsumption.h"


NSString *const kZZVideoListId = @"id";
NSString *const kZZVideoListCategory = @"category";
NSString *const kZZVideoListIdx = @"idx";
NSString *const kZZVideoListProvider = @"provider";
NSString *const kZZVideoListDescription = @"description";
NSString *const kZZVideoListPlayInfo = @"playInfo";
NSString *const kZZVideoListPlayUrl = @"playUrl";
NSString *const kZZVideoListConsumption = @"consumption";
NSString *const kZZVideoListTitle = @"title";
NSString *const kZZVideoListDate = @"date";
NSString *const kZZVideoListCoverForFeed = @"coverForFeed";
NSString *const kZZVideoListCoverForSharing = @"coverForSharing";
NSString *const kZZVideoListCoverBlurred = @"coverBlurred";
NSString *const kZZVideoListDuration = @"duration";
NSString *const kZZVideoListWebUrl = @"webUrl";
NSString *const kZZVideoListRawWebUrl = @"rawWebUrl";
NSString *const kZZVideoListCoverForDetail = @"coverForDetail";


@interface ZZVideoList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZZVideoList

@synthesize videoListIdentifier = _videoListIdentifier;
@synthesize category = _category;
@synthesize idx = _idx;
//@synthesize provider = _provider;
@synthesize videoListDescription = _videoListDescription;
@synthesize playInfo = _playInfo;
@synthesize playUrl = _playUrl;
@synthesize consumption = _consumption;
@synthesize title = _title;
@synthesize date = _date;
@synthesize coverForFeed = _coverForFeed;
@synthesize coverForSharing = _coverForSharing;
@synthesize coverBlurred = _coverBlurred;
@synthesize duration = _duration;
//@synthesize webUrl = _webUrl;
@synthesize rawWebUrl = _rawWebUrl;
@synthesize coverForDetail = _coverForDetail;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.videoListIdentifier = [[self objectOrNilForKey:kZZVideoListId fromDictionary:dict] doubleValue];
            self.category = [self objectOrNilForKey:kZZVideoListCategory fromDictionary:dict];
            self.idx = [[self objectOrNilForKey:kZZVideoListIdx fromDictionary:dict] doubleValue];
            //self.provider = [ZZProvider modelObjectWithDictionary:[dict objectForKey:kZZVideoListProvider]];
            self.videoListDescription = [self objectOrNilForKey:kZZVideoListDescription fromDictionary:dict];
    NSObject *receivedZZPlayInfo = [dict objectForKey:kZZVideoListPlayInfo];
    NSMutableArray *parsedZZPlayInfo = [NSMutableArray array];
    if ([receivedZZPlayInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZZPlayInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZZPlayInfo addObject:[ZZPlayInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZZPlayInfo isKindOfClass:[NSDictionary class]]) {
       [parsedZZPlayInfo addObject:[ZZPlayInfo modelObjectWithDictionary:(NSDictionary *)receivedZZPlayInfo]];
    }

    self.playInfo = [NSArray arrayWithArray:parsedZZPlayInfo];
            self.playUrl = [self objectOrNilForKey:kZZVideoListPlayUrl fromDictionary:dict];
            self.consumption = [ZZConsumption modelObjectWithDictionary:[dict objectForKey:kZZVideoListConsumption]];
            self.title = [self objectOrNilForKey:kZZVideoListTitle fromDictionary:dict];
            self.date = [[self objectOrNilForKey:kZZVideoListDate fromDictionary:dict] doubleValue];
            self.coverForFeed = [self objectOrNilForKey:kZZVideoListCoverForFeed fromDictionary:dict];
            self.coverForSharing = [self objectOrNilForKey:kZZVideoListCoverForSharing fromDictionary:dict];
            self.coverBlurred = [self objectOrNilForKey:kZZVideoListCoverBlurred fromDictionary:dict];
            self.duration = [[self objectOrNilForKey:kZZVideoListDuration fromDictionary:dict] doubleValue];
            //self.webUrl = [self objectOrNilForKey:kZZVideoListWebUrl fromDictionary:dict];
            self.rawWebUrl = [self objectOrNilForKey:kZZVideoListRawWebUrl fromDictionary:dict];
            self.coverForDetail = [self objectOrNilForKey:kZZVideoListCoverForDetail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.videoListIdentifier] forKey:kZZVideoListId];
    [mutableDict setValue:self.category forKey:kZZVideoListCategory];
    [mutableDict setValue:[NSNumber numberWithDouble:self.idx] forKey:kZZVideoListIdx];
    //[mutableDict setValue:[self.provider dictionaryRepresentation] forKey:kZZVideoListProvider];
    [mutableDict setValue:self.videoListDescription forKey:kZZVideoListDescription];
    NSMutableArray *tempArrayForPlayInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.playInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPlayInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPlayInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPlayInfo] forKey:kZZVideoListPlayInfo];
    [mutableDict setValue:self.playUrl forKey:kZZVideoListPlayUrl];
    [mutableDict setValue:[self.consumption dictionaryRepresentation] forKey:kZZVideoListConsumption];
    [mutableDict setValue:self.title forKey:kZZVideoListTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kZZVideoListDate];
    [mutableDict setValue:self.coverForFeed forKey:kZZVideoListCoverForFeed];
    [mutableDict setValue:self.coverForSharing forKey:kZZVideoListCoverForSharing];
    [mutableDict setValue:self.coverBlurred forKey:kZZVideoListCoverBlurred];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kZZVideoListDuration];
   // [mutableDict setValue:self.webUrl forKey:kZZVideoListWebUrl];
    [mutableDict setValue:self.rawWebUrl forKey:kZZVideoListRawWebUrl];
    [mutableDict setValue:self.coverForDetail forKey:kZZVideoListCoverForDetail];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

//- (NSString *)description 
//{
//    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
//}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.videoListIdentifier = [aDecoder decodeDoubleForKey:kZZVideoListId];
    self.category = [aDecoder decodeObjectForKey:kZZVideoListCategory];
    self.idx = [aDecoder decodeDoubleForKey:kZZVideoListIdx];
    //self.provider = [aDecoder decodeObjectForKey:kZZVideoListProvider];
    self.videoListDescription = [aDecoder decodeObjectForKey:kZZVideoListDescription];
    self.playInfo = [aDecoder decodeObjectForKey:kZZVideoListPlayInfo];
    self.playUrl = [aDecoder decodeObjectForKey:kZZVideoListPlayUrl];
    self.consumption = [aDecoder decodeObjectForKey:kZZVideoListConsumption];
    self.title = [aDecoder decodeObjectForKey:kZZVideoListTitle];
    self.date = [aDecoder decodeDoubleForKey:kZZVideoListDate];
    self.coverForFeed = [aDecoder decodeObjectForKey:kZZVideoListCoverForFeed];
    self.coverForSharing = [aDecoder decodeObjectForKey:kZZVideoListCoverForSharing];
    self.coverBlurred = [aDecoder decodeObjectForKey:kZZVideoListCoverBlurred];
    self.duration = [aDecoder decodeDoubleForKey:kZZVideoListDuration];
   //self.webUrl = [aDecoder decodeObjectForKey:kZZVideoListWebUrl];
    self.rawWebUrl = [aDecoder decodeObjectForKey:kZZVideoListRawWebUrl];
    self.coverForDetail = [aDecoder decodeObjectForKey:kZZVideoListCoverForDetail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_videoListIdentifier forKey:kZZVideoListId];
    [aCoder encodeObject:_category forKey:kZZVideoListCategory];
    [aCoder encodeDouble:_idx forKey:kZZVideoListIdx];
   // [aCoder encodeObject:_provider forKey:kZZVideoListProvider];
    [aCoder encodeObject:_videoListDescription forKey:kZZVideoListDescription];
    [aCoder encodeObject:_playInfo forKey:kZZVideoListPlayInfo];
    [aCoder encodeObject:_playUrl forKey:kZZVideoListPlayUrl];
    [aCoder encodeObject:_consumption forKey:kZZVideoListConsumption];
    [aCoder encodeObject:_title forKey:kZZVideoListTitle];
    [aCoder encodeDouble:_date forKey:kZZVideoListDate];
    [aCoder encodeObject:_coverForFeed forKey:kZZVideoListCoverForFeed];
    [aCoder encodeObject:_coverForSharing forKey:kZZVideoListCoverForSharing];
    [aCoder encodeObject:_coverBlurred forKey:kZZVideoListCoverBlurred];
    [aCoder encodeDouble:_duration forKey:kZZVideoListDuration];
    //[aCoder encodeObject:_webUrl forKey:kZZVideoListWebUrl];
    [aCoder encodeObject:_rawWebUrl forKey:kZZVideoListRawWebUrl];
    [aCoder encodeObject:_coverForDetail forKey:kZZVideoListCoverForDetail];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZZVideoList *copy = [[ZZVideoList alloc] init];
    
    if (copy) {

        copy.videoListIdentifier = self.videoListIdentifier;
        copy.category = [self.category copyWithZone:zone];
        copy.idx = self.idx;
       // copy.provider = [self.provider copyWithZone:zone];
        copy.videoListDescription = [self.videoListDescription copyWithZone:zone];
        copy.playInfo = [self.playInfo copyWithZone:zone];
        copy.playUrl = [self.playUrl copyWithZone:zone];
        copy.consumption = [self.consumption copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.date = self.date;
        copy.coverForFeed = [self.coverForFeed copyWithZone:zone];
        copy.coverForSharing = [self.coverForSharing copyWithZone:zone];
        copy.coverBlurred = [self.coverBlurred copyWithZone:zone];
        copy.duration = self.duration;
        //copy.webUrl = [self.webUrl copyWithZone:zone];
        copy.rawWebUrl = [self.rawWebUrl copyWithZone:zone];
        copy.coverForDetail = [self.coverForDetail copyWithZone:zone];
    }
    
    return copy;
}


@end

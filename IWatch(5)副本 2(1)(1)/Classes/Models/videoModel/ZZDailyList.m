//
//  ZZDailyList.m
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import "ZZDailyList.h"
#import "ZZVideoList.h"


NSString *const kZZDailyListDate = @"date";
NSString *const kZZDailyListTotal = @"total";
NSString *const kZZDailyListVideoList = @"videoList";


@interface ZZDailyList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZZDailyList

@synthesize date = _date;
@synthesize total = _total;
@synthesize videoList = _videoList;


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
            self.date = [[self objectOrNilForKey:kZZDailyListDate fromDictionary:dict] doubleValue];
            self.total = [[self objectOrNilForKey:kZZDailyListTotal fromDictionary:dict] doubleValue];
    NSObject *receivedZZVideoList = [dict objectForKey:kZZDailyListVideoList];
    NSMutableArray *parsedZZVideoList = [NSMutableArray array];
    if ([receivedZZVideoList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZZVideoList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZZVideoList addObject:[ZZVideoList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZZVideoList isKindOfClass:[NSDictionary class]]) {
       [parsedZZVideoList addObject:[ZZVideoList modelObjectWithDictionary:(NSDictionary *)receivedZZVideoList]];
    }

    self.videoList = [NSArray arrayWithArray:parsedZZVideoList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kZZDailyListDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kZZDailyListTotal];
    NSMutableArray *tempArrayForVideoList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.videoList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVideoList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVideoList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVideoList] forKey:kZZDailyListVideoList];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

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

    self.date = [aDecoder decodeDoubleForKey:kZZDailyListDate];
    self.total = [aDecoder decodeDoubleForKey:kZZDailyListTotal];
    self.videoList = [aDecoder decodeObjectForKey:kZZDailyListVideoList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_date forKey:kZZDailyListDate];
    [aCoder encodeDouble:_total forKey:kZZDailyListTotal];
    [aCoder encodeObject:_videoList forKey:kZZDailyListVideoList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZZDailyList *copy = [[ZZDailyList alloc] init];
    
    if (copy) {

        copy.date = self.date;
        copy.total = self.total;
        copy.videoList = [self.videoList copyWithZone:zone];
    }
    
    return copy;
}


@end

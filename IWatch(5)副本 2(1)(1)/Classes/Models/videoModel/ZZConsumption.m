//
//  ZZConsumption.m
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import "ZZConsumption.h"


NSString *const kZZConsumptionShareCount = @"shareCount";
NSString *const kZZConsumptionCollectionCount = @"collectionCount";
NSString *const kZZConsumptionReplyCount = @"replyCount";
NSString *const kZZConsumptionPlayCount = @"playCount";


@interface ZZConsumption ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZZConsumption

@synthesize shareCount = _shareCount;
@synthesize collectionCount = _collectionCount;
@synthesize replyCount = _replyCount;
@synthesize playCount = _playCount;


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
            self.shareCount = [[self objectOrNilForKey:kZZConsumptionShareCount fromDictionary:dict] doubleValue];
            self.collectionCount = [[self objectOrNilForKey:kZZConsumptionCollectionCount fromDictionary:dict] doubleValue];
            self.replyCount = [[self objectOrNilForKey:kZZConsumptionReplyCount fromDictionary:dict] doubleValue];
            self.playCount = [[self objectOrNilForKey:kZZConsumptionPlayCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kZZConsumptionShareCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.collectionCount] forKey:kZZConsumptionCollectionCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyCount] forKey:kZZConsumptionReplyCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.playCount] forKey:kZZConsumptionPlayCount];

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

    self.shareCount = [aDecoder decodeDoubleForKey:kZZConsumptionShareCount];
    self.collectionCount = [aDecoder decodeDoubleForKey:kZZConsumptionCollectionCount];
    self.replyCount = [aDecoder decodeDoubleForKey:kZZConsumptionReplyCount];
    self.playCount = [aDecoder decodeDoubleForKey:kZZConsumptionPlayCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_shareCount forKey:kZZConsumptionShareCount];
    [aCoder encodeDouble:_collectionCount forKey:kZZConsumptionCollectionCount];
    [aCoder encodeDouble:_replyCount forKey:kZZConsumptionReplyCount];
    [aCoder encodeDouble:_playCount forKey:kZZConsumptionPlayCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZZConsumption *copy = [[ZZConsumption alloc] init];
    
    if (copy) {

        copy.shareCount = self.shareCount;
        copy.collectionCount = self.collectionCount;
        copy.replyCount = self.replyCount;
        copy.playCount = self.playCount;
    }
    
    return copy;
}


@end

//
//  ZZProvider.m
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import "ZZProvider.h"


NSString *const kZZProviderName = @"name";
NSString *const kZZProviderAlias = @"alias";
NSString *const kZZProviderIcon = @"icon";


@interface ZZProvider ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZZProvider

@synthesize name = _name;
@synthesize alias = _alias;
@synthesize icon = _icon;


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
            self.name = [self objectOrNilForKey:kZZProviderName fromDictionary:dict];
            self.alias = [self objectOrNilForKey:kZZProviderAlias fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kZZProviderIcon fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kZZProviderName];
    [mutableDict setValue:self.alias forKey:kZZProviderAlias];
    [mutableDict setValue:self.icon forKey:kZZProviderIcon];

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

    self.name = [aDecoder decodeObjectForKey:kZZProviderName];
    self.alias = [aDecoder decodeObjectForKey:kZZProviderAlias];
    self.icon = [aDecoder decodeObjectForKey:kZZProviderIcon];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kZZProviderName];
    [aCoder encodeObject:_alias forKey:kZZProviderAlias];
    [aCoder encodeObject:_icon forKey:kZZProviderIcon];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZZProvider *copy = [[ZZProvider alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.alias = [self.alias copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
    }
    
    return copy;
}


@end

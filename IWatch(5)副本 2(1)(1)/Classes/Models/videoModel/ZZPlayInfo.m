//
//  ZZPlayInfo.m
//
//  Created by 陈萍 on 15/11/9
//  Copyright (c) 2015 陈萍. All rights reserved.
//

#import "ZZPlayInfo.h"


NSString *const kZZPlayInfoName = @"name";
NSString *const kZZPlayInfoType = @"type";
NSString *const kZZPlayInfoUrl = @"url";
NSString *const kZZPlayInfoWidth = @"width";
NSString *const kZZPlayInfoHeight = @"height";


@interface ZZPlayInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZZPlayInfo

@synthesize name = _name;
@synthesize type = _type;
@synthesize url = _url;
@synthesize width = _width;
@synthesize height = _height;


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
            self.name = [self objectOrNilForKey:kZZPlayInfoName fromDictionary:dict];
            self.type = [self objectOrNilForKey:kZZPlayInfoType fromDictionary:dict];
            self.url = [self objectOrNilForKey:kZZPlayInfoUrl fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kZZPlayInfoWidth fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kZZPlayInfoHeight fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kZZPlayInfoName];
    [mutableDict setValue:self.type forKey:kZZPlayInfoType];
    [mutableDict setValue:self.url forKey:kZZPlayInfoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kZZPlayInfoWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kZZPlayInfoHeight];

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

    self.name = [aDecoder decodeObjectForKey:kZZPlayInfoName];
    self.type = [aDecoder decodeObjectForKey:kZZPlayInfoType];
    self.url = [aDecoder decodeObjectForKey:kZZPlayInfoUrl];
    self.width = [aDecoder decodeDoubleForKey:kZZPlayInfoWidth];
    self.height = [aDecoder decodeDoubleForKey:kZZPlayInfoHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kZZPlayInfoName];
    [aCoder encodeObject:_type forKey:kZZPlayInfoType];
    [aCoder encodeObject:_url forKey:kZZPlayInfoUrl];
    [aCoder encodeDouble:_width forKey:kZZPlayInfoWidth];
    [aCoder encodeDouble:_height forKey:kZZPlayInfoHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZZPlayInfo *copy = [[ZZPlayInfo alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.width = self.width;
        copy.height = self.height;
    }
    
    return copy;
}


@end

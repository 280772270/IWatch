//
//  ZZBaseClass.m
//
//  Created by 陈萍 on 15/11/12
//  Copyright (c) 2015 陈萍 All rights reserved.
//

#import "ZZBaseClass.h"


NSString *const kZZBaseClassId = @"id";
NSString *const kZZBaseClassAlias = @"alias";
NSString *const kZZBaseClassBgColor = @"bgColor";
NSString *const kZZBaseClassName = @"name";
NSString *const kZZBaseClassBgPicture = @"bgPicture";


@interface ZZBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZZBaseClass

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize alias = _alias;
@synthesize bgColor = _bgColor;
@synthesize name = _name;
@synthesize bgPicture = _bgPicture;


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
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kZZBaseClassId fromDictionary:dict] doubleValue];
            self.alias = [self objectOrNilForKey:kZZBaseClassAlias fromDictionary:dict];
            self.bgColor = [self objectOrNilForKey:kZZBaseClassBgColor fromDictionary:dict];
            self.name = [self objectOrNilForKey:kZZBaseClassName fromDictionary:dict];
            self.bgPicture = [self objectOrNilForKey:kZZBaseClassBgPicture fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kZZBaseClassId];
    [mutableDict setValue:self.alias forKey:kZZBaseClassAlias];
    [mutableDict setValue:self.bgColor forKey:kZZBaseClassBgColor];
    [mutableDict setValue:self.name forKey:kZZBaseClassName];
    [mutableDict setValue:self.bgPicture forKey:kZZBaseClassBgPicture];

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

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kZZBaseClassId];
    self.alias = [aDecoder decodeObjectForKey:kZZBaseClassAlias];
    self.bgColor = [aDecoder decodeObjectForKey:kZZBaseClassBgColor];
    self.name = [aDecoder decodeObjectForKey:kZZBaseClassName];
    self.bgPicture = [aDecoder decodeObjectForKey:kZZBaseClassBgPicture];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kZZBaseClassId];
    [aCoder encodeObject:_alias forKey:kZZBaseClassAlias];
    [aCoder encodeObject:_bgColor forKey:kZZBaseClassBgColor];
    [aCoder encodeObject:_name forKey:kZZBaseClassName];
    [aCoder encodeObject:_bgPicture forKey:kZZBaseClassBgPicture];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZZBaseClass *copy = [[ZZBaseClass alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.alias = [self.alias copyWithZone:zone];
        copy.bgColor = [self.bgColor copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.bgPicture = [self.bgPicture copyWithZone:zone];
    }
    
    return copy;
}


@end

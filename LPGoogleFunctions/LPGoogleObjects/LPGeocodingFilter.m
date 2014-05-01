//
//  LPGeocodingFilter.m
//
//  Created by Luka Penger on 7/28/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPGeocodingFilter.h"


@implementation LPGeocodingFilter

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPGeocodingFilter new];
    if (self) {
        self.filter = [coder decodeIntForKey:@"filter"];
        self.value = [coder decodeObjectForKey:@"value"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInt:self.filter forKey:@"filter"];
    [coder encodeObject:self.value forKey:@"value"];
}

+ (id)filterWithGeocodingFilter:(LPGeocodingFilterMode)filter value:(NSString *)value
{
    LPGeocodingFilter *new = [LPGeocodingFilter new];
    
    new.filter = filter;
    new.value = value;
    
	return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"value", nil]]];
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", [LPGeocodingFilter getGeocodingFilter:self.filter]] forKey:@"filter"];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

+ (NSString *)getGeocodingFilter:(LPGeocodingFilterMode)filter
{
    if(filter == LPGeocodingFilterRoute)
    {
        return @"route";
    } else if(filter == LPGeocodingFilterPostal_code) {
        return @"postal_code";
    } else if(filter == LPGeocodingFilterLocality) {
        return @"locality";
    } else if(filter == LPGeocodingFilterAdministrative_area) {
        return @"administrative_area";
    } else {
        return @"country";
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    LPGeocodingFilter *new = [LPGeocodingFilter new];
    
    [new setFilter:[self filter]];
    [new setValue:[self value]];
    
    return new;
}

@end

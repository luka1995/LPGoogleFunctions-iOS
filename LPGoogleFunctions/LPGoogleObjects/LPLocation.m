//
//  LPLocation.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPLocation.h"


@implementation LPLocation

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPLocation new];
    if (self) {
        self.longitude = [coder decodeDoubleForKey:@"longitude"];
        self.latitude = [coder decodeDoubleForKey:@"latitude"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeDouble:self.longitude forKey:@"longitude"];
    [coder encodeDouble:self.latitude forKey:@"latitude"];
}

+ (id)locationWithObjects:(NSDictionary *)dictionary
{
    LPLocation *new = [LPLocation new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"lat"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"lat"]) {
            new.latitude = [[dictionary objectForKey:@"lat"] doubleValue];
        }
        
        if (![[dictionary objectForKey:@"lng"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"lng"]) {
            new.longitude = [[dictionary objectForKey:@"lng"] doubleValue];
        }
    }
    
	return new;
}

+ (id)locationWithLatitude:(double)latitude longitude:(double)longitude
{
    LPLocation *new = [LPLocation new];
    
    new.latitude = latitude;
    new.longitude = longitude;
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSDictionary *dictionary = [self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"latitude", @"longitude", nil]];
    
    return dictionary;
}

- (NSString *)description
{  
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPLocation *new = [LPLocation new];
    
    [new setLatitude:[self latitude]];
    [new setLongitude:[self longitude]];
    
    return new;
}

@end
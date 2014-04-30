//
//  LPBounds.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPBounds.h"


@implementation LPBounds

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPBounds new];
    if (self) {
        self.northeast = [coder decodeObjectForKey:@"northeast"];
        self.southwest = [coder decodeObjectForKey:@"southwest"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.northeast forKey:@"northeast"];
    [coder encodeObject:self.southwest forKey:@"southwest"];
}

+ (id)boundsWithObjects:(NSDictionary *)dictionary
{
    LPBounds *new = [LPBounds new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"northeast"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"northeast"]) {
            new.northeast=[LPLocation locationWithObjects:[dictionary objectForKey:@"northeast"]];
        }
        
        if (![[dictionary objectForKey:@"southwest"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"southwest"]) {
            new.southwest=[LPLocation locationWithObjects:[dictionary objectForKey:@"southwest"]];
        }
    }
    
	return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.northeast && ![self.northeast isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.northeast.dictionary forKey:@"northeast"];
    }
    
    if (self.southwest && ![self.southwest isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.southwest.dictionary forKey:@"southwest"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPBounds *new = [LPBounds new];
    
    [new setNortheast:[self northeast]];
    [new setSouthwest:[self southwest]];
    
    return new;
}

@end

//
//  LPGeometry.m
//
//  Created by Luka Penger on 7/26/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPGeometry.h"


@implementation LPGeometry

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPGeometry new];
    if (self) {
        self.location = [coder decodeObjectForKey:@"location"];
        self.viewport = [coder decodeObjectForKey:@"viewport"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.location forKey:@"location"];
    [coder encodeObject:self.viewport forKey:@"viewport"];
}

+ (id)geometryWithObjects:(NSDictionary *)dictionary
{
    LPGeometry *new = [LPGeometry new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"location"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"location"]) {
            new.location = [LPLocation locationWithObjects:[dictionary objectForKey:@"location"]];
        }
        
        if (![[dictionary objectForKey:@"viewport"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"viewport"]) {
            new.viewport = [LPBounds boundsWithObjects:[dictionary objectForKey:@"viewport"]];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.location && ![self.location isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.location.dictionary forKey:@"location"];
    }
    
    if (self.viewport && ![self.viewport isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.viewport.dictionary forKey:@"viewport"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPGeometry *new = [LPGeometry new];
    
    [new setLocation:[self location]];
    [new setViewport:[self viewport]];
    
    return new;
}


@end
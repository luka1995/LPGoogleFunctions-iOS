//
//  LPDistanceMatrixElement.m
//  ChargeJuice
//
//  Created by Luka Penger on 13/07/14.
//  Copyright (c) 2014 izzivizzi. All rights reserved.
//

#import "LPDistanceMatrixElement.h"


@implementation LPDistanceMatrixElement

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPDistanceMatrixElement new];
    if (self) {
        self.statusCode = [coder decodeObjectForKey:@"statusCode"];
        self.distance = [coder decodeObjectForKey:@"distance"];
        self.duration = [coder decodeObjectForKey:@"duration"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.statusCode forKey:@"statusCode"];
    [coder encodeObject:self.distance forKey:@"distance"];
    [coder encodeObject:self.duration forKey:@"duration"];
}

+ (id)distanceMatrixElementWithObjects:(NSDictionary *)dictionary
{
    LPDistanceMatrixElement *new = [LPDistanceMatrixElement new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"status"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"status"]) {
            new.statusCode = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"status"]];
        }
        
        if (![[dictionary objectForKey:@"distance"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"distance"]) {
            new.distance = [LPDistance distanceWithObjects:[dictionary objectForKey:@"distance"]];
        }
        
        if (![[dictionary objectForKey:@"duration"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"duration"]) {
            new.duration = [LPDuration durationWithObjects:[dictionary objectForKey:@"duration"]];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.statusCode] forKey:@"statusCode"];
    
    if(self.distance && ![self.distance isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.distance.dictionary forKey:@"distance"];
    }
    
    if(self.duration && ![self.duration isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.duration.dictionary forKey:@"duration"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPDistanceMatrixElement *new = [LPDistanceMatrixElement new];
    
    [new setStatusCode:self.statusCode];
    [new setDistance:self.distance];
    [new setDuration:self.duration];
    
    return new;
}

@end

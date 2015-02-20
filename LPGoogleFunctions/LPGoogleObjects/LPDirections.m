//
//  LPDirections.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPDirections.h"


@implementation LPDirections

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPDirections new];
    if (self) {
        self.routes = [coder decodeObjectForKey:@"routes"];
        self.statusCode = [coder decodeObjectForKey:@"statusCode"];
        self.requestTravelMode = [coder decodeIntForKey:@"requestTravelMode"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.routes forKey:@"routes"];
    [coder encodeObject:self.statusCode forKey:@"statusCode"];
    [coder encodeInteger:self.requestTravelMode forKey:@"requestTravelMode"];
}

+ (id)directionsWithObjects:(NSDictionary *)dictionary
{
    LPDirections *new = [LPDirections new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"routes"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"routes"]) {
            NSMutableArray *array = [NSMutableArray new];

            for (int i=0; i<[[dictionary objectForKey:@"routes"] count]; i++) {
                LPRoute *route = [LPRoute routeWithObjects:[[dictionary objectForKey:@"routes"] objectAtIndex:i]];
                route.number=i;
                
                [array addObject:route];
            }
            
            new.routes = array;
        }
        
        if (![[dictionary objectForKey:@"status"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"status"]) {
            new.statusCode = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"status"]];
        }
    }
    
	return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    if (self.routes && ![self.routes isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.routes count]; i++) {
            [array addObject:((LPRoute *)[self.routes objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"routes"];
    }

    [dictionary setObject:[NSString stringWithFormat:@"%@", self.statusCode] forKey:@"statusCode"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", [LPStep getDirectionsTravelMode:self.requestTravelMode]] forKey:@"requestTravelMode"];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPDirections *new = [LPDirections new];
    
    [new setRoutes:[self routes]];
    [new setStatusCode:[self statusCode]];
    [new setRequestTravelMode:self.requestTravelMode];
    
    return new;
}

+ (NSString *)getDirectionsAvoid:(LPGoogleDirectionsAvoid)avoid
{
    switch (avoid) {
        case LPGoogleDirectionsAvoidHighways:
            return @"highways";
        case LPGoogleDirectionsAvoidTolls:
            return @"avoid";
        default:
            return @"";
    }
}

+ (NSString *)getDirectionsUnit:(LPGoogleDirectionsUnit)unit
{
    switch (unit) {
        case LPGoogleDirectionsUnitImperial:
            return @"imperial";
        default:
            return @"metric";
    }
}

@end

//
//  LPTransitDetails.m
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPTransitDetails.h"


@implementation LPTransitDetails

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPTransitDetails new];
    if (self) {
        self.arrivalStop = [coder decodeObjectForKey:@"arrivalStop"];
        self.arrivalTime = [coder decodeObjectForKey:@"arrivalTime"];
        self.departureStop = [coder decodeObjectForKey:@"departureStop"];
        self.departureTime = [coder decodeObjectForKey:@"departureTime"];
        self.headsign = [coder decodeObjectForKey:@"headsign"];
        self.line = [coder decodeObjectForKey:@"line"];
        self.numStops = [coder decodeIntForKey:@"numStops"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.arrivalStop forKey:@"arrivalStop"];
    [coder encodeObject:self.arrivalTime forKey:@"arrivalTime"];
    [coder encodeObject:self.departureStop forKey:@"departureStop"];
    [coder encodeObject:self.departureTime forKey:@"departureTime"];
    [coder encodeObject:self.headsign forKey:@"headsign"];
    [coder encodeObject:self.line forKey:@"line"];
    [coder encodeInt:self.numStops forKey:@"numStops"];
}

+ (id)transitDetailsWithObjects:(NSDictionary *)dictionary
{
    LPTransitDetails *new = [LPTransitDetails new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"arrival_stop"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"arrival_stop"]) {
            new.arrivalStop = [LPStop stopWithObjects:[dictionary objectForKey:@"arrival_stop"]];
        }
        
        if (![[dictionary objectForKey:@"arrival_time"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"arrival_time"]) {
            new.arrivalTime = [LPTime timeWithObjects:[dictionary objectForKey:@"arrival_time"]];
        }
        
        if (![[dictionary objectForKey:@"departure_stop"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"departure_stop"]) {
            new.departureStop = [LPStop stopWithObjects:[dictionary objectForKey:@"departure_stop"]];
        }
        
        if (![[dictionary objectForKey:@"departure_time"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"departure_time"]) {
            new.departureTime = [LPTime timeWithObjects:[dictionary objectForKey:@"departure_time"]];
        }
        
        if (![[dictionary objectForKey:@"headsign"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"headsign"]) {
            new.headsign = [dictionary objectForKey:@"headsign"];
        }
        
        if (![[dictionary objectForKey:@"line"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"line"]) {
            new.line = [LPLine lineWithObjects:[dictionary objectForKey:@"line"]];
        }
        
        if (![[dictionary objectForKey:@"num_stops"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"num_stops"]) {
            new.numStops = [[dictionary objectForKey:@"num_stops"] intValue];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    if (self.arrivalStop && ![self.arrivalStop isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.arrivalStop.dictionary forKey:@"arrivalStop"];
    }
    
    if (self.arrivalTime && ![self.arrivalTime isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.arrivalTime.dictionary forKey:@"arrivalTime"];
    }
    
    if (self.departureStop && ![self.departureStop isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.departureStop.dictionary forKey:@"departureStop"];
    }
    
    if (self.departureTime && ![self.departureTime isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.departureTime.dictionary forKey:@"departureTime"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.headsign] forKey:@"headsign"];
    
    if (self.line && ![self.line isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.line.dictionary forKey:@"line"];
    }

    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPTransitDetails *new = [LPTransitDetails new];
    
    [new setArrivalStop:[self arrivalStop]];
    [new setArrivalTime:[self arrivalTime]];
    [new setDepartureStop:[self departureStop]];
    [new setDepartureTime:[self departureTime]];
    [new setHeadsign:[self headsign]];
    [new setLine:[self line]];
    [new setNumStops:[self numStops]];
    
    return new;
}

@end
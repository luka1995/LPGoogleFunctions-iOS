//
//  LPLeg.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPLeg.h"


@implementation LPLeg

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPLeg new];
    if (self)
	{
        self.arrivalTime = [coder decodeObjectForKey:@"arrivalTime"];
        self.departureTime = [coder decodeObjectForKey:@"departureTime"];
        self.distance = [coder decodeObjectForKey:@"distance"];
        self.duration = [coder decodeObjectForKey:@"duration"];
        self.endAddress = [coder decodeObjectForKey:@"endAddress"];
        self.endLocation = [coder decodeObjectForKey:@"endLocation"];
        self.startAddress = [coder decodeObjectForKey:@"startAddress"];
        self.startLocation = [coder decodeObjectForKey:@"startLocation"];
        self.steps = [coder decodeObjectForKey:@"steps"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.arrivalTime forKey:@"arrivalTime"];
    [coder encodeObject:self.departureTime forKey:@"departureTime"];
    [coder encodeObject:self.distance forKey:@"distance"];
    [coder encodeObject:self.duration forKey:@"duration"];
    [coder encodeObject:self.endAddress forKey:@"endAddress"];
    [coder encodeObject:self.endLocation forKey:@"endLocation"];
    [coder encodeObject:self.startAddress forKey:@"startAddress"];
    [coder encodeObject:self.startLocation forKey:@"startLocation"];
    [coder encodeObject:self.steps forKey:@"steps"];
}

+ (id)legWithObjects:(NSDictionary *)dictionary
{
    LPLeg *new = [LPLeg new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"arrival_time"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"arrival_time"]) {
            new.arrivalTime = [LPTime timeWithObjects:[dictionary objectForKey:@"arrival_time"]];
        }
        
        if (![[dictionary objectForKey:@"departure_time"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"departure_time"]) {
            new.departureTime = [LPTime timeWithObjects:[dictionary objectForKey:@"departure_time"]];
        }
        
        if (![[dictionary objectForKey:@"distance"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"distance"]) {
            new.distance = [LPDistance distanceWithObjects:[dictionary objectForKey:@"distance"]];
        }
        
        if (![[dictionary objectForKey:@"duration"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"duration"]) {
            new.duration = [LPDuration durationWithObjects:[dictionary objectForKey:@"duration"]];
        }
        
        if (![[dictionary objectForKey:@"end_address"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"end_address"]) {
            new.endAddress = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"end_address"]];
        }
        
        if (![[dictionary objectForKey:@"end_location"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"end_location"]) {
            new.endLocation = [LPLocation locationWithObjects:[dictionary objectForKey:@"end_location"]];
        }
        
        if (![[dictionary objectForKey:@"start_address"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"start_address"]) {
            new.startAddress = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"start_address"]];
        }
        
        if (![[dictionary objectForKey:@"start_location"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"start_location"]) {
            new.startLocation = [LPLocation locationWithObjects:[dictionary objectForKey:@"start_location"]];
        }
        
        if (![[dictionary objectForKey:@"steps"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"steps"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"steps"] count]; i++) {
                [array addObject:[LPStep stepWithObjects:[[dictionary objectForKey:@"steps"] objectAtIndex:i]]];
            }
            
            new.steps = [NSArray arrayWithArray:array];
        }
    }
    
	return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if(self.arrivalTime && ![self.arrivalTime isKindOfClass:[NSNull class]])  {
        [dictionary setObject:self.arrivalTime.dictionary forKey:@"arrivalTime"];
    }
    
    if(self.departureTime && ![self.departureTime isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.departureTime.dictionary forKey:@"departureTime"];
    }
    
    if(self.distance && ![self.distance isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.distance.dictionary forKey:@"distance"];
    }
    
    if(self.duration && ![self.duration isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.duration.dictionary forKey:@"duration"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.endAddress] forKey:@"endAddress"];
    
    if(self.endLocation && ![self.endLocation isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.endLocation.dictionary forKey:@"endLocation"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.startAddress] forKey:@"startAddress"];
    
    if (self.startLocation && ![self.startLocation isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.startLocation.dictionary forKey:@"startLocation"];
    }
    
    if (self.steps && ![self.steps isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.steps count]; i++) {
            [array addObject:((LPStep *)[self.steps objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"steps"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPLeg *new = [LPLeg new];
    
    [new setArrivalTime:[self arrivalTime]];
    [new setDepartureTime:[self departureTime]];
    [new setDistance:[self distance]];
    [new setDuration:[self duration]];
    [new setEndAddress:[self endAddress]];
    [new setEndLocation:[self endLocation]];
    [new setStartAddress:[self startAddress]];
    [new setStartLocation:[self startLocation]];
    [new setSteps:[self steps]];
    
    return new;
}

@end
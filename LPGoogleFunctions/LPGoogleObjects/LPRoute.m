//
//  LPRoute.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPRoute.h"


@implementation LPRoute

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPRoute new];
    if (self) {
        self.number = [coder decodeIntForKey:@"number"];
        self.bounds = [coder decodeObjectForKey:@"bounds"];
        self.copyrights = [coder decodeObjectForKey:@"copyrights"];
        self.legs = [coder decodeObjectForKey:@"legs"];
        self.overviewPolyline = [coder decodeObjectForKey:@"overviewPolyline"];
        self.summary = [coder decodeObjectForKey:@"summary"];
        self.warnings = [coder decodeObjectForKey:@"warnings"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInt:self.number forKey:@"number"];
    [coder encodeObject:self.bounds forKey:@"bounds"];
    [coder encodeObject:self.copyrights forKey:@"copyrights"];
    [coder encodeObject:self.legs forKey:@"legs"];
    [coder encodeObject:self.overviewPolyline forKey:@"overviewPolyline"];
    [coder encodeObject:self.summary forKey:@"summary"];
    [coder encodeObject:self.warnings forKey:@"warnings"];
}

+ (id)routeWithObjects:(NSDictionary *)dictionary
{
    LPRoute *new = [LPRoute new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"warnings"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"warnings"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"warnings"] count]; i++) {
                [array addObject:[[dictionary objectForKey:@"warnings"] objectAtIndex:i]];
            }
            
            new.warnings = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"bounds"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"bounds"]) {
            new.bounds = [LPBounds boundsWithObjects:[dictionary objectForKey:@"bounds"]];
        }

        if (![[dictionary objectForKey:@"copyrights"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"copyrights"]) {
            new.copyrights = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"copyrights"]];
        }

        if (![[dictionary objectForKey:@"legs"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"legs"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"legs"] count]; i++) {
                [array addObject:[LPLeg legWithObjects:[[dictionary objectForKey:@"legs"] objectAtIndex:i]]];
            }
            
            new.legs = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"overview_polyline"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"overview_polyline"]) {
            new.overviewPolyline = [LPPolyline polylineWithObjects:[dictionary objectForKey:@"overview_polyline"]];
        }
        
        if (![[dictionary objectForKey:@"summary"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"summary"]) {
            new.summary = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"summary"]];
        }
        
        if (![[dictionary objectForKey:@"via_waypoint"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"via_waypoint"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"via_waypoint"] count]; i++) {
                [array addObject:[LPWaypoint waypointWithObjects:[[dictionary objectForKey:@"via_waypoint"] objectAtIndex:i]]];
            }
            
            new.waypoints = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"number"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"number"]) {
            new.number = [[dictionary objectForKey:@"number"] intValue];
        }
    }
    
	return new;
}

- (NSDictionary*)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:[NSNumber numberWithInteger:self.number] forKey:@"number"];
    
    if (self.bounds && ![self.bounds isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.bounds.dictionary forKey:@"bounds"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.copyrights] forKey:@"copyrights"];
    
    if (self.legs && ![self.legs isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.legs count]; i++) {
            [array addObject:((LPLeg*)[self.legs objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"legs"];
    }
    
    if (self.overviewPolyline && ![self.overviewPolyline isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.overviewPolyline.dictionary forKey:@"overviewPolyline"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.summary] forKey:@"summary"];
    
    if (self.waypoints && ![self.waypoints isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.waypoints count]; i++) {
            [array addObject:((LPWaypoint *)[self.waypoints objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"waypoints"];
    }
    
    if (self.warnings && ![self.warnings isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.warnings count]; i++) {
            [array addObject:[self.warnings objectAtIndex:i]];
        }
        
        [dictionary setObject:array forKey:@"warnings"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPRoute *new = [LPRoute new];
    
    [new setNumber:[self number]];
    [new setBounds:[self bounds]];
    [new setCopyrights:[self copyrights]];
    [new setLegs:[self legs]];
    [new setOverviewPolyline:[self overviewPolyline]];
    [new setSummary:[self summary]];
    [new setWaypoints:[self waypoints]];
    [new setWarnings:[self warnings]];
    
    return new;
}

- (int)getRouteDuration
{
    int value = 0;
    
    for (int a=0; a<[self.legs count]; a++) {
        LPLeg *leg = (LPLeg *)[self.legs objectAtIndex:a];

        for (int b=0; b<[leg.steps count]; b++) {
            LPStep *step = (LPStep *)[leg.steps objectAtIndex:b];
            
            value += step.duration.value;
            
            for (int c=0; c<[step.subSteps count]; c++) {
                LPStep *substep = (LPStep *)[step.subSteps objectAtIndex:c];
                
                value += substep.duration.value;
            }
        }
    }
    
    return value;
}

- (int)getRouteDistance
{
    int value = 0;
    
    for (int a=0; a<[self.legs count]; a++) {
        LPLeg *leg = (LPLeg *)[self.legs objectAtIndex:a];
        
        for (int b=0; b<[leg.steps count]; b++) {
            LPStep *step = (LPStep*)[leg.steps objectAtIndex:b];
            
            value += step.distance.value;
            
            for (int c=0; c<[step.subSteps count]; c++) {
                LPStep *substep = (LPStep *)[step.subSteps objectAtIndex:c];
                
                value += substep.distance.value;
            }
        }
    }
    
    return value;
}

@end
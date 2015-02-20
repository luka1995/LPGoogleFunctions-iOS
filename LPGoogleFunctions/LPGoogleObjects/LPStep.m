//
//  LPStep.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPStep.h"


NSString *const googleDirectionsTravelModeDriving = @"driving";
NSString *const googleDirectionsTravelModeBicycling = @"bicycling";
NSString *const googleDirectionsTravelModeTransit = @"transit";
NSString *const googleDirectionsTravelModeWalking = @"walking";


@implementation LPStep

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPStep new];
    if (self)
	{
        self.maneuver = [coder decodeObjectForKey:@"maneuver"];
        self.distance = [coder decodeObjectForKey:@"distance"];
        self.duration = [coder decodeObjectForKey:@"duration"];
        self.endLocation = [coder decodeObjectForKey:@"endLocation"];
        self.htmlInstructions = [coder decodeObjectForKey:@"htmlInstructions"];
        self.polyline = [coder decodeObjectForKey:@"polyline"];
        self.startLocation = [coder decodeObjectForKey:@"startLocation"];
        self.travelMode = [coder decodeIntForKey:@"travelMode"];
        self.subSteps = [coder decodeObjectForKey:@"subSteps"];
        self.transitDetails = [coder decodeObjectForKey:@"transitDetails"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.maneuver forKey:@"maneuver"];
    [coder encodeObject:self.distance forKey:@"distanceObject"];
    [coder encodeObject:self.duration forKey:@"durationObject"];
    [coder encodeObject:self.endLocation forKey:@"endLocation"];
    [coder encodeObject:self.htmlInstructions forKey:@"htmlInstructions"];
    [coder encodeObject:self.polyline forKey:@"polyline"];
    [coder encodeObject:self.startLocation forKey:@"startLocation"];
    [coder encodeInteger:self.travelMode forKey:@"travelMode"];
    [coder encodeObject:self.subSteps forKey:@"subSteps"];
    [coder encodeObject:self.transitDetails forKey:@"transitDetails"];
}

+ (LPGoogleDirectionsTravelMode)getDirectionsTravelModeFromString:(NSString *)string
{
    if ([string isEqualToString:googleDirectionsTravelModeDriving] || [string isEqualToString:[googleDirectionsTravelModeDriving uppercaseString]]) {
        return LPGoogleDirectionsTravelModeDriving;
    } else if ([string isEqualToString:googleDirectionsTravelModeBicycling] || [string isEqualToString:[googleDirectionsTravelModeBicycling uppercaseString]]) {
        return LPGoogleDirectionsTravelModeBicycling;
    } else if ([string isEqualToString:googleDirectionsTravelModeTransit] || [string isEqualToString:[googleDirectionsTravelModeTransit uppercaseString]]) {
        return LPGoogleDirectionsTravelModeTransit;
    } else {
        return LPGoogleDirectionsTravelModeWalking;
    }
}

+ (NSString *)getDirectionsTravelMode:(LPGoogleDirectionsTravelMode)travelMode
{
    switch (travelMode) {
        case LPGoogleDirectionsTravelModeDriving:
            return googleDirectionsTravelModeDriving;
        case LPGoogleDirectionsTravelModeBicycling:
            return googleDirectionsTravelModeBicycling;
        case LPGoogleDirectionsTravelModeTransit:
            return googleDirectionsTravelModeTransit;
        default:
            return googleDirectionsTravelModeWalking;
    }
}

+ (id)stepWithObjects:(NSDictionary *)dictionary
{
    LPStep *new = [LPStep new];
    
    if (![dictionary isKindOfClass:[NSNull class]])
    {
        if (![[dictionary objectForKey:@"maneuver"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"maneuver"]) {
            new.maneuver = [dictionary objectForKey:@"maneuver"];
        }
        
        if (![[dictionary objectForKey:@"distance"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"distance"]) {
            new.distance = [LPDistance distanceWithObjects:[dictionary objectForKey:@"distance"]];
        }
        
        if (![[dictionary objectForKey:@"duration"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"duration"]) {
            new.duration = [LPDuration durationWithObjects:[dictionary objectForKey:@"duration"]];
        }

        if (![[dictionary objectForKey:@"end_location"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"end_location"]) {
            new.endLocation = [LPLocation locationWithObjects:[dictionary objectForKey:@"end_location"]];
        }
        
        if (![[dictionary objectForKey:@"html_instructions"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"html_instructions"] != nil) {
            new.htmlInstructions = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"html_instructions"]];
        }
        
        if (![[dictionary objectForKey:@"polyline"] isKindOfClass:[NSNull class]] || [dictionary objectForKey:@"polyline"] != nil) {
            new.polyline = [LPPolyline polylineWithObjects:[dictionary objectForKey:@"polyline"]];
        }
        
        if (![[dictionary objectForKey:@"start_location"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"start_location"]) {
            new.startLocation = [LPLocation locationWithObjects:[dictionary objectForKey:@"start_location"]];
        }
        
        if (![[dictionary objectForKey:@"travel_mode"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"travel_mode"]) {
            new.travelMode = [LPStep getDirectionsTravelModeFromString:[dictionary objectForKey:@"travel_mode"]];
        }
        
        if (![[dictionary objectForKey:@"steps"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"steps"]) {
            NSMutableArray *array = [NSMutableArray new];
        
            for (int i=0; i<[[dictionary objectForKey:@"steps"] count]; i++) {
                [array addObject:[LPStep stepWithObjects:[[dictionary objectForKey:@"steps"] objectAtIndex:i]]];
            }
        
            new.subSteps = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"transit_details"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"transit_details"]) {
            new.transitDetails = [LPTransitDetails transitDetailsWithObjects:[dictionary objectForKey:@"transit_details"]];
        }
    }

	return new;
}

- (NSDictionary*)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.maneuver && ![self.maneuver isKindOfClass:[NSNull class]]) {
        [dictionary setObject:[NSString stringWithFormat:@"%@",self.maneuver] forKey:@"maneuver"];
    }
    
    if (self.distance && ![self.distance isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.distance.dictionary forKey:@"distance"];
    }
    
    if (self.duration && ![self.duration isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.duration.dictionary forKey:@"duration"];
    }

    if (self.endLocation && ![self.endLocation isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.endLocation.dictionary forKey:@"endLocation"];
    }
        
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.htmlInstructions] forKey:@"htmlInstructions"];
    [dictionary setObject:self.polyline.dictionary forKey:@"polyline"];
    
    if (self.startLocation && ![self.startLocation isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.startLocation.dictionary forKey:@"startLocation"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", [[LPStep getDirectionsTravelMode:self.travelMode] uppercaseString]] forKey:@"travelMode"];
    
    if (self.subSteps && ![self.subSteps isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.subSteps count]; i++) {
            [array addObject:((LPStep *)[self.subSteps objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"subSteps"];
    }
    
    if (self.transitDetails && ![self.transitDetails isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.transitDetails.dictionary forKey:@"transitDetails"];
    }

    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPStep *new = [LPStep new];
    
    [new setManeuver:[self maneuver]];
    [new setDistance:[self distance]];
    [new setDuration:[self duration]];
    [new setEndLocation:[self endLocation]];
    [new setHtmlInstructions:[self htmlInstructions]];
    [new setPolyline:[self polyline]];
    [new setStartLocation:[self startLocation]];
    [new setTravelMode:[self travelMode]];
    [new setSubSteps:[self subSteps]];
    [new setTransitDetails:[self transitDetails]];

    return new;
}

@end
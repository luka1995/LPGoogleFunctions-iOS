//
//  LPWaypoint.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPWaypoint.h"


@implementation LPWaypoint

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPWaypoint new];
    if (self) {
        self.location = [coder decodeObjectForKey:@"location"];
        self.stepIndex = [coder decodeIntForKey:@"stepIndex"];
        self.stepInterpolation = [coder decodeDoubleForKey:@"stepInterpolation"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.location forKey:@"location"];
    [coder encodeInt:self.stepIndex forKey:@"stepIndex"];
    [coder encodeDouble:self.stepInterpolation forKey:@"stepInterpolation"];
}

+ (id)waypointWithObjects:(NSDictionary*)dictionary
{
    LPWaypoint *new = [LPWaypoint new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"location"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"location"]) {
            new.location=[LPLocation locationWithObjects:[dictionary objectForKey:@"location"]];
        }
        
        if (![[dictionary objectForKey:@"step_index"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"step_index"]) {
            new.stepIndex = [[dictionary objectForKey:@"step_index"] intValue];
        }
        
        if (![[dictionary objectForKey:@"step_interpolation"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"step_interpolation"]) {
            new.stepInterpolation = [[dictionary objectForKey:@"step_interpolation"] doubleValue];
        }
    }
    
	return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"stepIndex", @"stepInterpolation", nil]]];
    
    if(self.location && ![self.location isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.location forKey:@"location"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPWaypoint *new = [LPWaypoint new];
    
    [new setLocation:[self location]];
    [new setStepIndex:[self stepIndex]];
    [new setStepInterpolation:[self stepInterpolation]];
    
    return new;
}

@end

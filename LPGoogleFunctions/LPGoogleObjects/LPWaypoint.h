//
//  LPWaypoint.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPLocation.h"


@interface LPWaypoint : NSObject <NSCoding>

@property (nonatomic, strong) LPLocation *location;
@property (nonatomic, assign) int stepIndex;
@property (nonatomic, assign) double stepInterpolation;

+ (id)waypointWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

//
//  LPRoute.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPBounds.h"
#import "LPPolyline.h"
#import "LPLeg.h"
#import "LPWaypoint.h"


@interface LPRoute : NSObject <NSCoding>

@property (nonatomic, assign) int number;
@property (nonatomic, strong) LPBounds *bounds;
@property (nonatomic, strong) NSString *copyrights;
@property (nonatomic, strong) NSArray *legs;
@property (nonatomic, strong) LPPolyline *overviewPolyline;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSArray *waypoints;
@property (nonatomic, strong) NSArray *warnings;

+ (id)routeWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

- (int)getRouteDuration;
- (int)getRouteDistance;

@end


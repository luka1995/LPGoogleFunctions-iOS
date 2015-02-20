//
//  LPDirections.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPRoute.h"


typedef enum {
    LPGoogleDirectionsAvoidNone,
    LPGoogleDirectionsAvoidTolls,
    LPGoogleDirectionsAvoidHighways
} LPGoogleDirectionsAvoid;

typedef enum {
    LPGoogleDirectionsUnitMetric,
    LPGoogleDirectionsUnitImperial
} LPGoogleDirectionsUnit;


@interface LPDirections : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *routes;
@property (nonatomic, strong) NSString *statusCode;
@property (nonatomic, assign) LPGoogleDirectionsTravelMode requestTravelMode;

+ (id)directionsWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

+ (NSString *)getDirectionsAvoid:(LPGoogleDirectionsAvoid)avoid;
+ (NSString *)getDirectionsUnit:(LPGoogleDirectionsUnit)unit;

@end


//
//  LPDistanceMatrix.h
//  ChargeJuice
//
//  Created by Luka Penger on 13/07/14.
//  Copyright (c) 2014 izzivizzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPDistanceMatrixElement.h"


typedef enum {
    LPGoogleDistanceMatrixAvoidNone,
    LPGoogleDistanceMatrixAvoidTolls,
    LPGoogleDistanceMatrixAvoidHighways
} LPGoogleDistanceMatrixAvoid;

typedef enum {
    LPGoogleDistanceMatrixUnitMetric,
    LPGoogleDistanceMatrixUnitImperial
} LPGoogleDistanceMatrixUnit;

typedef enum {
    LPGoogleDistanceMatrixModeDriving,
    LPGoogleDistanceMatrixModeWalking,
    LPGoogleDistanceMatrixModeBicycling
} LPGoogleDistanceMatrixTravelMode;

@interface LPDistanceMatrix : NSObject <NSCoding>

@property (nonatomic, strong) NSString *statusCode;
@property (nonatomic, assign) LPGoogleDistanceMatrixTravelMode requestTravelMode;
@property (nonatomic, strong) NSArray *destinationAddresses;
@property (nonatomic, strong) NSArray *originAddresses;
@property (nonatomic, strong) NSArray *rows;

+ (id)distanceMatrixWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

+ (LPGoogleDistanceMatrixTravelMode)getDistanceMatrixTravelModeFromString:(NSString *)string;
+ (NSString *)getDistanceMatrixTravelMode:(LPGoogleDistanceMatrixTravelMode)travelMode;

+ (NSString *)getDistanceMatrixAvoid:(LPGoogleDistanceMatrixAvoid)avoid;
+ (NSString *)getDistanceMatrixUnit:(LPGoogleDistanceMatrixUnit)unit;

@end

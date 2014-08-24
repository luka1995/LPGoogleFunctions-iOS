//
//  LPStep.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPDistance.h"
#import "LPDuration.h"
#import "LPLocation.h"
#import "LPPolyline.h"
#import "LPTransitDetails.h"


typedef enum {
    LPGoogleDirectionsTravelModeDriving,
    LPGoogleDirectionsTravelModeWalking,
    LPGoogleDirectionsTravelModeBicycling,
    LPGoogleDirectionsTravelModeTransit
} LPGoogleDirectionsTravelMode;


@interface LPStep : NSObject <NSCoding>

@property (nonatomic, strong) NSString *maneuver;
@property (nonatomic, strong) LPDistance *distance;
@property (nonatomic, strong) LPDuration *duration;
@property (nonatomic, strong) LPLocation *endLocation;
@property (nonatomic, strong) NSString *htmlInstructions;
@property (nonatomic, strong) LPPolyline *polyline;
@property (nonatomic, strong) LPLocation *startLocation;
@property (nonatomic, assign) LPGoogleDirectionsTravelMode travelMode;
@property (nonatomic, strong) NSArray *subSteps;
@property (nonatomic, strong) LPTransitDetails *transitDetails;

+ (LPGoogleDirectionsTravelMode)getDirectionsTravelModeFromString:(NSString *)string;
+ (NSString *)getDirectionsTravelMode:(LPGoogleDirectionsTravelMode)travelMode;

+ (id)stepWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
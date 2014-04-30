//
//  LPLeg.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPDistance.h"
#import "LPDuration.h"
#import "LPLocation.h"
#import "LPStep.h"
#import "LPTime.h"


@interface LPLeg : NSObject <NSCoding>

@property (nonatomic, strong) LPTime *arrivalTime;
@property (nonatomic, strong) LPTime *departureTime;
@property (nonatomic, strong) LPDistance *distance;
@property (nonatomic, strong) LPDuration *duration;
@property (nonatomic, strong) NSString *endAddress;
@property (nonatomic, strong) LPLocation *endLocation;
@property (nonatomic, strong) NSString *startAddress;
@property (nonatomic, strong) LPLocation *startLocation;
@property (nonatomic, strong) NSArray *steps;

+ (id)legWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

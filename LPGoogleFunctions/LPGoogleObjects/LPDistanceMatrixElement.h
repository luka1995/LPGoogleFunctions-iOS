//
//  LPDistanceMatrixElement.h
//  ChargeJuice
//
//  Created by Luka Penger on 13/07/14.
//  Copyright (c) 2014 izzivizzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPDistance.h"
#import "LPDuration.h"


@interface LPDistanceMatrixElement : NSObject <NSCoding>

@property (nonatomic, strong) LPDistance *distance;
@property (nonatomic, strong) LPDuration *duration;
@property (nonatomic, strong) NSString *statusCode;

+ (id)distanceMatrixElementWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

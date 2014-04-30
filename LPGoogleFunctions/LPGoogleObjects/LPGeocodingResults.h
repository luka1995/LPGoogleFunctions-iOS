//
//  LPGeocodingResults.h
//
//  Created by Luka Penger on 7/28/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPPlaceDetails.h"


@interface LPGeocodingResults : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *statusCode;

+ (id)geocodingResultsWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
//
//  LPPlaceDetailsResults.h
//
//  Created by Luka Penger on 7/26/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPPlaceDetails.h"


@interface LPPlaceDetailsResults : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *htmlAttributions;
@property (nonatomic, strong) LPPlaceDetails *result;
@property (nonatomic, strong) NSString *statusCode;

+ (id)placeDetailsResultsWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
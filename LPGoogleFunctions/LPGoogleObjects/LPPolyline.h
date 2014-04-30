//
//  LPPolyline.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPLocation.h"


@interface LPPolyline : NSObject <NSCoding>

@property (nonatomic, strong) NSString *pointsString;
@property (nonatomic, strong) NSArray *pointsArray;

+ (id)polylineWithObjects:(NSDictionary *)dictionary;

+ (NSArray *)decodePolylineOfGoogleMaps:(NSString *)encodedPolyline;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
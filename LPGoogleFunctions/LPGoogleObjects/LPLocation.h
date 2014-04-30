//
//  LPLocation.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LPLocation : NSObject <NSCoding>

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

+ (id)locationWithObjects:(NSDictionary *)dictionary;

+ (id)locationWithLatitude:(double)latitude longitude:(double)longitude;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
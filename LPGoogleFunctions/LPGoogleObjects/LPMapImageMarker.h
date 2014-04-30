//
//  LPMapImageMarker.h
//  BicikeLJ
//
//  Created by Luka Penger on 7/6/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPLocation.h"


typedef enum {
    LPGoogleMapImageMarkerSizeTiny,
    LPGoogleMapImageMarkerSizeMid,
    LPGoogleMapImageMarkerSizeSmall,
    LPGoogleMapImageMarkerSizeNormal
} LPGoogleMapImageMarkerSize;


@interface LPMapImageMarker : NSObject <NSCoding>

@property (nonatomic, assign) LPGoogleMapImageMarkerSize size;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) LPLocation *location;

- (NSDictionary* )dictionary;

- (NSString *)getColorString;

- (NSString *)getSizeString;

- (NSString *)getMarkerURLString;

- (id)copyWithZone:(NSZone *)zone;

@end

//
//  LPGeocodingFilter.h
//
//  Created by Luka Penger on 7/28/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    LPGeocodingFilterRoute,
    LPGeocodingFilterLocality,
    LPGeocodingFilterAdministrative_area,
    LPGeocodingFilterPostal_code,
    LPGeocodingFilterCountry
} LPGeocodingFilterMode;


@interface LPGeocodingFilter : NSObject <NSCoding>

@property (nonatomic, assign) LPGeocodingFilterMode filter;
@property (nonatomic, strong) NSString *value;

+ (id)filterWithGeocodingFilter:(LPGeocodingFilterMode)filter value:(NSString *)value;

- (NSDictionary *)dictionary;

+ (NSString *)getGeocodingFilter:(LPGeocodingFilterMode)filter;

- (id)copyWithZone:(NSZone *)zone;

@end

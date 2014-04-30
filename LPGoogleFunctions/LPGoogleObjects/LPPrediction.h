//
//  LPPrediction.h
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPMatchedSubstring.h"
#import "LPTerm.h"


typedef enum {
    LPGooglePlaceTypeGeocode,
    LPGooglePlaceTypeEstablishment,
    LPGooglePlaceTypeLocality,
    LPGooglePlaceTypeSublocality,
    LPGooglePlaceTypePostalCode,
    LPGooglePlaceTypeCountry,
    LPGooglePlaceTypeAdministrativeArea1,
    LPGooglePlaceTypeAdministrativeArea2,
    LPGooglePlaceTypeAdministrativeArea3,
    LPGooglePlaceTypeUnknown
} LPGooglePlaceType;


@interface LPPrediction : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, assign) int number;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSArray *terms;
@property (nonatomic, strong) NSArray *matchedSubstrings;

+ (id)predicationWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

+ (LPGooglePlaceType)getGooglePlaceTypeFromString:(NSString *)type;
+ (NSString *)getStringFromGooglePlaceType:(LPGooglePlaceType)type;

- (id)copyWithZone:(NSZone *)zone;

@end
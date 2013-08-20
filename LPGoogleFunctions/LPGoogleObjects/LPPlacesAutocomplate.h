//
//  LPPlacesAutocomplate.h
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPPrediction.h"

@interface LPPlacesAutocomplate : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *predictions;
@property (nonatomic, strong) NSString *statusCode;

+ (id)placesAutocomplateWithObjects:(NSDictionary*)dictionary;

- (NSDictionary*)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

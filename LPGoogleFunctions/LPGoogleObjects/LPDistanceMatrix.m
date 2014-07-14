//
//  LPDistanceMatrix.m
//  ChargeJuice
//
//  Created by Luka Penger on 13/07/14.
//  Copyright (c) 2014 izzivizzi. All rights reserved.
//

#import "LPDistanceMatrix.h"


NSString *const googleDistanceMatrixTravelModeDriving = @"driving";
NSString *const googleDistanceMatrixTravelModeBicycling = @"bicycling";
NSString *const googleDistanceMatrixTravelModeWalking = @"walking";


@implementation LPDistanceMatrix

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPDistanceMatrix new];
    if (self) {
        self.statusCode = [coder decodeObjectForKey:@"statusCode"];
        self.destinationAddresses = [coder decodeObjectForKey:@"destinationAddresses"];
        self.originAddresses = [coder decodeObjectForKey:@"originAddresses"];
        self.rows = [coder decodeObjectForKey:@"rows"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.statusCode forKey:@"statusCode"];
    [coder encodeObject:self.destinationAddresses forKey:@"destinationAddresses"];
    [coder encodeObject:self.originAddresses forKey:@"originAddresses"];
    [coder encodeObject:self.rows forKey:@"rows"];
}

+ (id)distanceMatrixWithObjects:(NSDictionary *)dictionary
{
    LPDistanceMatrix *new = [LPDistanceMatrix new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"status"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"status"]) {
            new.statusCode = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"status"]];
        }
        
        if (![[dictionary objectForKey:@"destination_addresses"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"destination_addresses"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"destination_addresses"] count]; i++) {
                
                [array addObject:[[dictionary objectForKey:@"destination_addresses"] objectAtIndex:i]];
            }
            
            new.destinationAddresses = array;
        }
        
        if (![[dictionary objectForKey:@"origin_addresses"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"origin_addresses"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"origin_addresses"] count]; i++) {
                
                [array addObject:[[dictionary objectForKey:@"origin_addresses"] objectAtIndex:i]];
            }
            
            new.originAddresses = array;
        }
        
        if (![[dictionary objectForKey:@"rows"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"rows"]) {
            NSMutableArray *arrayRows = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"rows"] count]; i++) {
                NSMutableArray *arrayElements = [NSMutableArray new];
                
                for (int a=0; a<[[[[dictionary objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"elements"] count]; a++) {
                    LPDistanceMatrixElement *element = [LPDistanceMatrixElement distanceMatrixElementWithObjects:[[[[dictionary objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"elements"] objectAtIndex:a]];
                    
                    [arrayElements addObject:element];
                }
                
                [arrayRows addObject:arrayElements];
            }

            new.rows = arrayRows;
        }
    }
    
	return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.statusCode] forKey:@"statusCode"];
    
    if (self.destinationAddresses && ![self.destinationAddresses isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.destinationAddresses count]; i++)  {
            [array addObject:[self.destinationAddresses objectAtIndex:i]];
        }
        
        [dictionary setObject:array forKey:@"destinationAddresses"];
    }
    
    if (self.originAddresses && ![self.originAddresses isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.originAddresses count]; i++)  {
            [array addObject:[self.originAddresses objectAtIndex:i]];
        }
        
        [dictionary setObject:array forKey:@"originAddresses"];
    }
    
    if (self.rows && ![self.rows isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.rows count]; i++) {
            NSMutableArray *arrayRows = [NSMutableArray new];
            
            for (int a=0; a<[[self.rows objectAtIndex:i] count]; a++) {
                LPDistanceMatrixElement *element = (LPDistanceMatrixElement *)[[self.rows objectAtIndex:i] objectAtIndex:a];

                [arrayRows addObject:element.dictionary];
            }
            
            [array addObject:arrayRows];
        }

        [dictionary setObject:array forKey:@"rows"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPDistanceMatrix *new = [LPDistanceMatrix new];
    
    [new setStatusCode:self.statusCode];
    [new setDestinationAddresses:self.destinationAddresses];
    [new setOriginAddresses:self.originAddresses];
    [new setRows:self.rows];
    
    return new;
}

+ (LPGoogleDistanceMatrixTravelMode)getDistanceMatrixTravelModeFromString:(NSString *)string
{
    if ([string isEqualToString:googleDistanceMatrixTravelModeDriving] || [string isEqualToString:[googleDistanceMatrixTravelModeDriving uppercaseString]]) {
        return LPGoogleDistanceMatrixModeDriving;
    } else if ([string isEqualToString:googleDistanceMatrixTravelModeBicycling] || [string isEqualToString:[googleDistanceMatrixTravelModeBicycling uppercaseString]]) {
        return LPGoogleDistanceMatrixModeBicycling;
    } else {
        return LPGoogleDistanceMatrixModeWalking;
    }
}

+ (NSString *)getDistanceMatrixTravelMode:(LPGoogleDistanceMatrixTravelMode)travelMode
{
    switch (travelMode) {
        case LPGoogleDistanceMatrixModeDriving:
            return googleDistanceMatrixTravelModeDriving;
        case LPGoogleDistanceMatrixModeBicycling:
            return googleDistanceMatrixTravelModeBicycling;
        default:
            return googleDistanceMatrixTravelModeWalking;
    }
}

+ (NSString *)getDistanceMatrixAvoid:(LPGoogleDistanceMatrixAvoid)avoid
{
    switch (avoid) {
        case LPGoogleDistanceMatrixAvoidHighways:
            return @"highways";
        case LPGoogleDistanceMatrixAvoidTolls:
            return @"avoid";
        default:
            return @"";
    }
}

+ (NSString *)getDistanceMatrixUnit:(LPGoogleDistanceMatrixUnit)unit
{
    switch (unit) {
        case LPGoogleDistanceMatrixUnitImperial:
            return @"imperial";
        default:
            return @"metric";
    }
}

@end

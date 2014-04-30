//
//  LPLine.h
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPAgencie.h"
#import "LPVehicle.h"


@interface LPLine : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *agencies;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) LPVehicle *vehicle;

+ (id)lineWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

- (int)getBUSnumber;

@end

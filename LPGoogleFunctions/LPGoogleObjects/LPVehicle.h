//
//  LPVehicle.h
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    LPGoogleVehicleTypeRAIL,
    LPGoogleVehicleTypeMETRO_RAIL,
    LPGoogleVehicleTypeSUBWAY,
    LPGoogleVehicleTypeTRAM,
    LPGoogleVehicleTypeMONORAIL,
    LPGoogleVehicleTypeHEAVY_RAIL,
    LPGoogleVehicleTypeCOMMUTER_TRAIN,
    LPGoogleVehicleTypeHIGH_SPEED_TRAIN,
    LPGoogleVehicleTypeBUS,
    LPGoogleVehicleTypeINTERCITY_BUS,
    LPGoogleVehicleTypeTROLLEYBUS,
    LPGoogleVehicleTypeSHARE_TAXI,
    LPGoogleVehicleTypeFERRY,
    LPGoogleVehicleTypeCABLE_CAR,
    LPGoogleVehicleTypeGONDOLA_LIFT,
    LPGoogleVehicleTypeFUNICULAR,
    LPGoogleVehicleTypeOTHER
} LPGoogleVehicleType;


@interface LPVehicle : NSObject <NSCoding>

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) LPGoogleVehicleType type;

+ (LPGoogleVehicleType)getGoogleVehicleTypeFromString:(NSString *)type;
+ (NSString *)getGoogleVehicleType:(LPGoogleVehicleType)type;

+ (id)vehicleWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

//
//  LPVehicle.m
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPVehicle.h"


NSString *const VEHICLE_TYPE_RAIL = @"RAIL";
NSString *const VEHICLE_TYPE_METRO_RAIL = @"METRO_RAIL";
NSString *const VEHICLE_TYPE_SUBWAY = @"SUBWAY";
NSString *const VEHICLE_TYPE_TRAM = @"TRAM";
NSString *const VEHICLE_TYPE_MONORAIL = @"MONORAIL";
NSString *const VEHICLE_TYPE_HEAVY_RAIL = @"HEAVY_RAIL";
NSString *const VEHICLE_TYPE_COMMUTER_TRAIN = @"COMMUTER_TRAIN";
NSString *const VEHICLE_TYPE_HIGH_SPEED_TRAIN = @"HIGH_SPEED_TRAIN";
NSString *const VEHICLE_TYPE_BUS = @"BUS";
NSString *const VEHICLE_TYPE_INTERCITY_BUS = @"INTERCITY_BUS";
NSString *const VEHICLE_TYPE_TROLLEYBUS = @"TROLLEYBUS";
NSString *const VEHICLE_TYPE_SHARE_TAXI = @"SHARE_TAXI";
NSString *const VEHICLE_TYPE_FERRY = @"FERRY";
NSString *const VEHICLE_TYPE_CABLE_CAR = @"CABLE_CAR";
NSString *const VEHICLE_TYPE_GONDOLA_LIFT = @"GONDOLA_LIFT";
NSString *const VEHICLE_TYPE_FUNICULAR = @"FUNICULAR";
NSString *const VEHICLE_TYPE_OTHER = @"OTHER";


@implementation LPVehicle

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPVehicle new];
    if (self) {
        self.icon = [coder decodeObjectForKey:@"icon"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.type = [coder decodeIntForKey:@"type"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.icon forKey:@"icon"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.type forKey:@"type"];
}

+ (id)vehicleWithObjects:(NSDictionary *)dictionary
{
    LPVehicle *new = [LPVehicle new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"icon"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"icon"]) {
            if([[dictionary objectForKey:@"icon"] hasPrefix:@"//"]) {
                new.icon = [NSString stringWithFormat:@"http:%@", [dictionary objectForKey:@"icon"]];
            } else {
                new.icon = [dictionary objectForKey:@"icon"];
            }
        }
        
        if (![[dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"name"]) {
            new.name = [dictionary objectForKey:@"name"];
        }
        
        if (![[dictionary objectForKey:@"type"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"type"]) {
            new.type = [LPVehicle getGoogleVehicleTypeFromString:[dictionary objectForKey:@"type"]];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.icon] forKey:@"icon"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.name] forKey:@"name"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", [LPVehicle getGoogleVehicleType:self.type]] forKey:@"type"];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

+ (LPGoogleVehicleType)getGoogleVehicleTypeFromString:(NSString *)type
{
    if ([type isEqualToString:VEHICLE_TYPE_RAIL]) {
        return LPGoogleVehicleTypeRAIL;
    } else if ([type isEqualToString:VEHICLE_TYPE_METRO_RAIL]) {
        return LPGoogleVehicleTypeMETRO_RAIL;
    } else if ([type isEqualToString:VEHICLE_TYPE_SUBWAY]) {
        return LPGoogleVehicleTypeSUBWAY;
    } else if ([type isEqualToString:VEHICLE_TYPE_TRAM]) {
        return LPGoogleVehicleTypeTRAM;
    } else if ([type isEqualToString:VEHICLE_TYPE_MONORAIL]) {
        return LPGoogleVehicleTypeMONORAIL;
    } else if ([type isEqualToString:VEHICLE_TYPE_HEAVY_RAIL]) {
        return LPGoogleVehicleTypeHEAVY_RAIL;
    } else if ([type isEqualToString:VEHICLE_TYPE_COMMUTER_TRAIN]) {
        return LPGoogleVehicleTypeCOMMUTER_TRAIN;
    } else if ([type isEqualToString:VEHICLE_TYPE_HIGH_SPEED_TRAIN]) {
        return LPGoogleVehicleTypeHIGH_SPEED_TRAIN;
    } else if ([type isEqualToString:VEHICLE_TYPE_BUS]) {
        return LPGoogleVehicleTypeBUS;
    } else if ([type isEqualToString:VEHICLE_TYPE_INTERCITY_BUS]) {
        return LPGoogleVehicleTypeINTERCITY_BUS;
    } else if ([type isEqualToString:VEHICLE_TYPE_TROLLEYBUS]) {
        return LPGoogleVehicleTypeTROLLEYBUS;
    } else if ([type isEqualToString:VEHICLE_TYPE_SHARE_TAXI]) {
        return LPGoogleVehicleTypeSHARE_TAXI;
    } else if ([type isEqualToString:VEHICLE_TYPE_FERRY]) {
        return LPGoogleVehicleTypeFERRY;
    } else if ([type isEqualToString:VEHICLE_TYPE_CABLE_CAR]) {
        return LPGoogleVehicleTypeCABLE_CAR;
    } else if ([type isEqualToString:VEHICLE_TYPE_GONDOLA_LIFT]) {
        return LPGoogleVehicleTypeGONDOLA_LIFT;
    } else if ([type isEqualToString:VEHICLE_TYPE_FUNICULAR]) {
        return LPGoogleVehicleTypeFUNICULAR;
    } else {
        return LPGoogleVehicleTypeOTHER;
    }
}

+ (NSString *)getGoogleVehicleType:(LPGoogleVehicleType)type
{
    if (type == LPGoogleVehicleTypeRAIL) {
        return VEHICLE_TYPE_RAIL;
    } else if (type == LPGoogleVehicleTypeMETRO_RAIL) {
        return VEHICLE_TYPE_METRO_RAIL;
    } else if (type == LPGoogleVehicleTypeSUBWAY) {
        return VEHICLE_TYPE_SUBWAY;
    } else if (type == LPGoogleVehicleTypeTRAM) {
        return VEHICLE_TYPE_TRAM;
    } else if (type == LPGoogleVehicleTypeMONORAIL) {
        return VEHICLE_TYPE_MONORAIL;
    } else if (type == LPGoogleVehicleTypeHEAVY_RAIL) {
        return VEHICLE_TYPE_HEAVY_RAIL;
    } else if (type == LPGoogleVehicleTypeCOMMUTER_TRAIN) {
        return VEHICLE_TYPE_COMMUTER_TRAIN;
    } else if (type == LPGoogleVehicleTypeHIGH_SPEED_TRAIN) {
        return VEHICLE_TYPE_HIGH_SPEED_TRAIN;
    } else if (type == LPGoogleVehicleTypeBUS) {
        return VEHICLE_TYPE_BUS;
    } else if (type == LPGoogleVehicleTypeINTERCITY_BUS) {
        return VEHICLE_TYPE_INTERCITY_BUS;
    } else if (type == LPGoogleVehicleTypeTROLLEYBUS) {
        return VEHICLE_TYPE_TROLLEYBUS;
    } else if (type == LPGoogleVehicleTypeSHARE_TAXI) {
        return VEHICLE_TYPE_SHARE_TAXI;
    } else if (type == LPGoogleVehicleTypeFERRY) {
        return VEHICLE_TYPE_FERRY;
    } else if (type == LPGoogleVehicleTypeCABLE_CAR) {
        return VEHICLE_TYPE_CABLE_CAR;
    } else if (type == LPGoogleVehicleTypeGONDOLA_LIFT) {
        return VEHICLE_TYPE_GONDOLA_LIFT;
    } else if (type == LPGoogleVehicleTypeFUNICULAR) {
        return VEHICLE_TYPE_FUNICULAR;
    } else {
        return VEHICLE_TYPE_OTHER;
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    LPVehicle *new = [LPVehicle new];
    
    [new setIcon:[self icon]];
    [new setName:[self name]];
    [new setType:[self type]];
    
    return new;
}

@end
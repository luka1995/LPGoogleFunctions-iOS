//
//  LPLine.m
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPLine.h"


@implementation LPLine

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPLine new];
    if (self) {
        self.agencies = [coder decodeObjectForKey:@"agencies"];
        self.color = [coder decodeObjectForKey:@"color"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.shortName = [coder decodeObjectForKey:@"shortName"];
        self.vehicle = [coder decodeObjectForKey:@"vehicle"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.agencies forKey:@"agencies"];
    [coder encodeObject:self.color forKey:@"color"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.shortName forKey:@"shortName"];
    [coder encodeObject:self.vehicle forKey:@"vehicle"];
}

+ (id)lineWithObjects:(NSDictionary *)dictionary
{
    LPLine *new = [LPLine new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"agencies"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"agencies"]) {
            NSMutableArray *array=[NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"agencies"] count]; i++) {
                LPAgencie *agencie = [LPAgencie agencieWithObjects:[[dictionary objectForKey:@"agencies"] objectAtIndex:i]];
                
                [array addObject:agencie];
            }
            
            new.agencies = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"color"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"color"]) {
            new.color = [LPLine colorFromHexString:[dictionary objectForKey:@"color"]];
        }
        
        if (![[dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"name"]) {
            new.name = [dictionary objectForKey:@"name"];
        }
        
        if (![[dictionary objectForKey:@"short_name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"short_name"]) {
            new.shortName = [dictionary objectForKey:@"short_name"];
        }
        
        if (![[dictionary objectForKey:@"vehicle"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"vehicle"]) {
            new.vehicle = [LPVehicle vehicleWithObjects:[dictionary objectForKey:@"vehicle"]];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.agencies && ![self.agencies isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.agencies count]; i++) {
            [array addObject:((LPAgencie *)[self.agencies objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"agencies"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.name] forKey:@"name"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.shortName] forKey:@"shortName"];
    
    if (self.vehicle && ![self.vehicle isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.vehicle.dictionary forKey:@"vehicle"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPLine *new = [LPLine new];
    
    [new setAgencies:[self agencies]];
    [new setName:[self name]];
    [new setShortName:[self shortName]];
    [new setVehicle:[self vehicle]];
    
    return new;
}

- (int)getBUSnumber
{
    NSString *numberString = @"";
    NSScanner *scanner = [NSScanner scannerWithString:self.shortName];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    return [numberString intValue];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
//
//  LPPrediction.m
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPrediction.h"


NSString *const PLACE_TYPE_GEOCODE = @"geocode";
NSString *const PLACE_TYPE_ESTABLISHMENT = @"establishment";
NSString *const PLACE_TYPE_LOCALITY = @"locality";
NSString *const PLACE_TYPE_SUBLOCALITY = @"sublocality";
NSString *const PLACE_TYPE_POSTAL_CODE = @"postal_code";
NSString *const PLACE_TYPE_COUNTRY = @"country";
NSString *const PLACE_TYPE_ADMINISTRATIVE_AREA1 = @"administrative_area1";
NSString *const PLACE_TYPE_ADMINISTRATIVE_AREA2 = @"administrative_area2";
NSString *const PLACE_TYPE_ADMINISTRATIVE_AREA3 = @"administrative_area3";


@implementation LPPrediction

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPrediction new];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.ID = [coder decodeObjectForKey:@"ID"];
        self.number = [coder decodeIntForKey:@"number"];
        self.reference = [coder decodeObjectForKey:@"reference"];
        self.types = [coder decodeObjectForKey:@"types"];
        self.terms = [coder decodeObjectForKey:@"terms"];
        self.matchedSubstrings = [coder decodeObjectForKey:@"matchedSubstrings"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.ID forKey:@"ID"];
    [coder encodeInt:self.number forKey:@"number"];
    [coder encodeObject:self.reference forKey:@"reference"];
    [coder encodeObject:self.types forKey:@"types"];
    [coder encodeObject:self.terms forKey:@"terms"];
    [coder encodeObject:self.matchedSubstrings forKey:@"matchedSubstrings"];
}

+ (id)predicationWithObjects:(NSDictionary *)dictionary
{
    LPPrediction *new = [LPPrediction new];

    if (![dictionary isKindOfClass:[NSNull class]])
    {
        if (![[dictionary objectForKey:@"description"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"description"]) {
            new.name=[dictionary objectForKey:@"description"];
        }
        
        if (![[dictionary objectForKey:@"id"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"id"]) {
            new.ID=[dictionary objectForKey:@"id"];
        }
        
        if (![[dictionary objectForKey:@"number"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"number"]) {
            new.number=[[dictionary objectForKey:@"number"] intValue];
        }
        
        if (![[dictionary objectForKey:@"reference"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"reference"]) {
            new.reference=[dictionary objectForKey:@"reference"];
        }
        
        if (![[dictionary objectForKey:@"types"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"types"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"types"] count]; i++) {
                [array addObject:[[dictionary objectForKey:@"types"] objectAtIndex:i]];
            }
            
            new.types = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"matched_substrings"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"types"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"matched_substrings"] count]; i++) {
                LPMatchedSubstring *matchedSubstring = [LPMatchedSubstring matchedSubstringWithObjects:[[dictionary objectForKey:@"matched_substrings"] objectAtIndex:i]];
                
                [array addObject:matchedSubstring];
            }
            
            new.matchedSubstrings = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"terms"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"terms"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"terms"] count]; i++) {
                LPTerm *term = [LPTerm termWithObjects:[[dictionary objectForKey:@"terms"] objectAtIndex:i]];
                
                [array addObject:term];
            }
            
            new.terms = [NSArray arrayWithArray:array];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"name", @"ID", @"number", @"reference", nil]]];
    
    if (self.types && ![self.types isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.types count]; i++) {
            [array addObject:[self.types objectAtIndex:i]];
        }
        
        [dictionary setObject:array forKey:@"types"];
    }
    
    if (self.matchedSubstrings && ![self.matchedSubstrings isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.matchedSubstrings count]; i++)  {
            [array addObject:((LPMatchedSubstring *)[self.matchedSubstrings objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"matchedSubstrings"];
    }
    
    if (self.terms && ![self.terms isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for(int i=0; i<[self.terms count]; i++) {
            [array addObject:((LPTerm*)[self.terms objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"terms"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

+ (LPGooglePlaceType)getGooglePlaceTypeFromString:(NSString *)type
{
    if ([type isEqualToString:PLACE_TYPE_GEOCODE])
    {
        return LPGooglePlaceTypeGeocode;
    } else if ([type isEqualToString:PLACE_TYPE_ESTABLISHMENT]) {
        return LPGooglePlaceTypeEstablishment;
    } else if ([type isEqualToString:PLACE_TYPE_LOCALITY]) {
        return LPGooglePlaceTypeLocality;
    } else if ([type isEqualToString:PLACE_TYPE_SUBLOCALITY]) {
        return LPGooglePlaceTypeSublocality;
    } else if ([type isEqualToString:PLACE_TYPE_POSTAL_CODE]) {
        return LPGooglePlaceTypePostalCode;
    } else if ([type isEqualToString:PLACE_TYPE_COUNTRY]) {
        return LPGooglePlaceTypeCountry;
    } else if ([type isEqualToString:PLACE_TYPE_ADMINISTRATIVE_AREA1]) {
        return LPGooglePlaceTypeAdministrativeArea1;
    } else if ([type isEqualToString:PLACE_TYPE_ADMINISTRATIVE_AREA2]) {
        return LPGooglePlaceTypeAdministrativeArea2;
    } else if ([type isEqualToString:PLACE_TYPE_ADMINISTRATIVE_AREA3]) {
        return LPGooglePlaceTypeAdministrativeArea3;
    } else {
        return LPGooglePlaceTypeUnknown;
    }
}

+ (NSString *)getStringFromGooglePlaceType:(LPGooglePlaceType)type
{
    if (type == LPGooglePlaceTypeGeocode) {
        return PLACE_TYPE_GEOCODE;
    } else if (type == LPGooglePlaceTypeEstablishment) {
        return PLACE_TYPE_ESTABLISHMENT;
    } else if (type == LPGooglePlaceTypeLocality) {
        return PLACE_TYPE_LOCALITY;
    } else if (type == LPGooglePlaceTypeSublocality) {
        return PLACE_TYPE_SUBLOCALITY;
    } else if (type == LPGooglePlaceTypePostalCode) {
        return PLACE_TYPE_POSTAL_CODE;
    } else if (type == LPGooglePlaceTypeCountry) {
        return PLACE_TYPE_COUNTRY;
    } else if (type == LPGooglePlaceTypeAdministrativeArea1) {
        return PLACE_TYPE_ADMINISTRATIVE_AREA1;
    } else if (type == LPGooglePlaceTypeAdministrativeArea2) {
        return PLACE_TYPE_ADMINISTRATIVE_AREA2;
    } else if (type == LPGooglePlaceTypeAdministrativeArea3) {
        return PLACE_TYPE_ADMINISTRATIVE_AREA3;
    } else {
        return @"";
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    LPPrediction *new = [LPPrediction new];
    
    [new setName:[self name]];
    [new setID:[self ID]];
    [new setNumber:[self number]];
    [new setReference:[self reference]];
    [new setTypes:[self types]];
    [new setTerms:[self terms]];
    [new setMatchedSubstrings:[self matchedSubstrings]];
    
    return new;
}

@end

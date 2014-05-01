//
//  LPPlaceDetails.m
//
//  Created by Luka Penger on 7/26/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPlaceDetails.h"


@implementation LPPlaceDetails

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPlaceDetails new];
    if (self) {
        self.addressComponents = [coder decodeObjectForKey:@"addressComponents"];
        self.adrAddress = [coder decodeObjectForKey:@"adrAddress"];
        self.formattedAddress = [coder decodeObjectForKey:@"formattedAddress"];
        self.geometry = [coder decodeObjectForKey:@"geometry"];
        self.icon = [coder decodeObjectForKey:@"icon"];
        self.ID = [coder decodeObjectForKey:@"ID"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.reference = [coder decodeObjectForKey:@"reference"];
        self.types = [coder decodeObjectForKey:@"types"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.vicinity = [coder decodeObjectForKey:@"vicinity"];
        self.photos = [coder decodeObjectForKey:@"photos"];
        self.priceLevel = [coder decodeIntForKey:@"priceLevel"];
        self.rating = [coder decodeFloatForKey:@"rating"];
        self.events = [coder decodeObjectForKey:@"events"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.addressComponents forKey:@"addressComponents"];
    [coder encodeObject:self.adrAddress forKey:@"adrAddress"];
    [coder encodeObject:self.formattedAddress forKey:@"formattedAddresss"];
    [coder encodeObject:self.geometry forKey:@"geometry"];
    [coder encodeObject:self.icon forKey:@"icon"];
    [coder encodeObject:self.ID forKey:@"ID"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.reference forKey:@"reference"];
    [coder encodeObject:self.types forKey:@"types"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.vicinity forKey:@"vicinity"];
    [coder encodeObject:self.photos forKey:@"photos"];
    [coder encodeInteger:self.priceLevel forKey:@"priceLevel"];
    [coder encodeFloat:self.rating forKey:@"rating"];
    [coder encodeObject:self.events forKey:@"events"];
}

+ (id)placeDetailsWithObjects:(NSDictionary *)dictionary
{
    LPPlaceDetails *new = [LPPlaceDetails new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"address_components"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"address_components"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"address_components"] count]; i++) {
                LPAddressComponent *addressComponent = [LPAddressComponent addressComponentWithObjects:[[dictionary objectForKey:@"address_components"] objectAtIndex:i]];
                
                [array addObject:addressComponent];
            }
            
            new.addressComponents = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"adr_address"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"adr_address"]) {
            new.adrAddress = [dictionary objectForKey:@"adr_address"];
        }
        
        if (![[dictionary objectForKey:@"formatted_address"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"formatted_address"]) {
            new.formattedAddress = [dictionary objectForKey:@"formatted_address"];
        }
        
        if (![[dictionary objectForKey:@"geometry"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"geometry"]) {
            new.geometry = [LPGeometry geometryWithObjects:[dictionary objectForKey:@"geometry"]];
        }
        
        if (![[dictionary objectForKey:@"icon"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"icon"]) {
            new.icon = [dictionary objectForKey:@"icon"];
        }
        
        if (![[dictionary objectForKey:@"id"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"id"]) {
            new.ID=[dictionary objectForKey:@"id"];
        }
        
        if (![[dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"name"]) {
            new.name=[dictionary objectForKey:@"name"];
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
        
        if (![[dictionary objectForKey:@"url"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"url"]) {
            new.url = [dictionary objectForKey:@"url"];
        }
        
        if (![[dictionary objectForKey:@"vicinity"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"vicinity"]) {
            new.vicinity=[dictionary objectForKey:@"vicinity"];
        }
        
        if (![[dictionary objectForKey:@"photos"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"photos"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"photos"] count]; i++) {
                LPPlacePhoto *photo = [LPPlacePhoto placePhotoWithObjects:[[dictionary objectForKey:@"photos"] objectAtIndex:i]];
                                       
                [array addObject:photo];
            }
            
            new.photos = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"price_level"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"price_level"]) {
            new.priceLevel = [[dictionary objectForKey:@"price_level"] intValue];
        }
        
        if (![[dictionary objectForKey:@"rating"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"rating"]) {
            new.rating = [[dictionary objectForKey:@"rating"] floatValue];
        }
        
        if (![[dictionary objectForKey:@"events"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"events"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"events"] count]; i++) {
                LPEvent *event = [LPEvent eventWithObjects:[[dictionary objectForKey:@"events"] objectAtIndex:i]];
                
                [array addObject:event];
            }
            
            new.events = [NSArray arrayWithArray:array];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"adrAddress", @"formattedAddress", @"icon", @"ID", @"name", @"reference", @"url", @"vicinity", nil]]];

    if (self.geometry && ![self.geometry isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.geometry.dictionary forKey:@"geometry"];
    }
    
    if (self.addressComponents && ![self.addressComponents isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.addressComponents count]; i++) {
            [array addObject:((LPAddressComponent *)[self.addressComponents objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"addressComponents"];
    }
    
    if (self.types && ![self.types isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.types count]; i++) {
            [array addObject:[self.types objectAtIndex:i]];
        }
        
        [dictionary setObject:array forKey:@"types"];
    }
    
    if (self.photos && ![self.photos isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.photos count]; i++) {
            LPPlacePhoto *photo = (LPPlacePhoto *)[self.photos objectAtIndex:i];
            
            [array addObject:photo.dictionary];
        }
        
        [dictionary setObject:array forKey:@"photos"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%d", self.priceLevel] forKey:@"priceLevel"];
    [dictionary setObject:[NSString stringWithFormat:@"%.1f", self.rating] forKey:@"rating"];
    
    if (self.events && ![self.events isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.events count]; i++) {
            LPEvent *event = (LPEvent *)[self.events objectAtIndex:i];
            
            [array addObject:event.dictionary];
        }
        
        [dictionary setObject:array forKey:@"events"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPPlaceDetails *new = [LPPlaceDetails new];
    
    [new setAdrAddress:[self adrAddress]];
    [new setFormattedAddress:[self formattedAddress]];
    [new setGeometry:[self geometry]];
    [new setIcon:[self icon]];
    [new setID:[self ID]];
    [new setName:[self name]];
    [new setReference:[self reference]];
    [new setTypes:[self types]];
    [new setUrl:[self url]];
    [new setVicinity:[self vicinity]];
    [new setPriceLevel:self.priceLevel];
    [new setEvents:self.events];
    
    return new;
}

@end
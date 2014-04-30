//
//  LPAddressComponent.m
//
//  Created by Luka Penger on 7/26/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPAddressComponent.h"


@implementation LPAddressComponent

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPAddressComponent new];
    if (self) {
        self.longName = [coder decodeObjectForKey:@"longName"];
        self.shortName = [coder decodeObjectForKey:@"shortName"];
        self.types = [coder decodeObjectForKey:@"types"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.longName forKey:@"longName"];
    [coder encodeObject:self.shortName forKey:@"shortName"];
    [coder encodeObject:self.types forKey:@"types"];
}

+ (id)addressComponentWithObjects:(NSDictionary *)dictionary
{
    LPAddressComponent *new = [LPAddressComponent new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"long_name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"long_name"]) {
            new.longName = [dictionary objectForKey:@"long_name"];
        }
        
        if (![[dictionary objectForKey:@"short_name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"short_name"]) {
            new.shortName = [dictionary objectForKey:@"short_name"];
        }
        
        if (![[dictionary objectForKey:@"types"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"types"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"types"] count]; i++) {
                [array addObject:[[dictionary objectForKey:@"types"] objectAtIndex:i]];
            }
            
            new.types = [NSArray arrayWithArray:array];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:self.longName forKey:@"longName"];
    [dictionary setObject:self.shortName forKey:@"shortName"];
    
    if (self.types && ![self.types isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.types count]; i++) {
            [array addObject:[self.types objectAtIndex:i]];
        }
        
        [dictionary setObject:array forKey:@"types"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPAddressComponent *new = [LPAddressComponent new];
    
    [new setLongName:[self longName]];
    [new setShortName:[self shortName]];
    [new setTypes:[self types]];
    
    return new;
}

@end
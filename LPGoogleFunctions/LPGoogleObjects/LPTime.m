//
//  LPTime.m
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPTime.h"


@implementation LPTime

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPTime new];
    if (self) {
        self.text = [coder decodeObjectForKey:@"text"];
        self.timeZone = [coder decodeObjectForKey:@"timeZone"];
        self.value = [coder decodeFloatForKey:@"value"];
        self.formattedTime = [coder decodeObjectForKey:@"formattedTime"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.text forKey:@"text"];
    [coder encodeObject:self.timeZone forKey:@"timeZone"];
    [coder encodeFloat:self.value forKey:@"value"];
    [coder encodeObject:self.formattedTime forKey:@"formattedTime"];
}

+ (id)timeWithObjects:(NSDictionary *)dictionary
{
    LPTime *new = [LPTime new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"text"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"text"]) {
            new.text = [dictionary objectForKey:@"text"];
        }
        
        if (![[dictionary objectForKey:@"time_zone"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"time_zone"]) {
            new.timeZone = [dictionary objectForKey:@"time_zone"];
        }
        
        if (![[dictionary objectForKey:@"value"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"value"]) {
            new.value = [[dictionary objectForKey:@"value"] floatValue];
        }
        
        if (new.text && new.timeZone) {
            new.formattedTime = [NSDate dateWithTimeIntervalSince1970:new.value];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.text] forKey:@"text"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.timeZone] forKey:@"timeZone"];
    [dictionary setObject:[NSString stringWithFormat:@"%f", self.value] forKey:@"value"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.formattedTime.description] forKey:@"formattedTime"];
        
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPTime *new = [LPTime new];
    
    [new setText:[self text]];
    [new setTimeZone:[self timeZone]];
    [new setValue:[self value]];
    [new setFormattedTime:[self formattedTime]];
    
    return new;
}

@end
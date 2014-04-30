//
//  LPStop.m
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPStop.h"


@implementation LPStop

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPStop new];
    if (self) {
        self.location = [coder decodeObjectForKey:@"location"];
        self.name = [coder decodeObjectForKey:@"name"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.location forKey:@"location"];
    [coder encodeObject:self.name forKey:@"name"];
}

+ (id)stopWithObjects:(NSDictionary *)dictionary
{
    LPStop *new = [LPStop new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"location"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"location"]) {
            new.location = [LPLocation locationWithObjects:[dictionary objectForKey:@"location"]];
        }
        
        if (![[dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"name"]) {
            new.name = [dictionary objectForKey:@"name"];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.location && ![self.location isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.location.dictionary forKey:@"location"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.name] forKey:@"name"];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPStop *new = [LPStop new];
    
    [new setLocation:[self location]];
    [new setName:[self name]];
    
    return new;
}

@end
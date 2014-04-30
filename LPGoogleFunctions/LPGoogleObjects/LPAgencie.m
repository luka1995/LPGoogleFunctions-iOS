//
//  LPAgencie.m
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPAgencie.h"


@implementation LPAgencie

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPAgencie new];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.url = [coder decodeObjectForKey:@"url"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.url forKey:@"url"];
}

+ (id)agencieWithObjects:(NSDictionary *)dictionary
{
    LPAgencie *new = [LPAgencie new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"name"]) {
            new.name = [dictionary objectForKey:@"name"];
        }
        
        if (![[dictionary objectForKey:@"url"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"url"]) {
            new.url = [dictionary objectForKey:@"url"];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    [dictionary setObject:[NSString stringWithFormat:@"%@", self.name] forKey:@"name"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.url] forKey:@"url"];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPAgencie *new = [LPAgencie new];
    
    [new setName:[self name]];
    [new setUrl:[self url]];
    
    return new;
}

@end
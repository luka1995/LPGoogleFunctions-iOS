//
//  LPTerm.m
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPTerm.h"


@implementation LPTerm

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPTerm new];
    if (self) {
        self.value = [coder decodeObjectForKey:@"value"];
        self.offset = [coder decodeIntForKey:@"offset"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.value forKey:@"value"];
    [coder encodeInt:self.offset forKey:@"offset"];
}

+ (id)termWithObjects:(NSDictionary *)dictionary
{
    LPTerm *new = [LPTerm new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"value"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"value"]) {
            new.value=[dictionary objectForKey:@"value"];
        }
        
        if (![[dictionary objectForKey:@"offset"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"offset"]) {
            new.offset=[[dictionary objectForKey:@"offset"] intValue];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"value", @"offset", nil]]];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPTerm *new = [LPTerm new];
    
    [new setValue:[self value]];
    [new setOffset:[self offset]];
    
    return new;
}

@end
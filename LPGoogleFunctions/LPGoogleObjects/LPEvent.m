//
//  LPEvent.m
//
//  Created by Luka Penger on 8/20/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPEvent.h"


@implementation LPEvent

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPEvent new];
    if (self) {
        self.eventID = [coder decodeObjectForKey:@"eventID"];
        self.summary = [coder decodeObjectForKey:@"summary"];
        self.URL = [coder decodeObjectForKey:@"URL"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.eventID forKey:@"eventID"];
    [coder encodeObject:self.summary forKey:@"summary"];
    [coder encodeObject:self.URL forKey:@"URL"];
}

+ (id)eventWithObjects:(NSDictionary *)dictionary
{
    LPEvent *new = [LPEvent new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"event_id"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"event_id"]) {
            new.eventID = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"event_id"]];
        }

        if (![[dictionary objectForKey:@"summary"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"summary"]) {
            new.summary = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"summary"]];
        }
        
        if (![[dictionary objectForKey:@"url"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"url"]) {
            new.URL = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"url"]];
        }
    }
    
	return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"eventID", @"summary", @"URL", nil]]];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPEvent *new = [LPEvent new];
    
    [new setEventID:self.eventID];
    [new setSummary:self.summary];
    [new setURL:self.URL];
    
    return new;
}

@end

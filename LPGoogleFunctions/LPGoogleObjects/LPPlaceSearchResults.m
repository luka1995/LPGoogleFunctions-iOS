//
//  LPPlaceSearchResults.m
//
//  Created by Luka Penger on 8/20/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPlaceSearchResults.h"


@implementation LPPlaceSearchResults

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPlaceSearchResults new];
    if (self) {
        self.results = [coder decodeObjectForKey:@"results"];
        self.statusCode = [coder decodeObjectForKey:@"statusCode"];
        self.htmlAttributions = [coder decodeObjectForKey:@"htmlAttributions"];
        self.nextPageToken = [coder decodeObjectForKey:@"nextPageToken"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.results forKey:@"results"];
    [coder encodeObject:self.statusCode forKey:@"statusCode"];
    [coder encodeObject:self.htmlAttributions forKey:@"htmlAttributions"];
    [coder encodeObject:self.nextPageToken forKey:@"nextPageToken"];
}

+ (id)placeSearchResultsWithObjects:(NSDictionary *)dictionary
{
    LPPlaceSearchResults *new = [LPPlaceSearchResults new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"results"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"results"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"results"] count]; i++) {
                LPPlaceDetails *place = [LPPlaceDetails placeDetailsWithObjects:[[dictionary objectForKey:@"results"] objectAtIndex:i]];
                
                [array addObject:place];
            }
            
            new.results = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"status"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"status"]) {
            new.statusCode = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
        }
        
        if (![[dictionary objectForKey:@"html_attributions"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"html_attributions"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"html_attributions"] count]; i++) {
                [array addObject:[[dictionary objectForKey:@"html_attributions"] objectAtIndex:i]];
            }
            
            new.htmlAttributions = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"next_page_token"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"next_page_token"]) {
            new.nextPageToken = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"next_page_token"]];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.results && ![self.results isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.results count]; i++) {
            [array addObject:((LPPlaceDetails *)[self.results objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"results"];
    }

    [dictionary setObject:[NSString stringWithFormat:@"%@", self.statusCode] forKey:@"statusCode"];
    
    if (self.htmlAttributions && ![self.htmlAttributions isKindOfClass:[NSNull class]]) {
        [dictionary setObject:[NSString stringWithFormat:@"%@", self.htmlAttributions.description] forKey:@"htmlAttributions"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.nextPageToken] forKey:@"nextPageToken"];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPPlaceSearchResults *new = [LPPlaceSearchResults new];
    
    [new setResults:[self results]];
    [new setStatusCode:[self statusCode]];
    [new setHtmlAttributions:self.htmlAttributions];
    [new setNextPageToken:self.nextPageToken];
    
    return new;
}

@end

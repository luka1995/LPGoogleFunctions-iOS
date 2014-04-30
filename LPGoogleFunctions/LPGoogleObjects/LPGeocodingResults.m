//
//  LPGeocodingResults.m
//
//  Created by Luka Penger on 7/28/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPGeocodingResults.h"


@implementation LPGeocodingResults

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPGeocodingResults new];
    if (self) {
        self.results = [coder decodeObjectForKey:@"results"];
        self.statusCode = [coder decodeObjectForKey:@"statusCode"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.results forKey:@"results"];
    [coder encodeObject:self.statusCode forKey:@"statusCode"];
}

+ (id)geocodingResultsWithObjects:(NSDictionary *)dictionary
{
    LPGeocodingResults *new = [LPGeocodingResults new];

    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"results"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"results"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"results"] count]; i++) {
                LPPlaceDetails *placeDetails = [LPPlaceDetails placeDetailsWithObjects:[[dictionary objectForKey:@"results"] objectAtIndex:i]];
                
                [array addObject:placeDetails];
            }
            
            new.results=[NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"status"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"status"]) {
            new.statusCode = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"status"]];
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
            LPPlaceDetails *placeDetails = (LPPlaceDetails *)[self.results objectAtIndex:i];
            
            [array addObject:placeDetails.dictionary];
        }
        
        [dictionary setObject:array forKey:@"results"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.statusCode] forKey:@"statusCode"];
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPGeocodingResults *new = [LPGeocodingResults new];
    
    [new setResults:[self results]];
    [new setStatusCode:[self statusCode]];
    
    return new;
}

@end
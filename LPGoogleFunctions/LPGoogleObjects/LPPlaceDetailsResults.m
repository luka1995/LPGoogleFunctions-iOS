//
//  LPPlaceDetailsResults.m
//
//  Created by Luka Penger on 7/26/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPlaceDetailsResults.h"

@implementation LPPlaceDetailsResults

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPlaceDetailsResults new];
    if (self != nil)
	{
        self.htmlAttributions = [coder decodeObjectForKey:@"htmlAttributions"];
        self.result = [coder decodeObjectForKey:@"result"];
        self.statusCode = [coder decodeObjectForKey:@"statusCode"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.htmlAttributions forKey:@"htmlAttributions"];
    [coder encodeObject:self.result forKey:@"result"];
    [coder encodeObject:self.statusCode forKey:@"statusCode"];
}

+ (id)placeDetailsResultsWithObjects:(NSDictionary*)dictionary
{
    LPPlaceDetailsResults *new = [LPPlaceDetailsResults new];
    
    if(![dictionary isKindOfClass:[NSNull class]])
    {
        if (![[dictionary objectForKey:@"html_attributions"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"html_attributions"] != nil) {
            NSMutableArray *array = [NSMutableArray new];
            
            for(int i=0;i<[[dictionary objectForKey:@"html_attributions"] count];i++)
            {
                [array addObject:[[dictionary objectForKey:@"html_attributions"] objectAtIndex:i]];
            }
            
            new.htmlAttributions = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"result"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"result"] != nil) {
            new.result = [LPPlaceDetails placeDetailsWithObjects:[dictionary objectForKey:@"result"]];
        }
        
        if (![[dictionary objectForKey:@"status"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"status"] != nil) {
            new.statusCode = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
        }
    }
    
    return new;
}

- (NSDictionary*)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if(self.htmlAttributions!=nil && ![self.htmlAttributions isKindOfClass:[NSNull class]])
    {
        [dictionary setObject:[NSString stringWithFormat:@"%@",self.htmlAttributions.description] forKey:@"htmlAttributions"];
    }
    
    if(self.result!=nil && ![self.result isKindOfClass:[NSNull class]])
    {
        [dictionary setObject:self.result.dictionary forKey:@"result"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%@",self.statusCode] forKey:@"statusCode"];
    
    return dictionary;
}

- (NSString*)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPPlaceDetailsResults *new = [LPPlaceDetailsResults new];
    [new setResult:[self result]];
    [new setStatusCode:[self statusCode]];
    [new setHtmlAttributions:self.htmlAttributions];
    return new;
}

@end
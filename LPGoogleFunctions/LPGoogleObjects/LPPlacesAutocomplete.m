//
//  LPPlacesAutocomplete.m
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPlacesAutocomplete.h"


@implementation LPPlacesAutocomplete

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPlacesAutocomplete new];
    if (self) {
        self.predictions = [coder decodeObjectForKey:@"predictions"];
        self.statusCode = [coder decodeObjectForKey:@"statusCode"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.predictions forKey:@"predictions"];
    [coder encodeObject:self.statusCode forKey:@"statusCode"];
}

+ (id)placesAutocompleteWithObjects:(NSDictionary*)dictionary
{
    LPPlacesAutocomplete *new = [LPPlacesAutocomplete new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"predictions"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"predictions"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"predictions"] count]; i++) {
                LPPrediction *predictions = [LPPrediction predicationWithObjects:[[dictionary objectForKey:@"predictions"] objectAtIndex:i]];
                predictions.number = i;
                
                [array addObject:predictions];
            }
            
            new.predictions = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"status"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"status"]) {
            new.statusCode = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.predictions && ![self.predictions isKindOfClass:[NSNull class]])  {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.predictions count]; i++) {
            [array addObject:((LPPrediction *)[self.predictions objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"predictions"];
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
    LPPlacesAutocomplete *new = [LPPlacesAutocomplete new];
    
    [new setPredictions:[self predictions]];
    [new setStatusCode:[self statusCode]];
    
    return new;
}

@end

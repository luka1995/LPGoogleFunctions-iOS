//
//  LPPlacesAutocomplate.m
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPlacesAutocomplate.h"

@implementation LPPlacesAutocomplate

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPlacesAutocomplate new];
    if (self != nil)
	{
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

+ (id)placesAutocomplateWithObjects:(NSDictionary*)dictionary
{
    LPPlacesAutocomplate *new = [LPPlacesAutocomplate new];
    
    if(![dictionary isKindOfClass:[NSNull class]])
    {
        if (![[dictionary objectForKey:@"predictions"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"predictions"] != nil) {
            NSMutableArray *array = [NSMutableArray new];
            
            for(int i=0;i<[[dictionary objectForKey:@"predictions"] count];i++)
            {
                LPPrediction *predictions = [LPPrediction predicationWithObjects:[[dictionary objectForKey:@"predictions"] objectAtIndex:i]];
                predictions.number=i;
                [array addObject:predictions];
            }
            
            new.predictions=[NSArray arrayWithArray:array];
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
    
    if(self.predictions!=nil && ![self.predictions isKindOfClass:[NSNull class]])
    {
        NSMutableArray *array = [NSMutableArray new];
        
        for(int i=0;i<[self.predictions count];i++)
        {
            [array addObject:((LPPrediction*)[self.predictions objectAtIndex:i]).dictionary];
        }
        
        [dictionary setObject:array forKey:@"predictions"];
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
    LPPlacesAutocomplate *new = [LPPlacesAutocomplate new];
    [new setPredictions:[self predictions]];
    [new setStatusCode:[self statusCode]];
    return new;
}

@end

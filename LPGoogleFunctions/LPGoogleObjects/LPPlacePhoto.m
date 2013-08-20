//
//  LPPlacePhoto.m
//
//  Created by Luka Penger on 8/20/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPlacePhoto.h"

@implementation LPPlacePhoto

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPlacePhoto new];
    if (self != nil)
	{
        self.htmlAttributions = [coder decodeObjectForKey:@"htmlAttributions"];
        self.height = [coder decodeIntegerForKey:@"height"];
        self.width = [coder decodeIntegerForKey:@"width"];
        self.photoReference = [coder decodeObjectForKey:@"photoReference"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.htmlAttributions forKey:@"htmlAttributions"];
    [coder encodeInteger:self.height forKey:@"height"];
    [coder encodeInteger:self.width forKey:@"width"];
    [coder encodeObject:self.photoReference forKey:@"photoReference"];
}

+ (id)placePhotoWithObjects:(NSDictionary *)dictionary
{
    LPPlacePhoto *new = [LPPlacePhoto new];
    
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
        
        if (![[dictionary objectForKey:@"height"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"height"] != nil) {
            new.height = [[dictionary objectForKey:@"height"] intValue];
        }
        
        if (![[dictionary objectForKey:@"width"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"width"] != nil) {
            new.width = [[dictionary objectForKey:@"width"] intValue];
        }
        
        if (![[dictionary objectForKey:@"photo_reference"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"photo_reference"] != nil) {
            new.photoReference = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"photo_reference"]];
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
    
    [dictionary setObject:[NSString stringWithFormat:@"%d",self.height] forKey:@"height"];
    
    [dictionary setObject:[NSString stringWithFormat:@"%d",self.width] forKey:@"width"];
    
    [dictionary setObject:[NSString stringWithFormat:@"%@",self.photoReference] forKey:@"photoReference"];
    
    return dictionary;
}

- (NSString*)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPPlacePhoto *new = [LPPlacePhoto new];
    [new setHtmlAttributions:self.htmlAttributions];
    [new setHeight:self.height];
    [new setWidth:self.width];
    [new setPhotoReference:self.photoReference];
    return new;
}

@end
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
    if (self) {
        self.htmlAttributions = [coder decodeObjectForKey:@"htmlAttributions"];
        self.height = [coder decodeIntForKey:@"height"];
        self.width = [coder decodeIntForKey:@"width"];
        self.photoReference = [coder decodeObjectForKey:@"photoReference"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.htmlAttributions forKey:@"htmlAttributions"];
    [coder encodeInt:self.height forKey:@"height"];
    [coder encodeInt:self.width forKey:@"width"];
    [coder encodeObject:self.photoReference forKey:@"photoReference"];
}

+ (id)placePhotoWithObjects:(NSDictionary *)dictionary
{
    LPPlacePhoto *new = [LPPlacePhoto new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"html_attributions"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"html_attributions"]) {
            NSMutableArray *array = [NSMutableArray new];
            
            for (int i=0; i<[[dictionary objectForKey:@"html_attributions"] count]; i++) {
                NSString *string = [[dictionary objectForKey:@"html_attributions"] objectAtIndex:i];
                
                [array addObject:string];
            }
            
            new.htmlAttributions = [NSArray arrayWithArray:array];
        }
        
        if (![[dictionary objectForKey:@"height"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"height"]) {
            new.height = [[dictionary objectForKey:@"height"] intValue];
        }
        
        if (![[dictionary objectForKey:@"width"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"width"]) {
            new.width = [[dictionary objectForKey:@"width"] intValue];
        }
        
        if (![[dictionary objectForKey:@"photo_reference"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"photo_reference"]) {
            new.photoReference = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"photo_reference"]];
        }
    }
    
    return new;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.htmlAttributions && ![self.htmlAttributions isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0; i<[self.htmlAttributions count]; i++) {
            NSString *string = (NSString *)[self.htmlAttributions objectAtIndex:i];
            
            [array addObject:string.description];
        }
        
        [dictionary setObject:array forKey:@"htmlAttributions"];
    }
    
    [dictionary setObject:[NSString stringWithFormat:@"%d", self.height] forKey:@"height"];
    [dictionary setObject:[NSString stringWithFormat:@"%d", self.width] forKey:@"width"];
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.photoReference] forKey:@"photoReference"];
    
    return dictionary;
}

- (NSString *)description
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
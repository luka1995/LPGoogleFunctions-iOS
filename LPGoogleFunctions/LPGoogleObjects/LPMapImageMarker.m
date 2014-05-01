//
//  LPMapImageMarker.m
//
//  Created by Luka Penger on 7/6/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPMapImageMarker.h"


@implementation LPMapImageMarker

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPMapImageMarker new];
    if (self) {
        self.size = [coder decodeIntForKey:@"size"];
        self.color = [coder decodeObjectForKey:@"color"];
        self.label = [coder decodeObjectForKey:@"label"];
        self.location = [coder decodeObjectForKey:@"location"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInt:self.size forKey:@"size"];
    [coder encodeObject:self.color forKey:@"color"];
    [coder encodeObject:self.label forKey:@"label"];
    [coder encodeObject:self.location forKey:@"location"];
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"size", @"label", @"iconCustomPinURL", nil]]];
    
    [dictionary setObject:[self getColorString] forKey:@"color"];
    
    if (self.location && ![self.location isKindOfClass:[NSNull class]]) {
        [dictionary setObject:self.location.dictionary forKey:@"location"];
    }
    
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (NSString *)getColorString
{
    if (self.color)  {
        CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
        [self.color getRed:&red green:&green blue:&blue alpha:&alpha];

        return [NSString stringWithFormat:@"0x%02x%02x%02x", (int)(255.0 * red), (int)(255.0 * green), (int)(255.0 * blue)];
    } else {
        return @"0x000000";
    }
}

- (NSString *)getSizeString
{
    switch (self.size) {
        case LPGoogleMapImageMarkerSizeMid:
            return @"mid";
        case LPGoogleMapImageMarkerSizeTiny:
            return @"tiny";
        case LPGoogleMapImageMarkerSizeSmall:
            return @"small";
        default:
            return @"";
    }
}

- (NSString *)getMarkerURLString
{
    NSString *string = [NSString stringWithFormat:@"size:%@|color:%@|label:%@|%f,%f", [self getSizeString], [self getColorString], self.label, self.location.latitude, self.location.longitude];

    return string;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPMapImageMarker *new = [LPMapImageMarker new];
    
    [new setSize:[self size]];
    [new setColor:[self color]];
    [new setLabel:[self label]];
    [new setLocation:[self location]];
    
    return new;
}

@end

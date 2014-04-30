//
//  LPPolyline.m
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPPolyline.h"


@implementation LPPolyline

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPPolyline new];
    if (self) {
        self.pointsString = [coder decodeObjectForKey:@"pointsString"];
        self.pointsArray = [coder decodeObjectForKey:@"pointsArray"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.pointsString forKey:@"pointsString"];
    [coder encodeObject:self.pointsArray forKey:@"pointsArray"];
}

+ (id)polylineWithObjects:(NSDictionary *)dictionary
{
    LPPolyline *new = [LPPolyline new];
    
    if (![dictionary isKindOfClass:[NSNull class]]) {
        if (![[dictionary objectForKey:@"points"] isKindOfClass:[NSNull class]] && [dictionary objectForKey:@"points"]) {
            new.pointsString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"points"]];
            new.pointsArray = [self decodePolylineOfGoogleMaps:[dictionary objectForKey:@"points"]];
        }
    }
    
	return new;
}

+ (NSArray *)decodePolylineOfGoogleMaps:(NSString *)encodedPolyline
{
    NSUInteger length = [encodedPolyline length];
    NSInteger index = 0;
    NSMutableArray *points = [NSMutableArray new];
    CGFloat lat = 0.0f;
    CGFloat lng = 0.0f;
    
    while (index < length) {
        // Temorary variable to hold each ASCII byte.
        int b = 0;
        
        // The encoded polyline consists of a latitude value followed by a
        // longitude value. They should always come in pair. Read the
        // latitude value first.
        int shift = 0;
        int result = 0;
        
        do {
            // If index exceded lenght of encoding, finish 'chunk'
            if (index >= length) {
                b = 0;
            } else {
                // The '[encodedPolyline characterAtIndex:index++]' statement resturns the ASCII
                // code for the characted at index. Subtract 63 to get the original
                // value. (63 was added to ensure proper ASCII characters are displayed
                // in the encoded plyline string, wich id 'human' readable)
                b = [encodedPolyline characterAtIndex:index++] - 63;
            }
            // AND the bits of the byte with 0x1f to get the original 5-bit 'chunk'.
            // Then left shift the bits by the required amount, wich increases
            // by 5 bits each time.
            // OR the value into results, wich sums up the individual 5-bit chunks
            // into the original value. Since the 5-bit chunks were reserved in
            // order during encoding, reading them in this way ensures proper
            // summation.
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20); // Continue while the read byte is >= 0x20 since the last 'chunk'
        // was nor OR'd with 0x20 during the conversion process. (Signals the end).
        
        // check if negative, and convert. (All negative values have the last bit set)
        CGFloat dlat = (result & 1) ? ~(result >> 1) : (result >> 1);
        
        //Compute actual latitude since value is offset from previous value.
        lat += dlat;
        
        // The next value will correspond to the longitude for this point.
        shift = 0;
        result = 0;
        
        do {
            // If index exceded lenght of encoding, finish 'chunk'
            if (index >= length) {
                b = 0;
            } else {
                b = [encodedPolyline characterAtIndex:index++] - 63;
            }
            
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        
        CGFloat dlng = (result & 1) ? ~(result >> 1) : (result >> 1);
        lng += dlng;
        
        // The actual latitude and longitude values were multiplied by
        // 1e5 before encoding so that they could be converted to a 32-bit
        //integer representation. (With a decimal accuracy of 5 places)
        // Convert back to original value.

        LPLocation *location = [LPLocation locationWithLatitude:(lat * 1e-5) longitude:(lng * 1e-5)];
        
        [points addObject:location];
    }
    
    return points;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:[NSString stringWithFormat:@"%@", self.pointsString] forKey:@"pointsString"];
    
    if (self.pointsArray && ![self.pointsArray isKindOfClass:[NSNull class]]) {
        NSMutableArray *array = [NSMutableArray new];
    
        for (int i=0; i<[self.pointsArray count]; i++) {
            [array addObject:((LPLocation *)[self.pointsArray objectAtIndex:i]).dictionary];
        }

        [dictionary setObject:array forKey:@"pointsArray"];
    }
        
    return dictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

- (id)copyWithZone:(NSZone *)zone
{
    LPPolyline *new = [LPPolyline new];
    
    [new setPointsString:[self pointsString]];
    [new setPointsArray:[self pointsArray]];
    
    return new;
}

@end
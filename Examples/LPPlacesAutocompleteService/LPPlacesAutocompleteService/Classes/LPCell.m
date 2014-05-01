//
//  LPCell.m
//  LPPlacesAutocompleteService
//
//  Created by Luka Penger on 01/05/14.
//  Copyright (c) 2014 Luka Penger. All rights reserved.
//

#import "LPCell.h"


@implementation LPCell

+ (LPCell *)cellFromNibNamed:(NSString *)nibName
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    LPCell  *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[LPCell class]]) {
            xibBasedCell = (LPCell *)nibItem;
            break;
        }
    }
    
    return xibBasedCell;
}

@end

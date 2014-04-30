//
//  LPBounds.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPLocation.h"


@interface LPBounds : NSObject <NSCoding>

@property (nonatomic, strong) LPLocation *northeast;
@property (nonatomic, strong) LPLocation *southwest;

+ (id)boundsWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

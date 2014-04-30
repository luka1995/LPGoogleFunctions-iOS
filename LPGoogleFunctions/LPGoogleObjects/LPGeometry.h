//
//  LPGeometry.h
//
//  Created by Luka Penger on 7/26/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPLocation.h"
#import "LPBounds.h"


@interface LPGeometry : NSObject <NSCoding>

@property (nonatomic, strong) LPLocation *location;
@property (nonatomic, strong) LPBounds *viewport;

+ (id)geometryWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
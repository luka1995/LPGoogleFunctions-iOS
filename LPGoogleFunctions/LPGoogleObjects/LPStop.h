//
//  LPStop.h
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPLocation.h"


@interface LPStop : NSObject <NSCoding>

@property (nonatomic, strong) LPLocation *location;
@property (nonatomic, strong) NSString *name;

+ (id)stopWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

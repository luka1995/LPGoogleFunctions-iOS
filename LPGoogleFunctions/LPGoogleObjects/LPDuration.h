//
//  LPDuration.h
//
//  Created by Luka Penger on 7/3/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LPDuration : NSObject <NSCoding>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) int value;

+ (id)durationWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
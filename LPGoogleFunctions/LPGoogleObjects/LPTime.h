//
//  LPTime.h
//
//  Created by Luka Penger on 7/27/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LPTime : NSObject <NSCoding>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *timeZone;
@property (nonatomic, assign) float value;
@property (nonatomic, strong) NSDate *formattedTime;

+ (id)timeWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

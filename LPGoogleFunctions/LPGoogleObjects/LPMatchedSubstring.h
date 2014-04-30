//
//  LPMatchedSubstring.h
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LPMatchedSubstring : NSObject <NSCoding>

@property (nonatomic, assign) int length;
@property (nonatomic, assign) int offset;

+ (id)matchedSubstringWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
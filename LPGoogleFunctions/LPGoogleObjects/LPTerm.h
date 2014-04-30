//
//  LPTerm.h
//
//  Created by Luka Penger on 7/7/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LPTerm : NSObject <NSCoding>

@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) int offset;

+ (id)termWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end
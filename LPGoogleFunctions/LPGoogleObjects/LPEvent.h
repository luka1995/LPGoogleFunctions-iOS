//
//  LPEvent.h
//
//  Created by Luka Penger on 8/20/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LPEvent : NSObject <NSCopying>

@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *URL;

+ (id)eventWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

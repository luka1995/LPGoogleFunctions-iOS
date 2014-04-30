//
//  LPPlacePhoto.h
//
//  Created by Luka Penger on 8/20/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LPPlacePhoto : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *htmlAttributions;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int width;
@property (nonatomic, strong) NSString *photoReference;

+ (id)placePhotoWithObjects:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (id)copyWithZone:(NSZone *)zone;

@end

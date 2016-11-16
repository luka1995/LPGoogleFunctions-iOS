//
//  LPURLSigner.h
//  LPDistanceMatrixService
//
//  Created by Abdul Qavi on 03/06/2016.
//  Copyright © 2016 Luka Penger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPURLSigner : NSObject

+ (LPURLSigner *)sharedManager;

- (NSString *)createSignatureWithHMAC_SHA1:(NSString *)url key:(NSString *)key;

@end

//
//  LPURLSigner.m
//  LPDistanceMatrixService
//
//  Created by Abdul Qavi on 03/06/2016.
//  Copyright © 2016 Luka Penger. All rights reserved.
//

#import "LPURLSigner.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "GTMStringEncoding.h"

@implementation LPURLSigner

+ (LPURLSigner *)sharedManager {
    static LPURLSigner *_sharedManager = nil;
    _sharedManager = [[LPURLSigner alloc] init];
    return _sharedManager;
}

- (NSString *)createSignatureWithHMAC_SHA1:(NSString *)url key:(NSString *)key {
    
    // Stores the url in a NSData.
    NSData *urlData = [url dataUsingEncoding: NSASCIIStringEncoding];
    
    // URL-safe Base64 coder/decoder.
    GTMStringEncoding *encoding =
    [GTMStringEncoding rfc4648Base64WebsafeStringEncoding];
    
    // Decodes the URL-safe Base64 key to binary.
    NSData *binaryKey = [encoding decode:key];
    
    // Signs the URL.
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1,
           [binaryKey bytes], [binaryKey length],
           [urlData bytes], [urlData length],
           &result);
    NSData *binarySignature =
    [NSData dataWithBytes:&result length:CC_SHA1_DIGEST_LENGTH];
    
    // Encodes the signature to URL-safe Base64.
    NSString *signature = [encoding encode:binarySignature];
    
    return signature;
    
}

@end

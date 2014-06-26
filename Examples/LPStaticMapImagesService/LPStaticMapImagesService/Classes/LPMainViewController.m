//
//  LPMainViewController.m
//  LPStaticMapImagesService
//
//  Created by Luka Penger on 8/20/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPMainViewController.h"


NSString *const googleAPIBrowserKey = @"";


@interface LPMainViewController ()

@property (nonatomic, strong) LPGoogleFunctions *googleFunctions;

@end


@implementation LPMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Static Map";
    
    NSMutableArray *markers = [NSMutableArray new];
    
    LPMapImageMarker *marker1 = [LPMapImageMarker new];
    marker1.size = LPGoogleMapImageMarkerSizeNormal;
    marker1.location = [LPLocation locationWithLatitude:46.410471 longitude:15.66195];
    marker1.label = @"A";
    marker1.color = [UIColor blueColor];
    [markers addObject:marker1];
    
    LPMapImageMarker *marker2 = [LPMapImageMarker new];
    marker2.size = LPGoogleMapImageMarkerSizeNormal;
    marker2.location = [LPLocation locationWithLatitude:46.390351 longitude:15.66165];
    marker2.label = @"B";
    marker2.color = [UIColor greenColor];
    [markers addObject:marker2];
    
    // For Address
    /*
    [self.googleFunctions loadStaticMapImageForAddress:@"New York" zoomLevel:12 imageSize:CGSizeMake(self.imageView.frame.size.width,self.imageView.frame.size.height) imageScale:2 mapType:LPGoogleMapTypeHybrid markersArray:nil successfulBlock:^(UIImage *image) {
        
        [self.imageView setImage:image];

    } failureBlock:^(NSError *error) {
        
        NSLog(@"Error: %@",error);
        
    }];
    */
    // For Location

    [self.googleFunctions loadStaticMapImageForLocation:[LPLocation locationWithLatitude:46.395461 longitude:15.66195] zoomLevel:12 imageSize:CGSizeMake(self.imageView.frame.size.width,self.imageView.frame.size.height) imageScale:2 mapType:LPGoogleMapTypeHybrid markersArray:markers successfulBlock:^(UIImage *image) {
        
        [self.imageView setImage:image];
        
    } failureBlock:^(NSError *error) {
 
        NSLog(@"Error: %@",error);
 
    }];
}

#pragma mark - LPGoogleFunctions

- (LPGoogleFunctions *)googleFunctions
{
    if (!_googleFunctions) {
        _googleFunctions = [LPGoogleFunctions new];
        _googleFunctions.googleAPIBrowserKey = googleAPIBrowserKey;
        _googleFunctions.delegate = self;
        _googleFunctions.sensor = YES;
        _googleFunctions.languageCode = @"en";
    }
    return _googleFunctions;
}

@end

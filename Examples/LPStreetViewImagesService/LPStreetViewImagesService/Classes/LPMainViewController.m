//
//  LPMainViewController.m
//  LPStreetViewImagesService
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
    
    self.title = @"Street View";
    
    // For Address
    
    [self.googleFunctions loadStreetViewImageForAddress:@"London" imageSize:CGSizeMake(self.imageView.frame.size.width,self.imageView.frame.size.height) heading:0 fov:120 pitch:0 successfulBlock:^(UIImage *image) {

        [self.imageView setImage:image];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Error: %@",error);
    }];
    
    //For Location
    /*
    [self.googleFunctions loadStreetViewImageForLocation:[LPLocation locationWithLatitude:40.457375 longitude:-80.009353] imageSize:CGSizeMake(self.imageView.frame.size.width,self.imageView.frame.size.height) heading:0 fov:120 pitch:0 successfulBlock:^(UIImage *image) {
        
        [self.imageView setImage:image];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"Error: %@",error);
        
    }];*/
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

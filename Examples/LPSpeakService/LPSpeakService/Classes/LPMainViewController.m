//
//  LPMainViewController.m
//  LPPlacesAutocomplateService
//
//  Created by Luka Penger on 8/21/13.
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
    
    self.title = @"Speak Service";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
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

#pragma mark - Actions

- (IBAction)speakButtonClicked:(id)sender
{
    [self.googleFunctions speakText:self.textField.text failureBlock:^(NSError *error) {
        NSLog(@"Failure - Block: %@", error.description);
    }];
}

@end
//
//  LPMainViewController.m
//  PlacesAutocomplateService
//
//  Created by Luka Penger on 8/21/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPMainViewController.h"

@interface LPMainViewController ()

@end

@implementation LPMainViewController

NSString *const googleAPIBrowserKey = @"";

- (void)viewDidLoad
{
    [self.googleFunctions loadPlacesAutocompleteForInput:@"New York" offset:0 radius:0 location:nil placeType:LPGooglePlaceTypeGeocode countryRestriction:nil successfulBlock:^(LPPlacesAutocomplete *placesAutocomplete) {
        
        NSLog(@"successful");
        
        self.textView.text = placesAutocomplete.description;
        
        if(placesAutocomplete.predictions.count>0)
        {
            LPPrediction *prediction = (LPPrediction*)[placesAutocomplete.predictions objectAtIndex:0];
            
            NSString *reference = prediction.reference;
            
            [self.googleFunctions loadPlaceDetailsForReference:reference successfulBlock:^(LPPlaceDetailsResults *placeDetailsResults) {
                
                NSLog(@"successful load details");
                
                NSLog(@"%@",placeDetailsResults.description);
                
            } failureBlock:^(LPGoogleStatus status) {
                
                NSLog(@"Error loading details - Block: %@",[LPGoogleFunctions getGoogleStatus:status]);
                
            }];
        }
        
    } failureBlock:^(LPGoogleStatus status) {
        
        NSLog(@"Error - Block: %@",[LPGoogleFunctions getGoogleStatus:status]);
        
    }];
}

- (LPGoogleFunctions*)googleFunctions {
    if(!_googleFunctions) {
        _googleFunctions = [LPGoogleFunctions new];
        _googleFunctions.googleAPIBrowserKey = googleAPIBrowserKey;
        _googleFunctions.delegate = self;
        _googleFunctions.sensor = YES;
        //_googleFunctions.languageCode = "en" // set language
    }
    return _googleFunctions;
}

#pragma mark - LPGoogleFunctions Delegate Methods

- (void)googleFunctionsWillLoadPlacesAutocomplate:(LPGoogleFunctions *)googleFunctions forInput:(NSString *)input
{
    NSLog(@"willLoadPlacesAutcompleteForInput: %@",input);
}
    
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadPlacesAutocomplate:(LPPlacesAutocomplete *)placesAutocomplate
{
    NSLog(@"didLoadPlacesAutocomplete - Delegate");
}

- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingPlacesAutocomplateWithStatus:(LPGoogleStatus)status
{
    NSLog(@"errorLoadingPlacesAutocomplateWithStatus - Delegate: %@",[LPGoogleFunctions getGoogleStatus:status]);
}

@end

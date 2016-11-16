//
//  LPMainViewController.m
//  LPPlacesAutocomplateService
//
//  Created by Luka Penger on 8/21/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPMainViewController.h"


NSString *const googleAPIBrowserKey = @"AIzaSyDYq6cfchnqdab5cWBmNcw258IAr79SRV8";


@interface LPMainViewController ()

@property (nonatomic, strong) LPGoogleFunctions *googleFunctions;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) LPDistanceMatrix *distanceMatrix;

@end


@implementation LPMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Distance Matrix";
}

- (IBAction)didTapMyLocation:(id)sender {
    
    [self initLocationManager];
}

- (IBAction)didTapAvoidFerries:(id)sender {
    NSMutableArray *originsArray = [NSMutableArray new];
    NSMutableArray *destinationsArray = [NSMutableArray new];
    ////////////////////////
    // Avoid Ferries example
    //54.9295559,10.8084975
    //54.8788256,10.991052
    ////////////////////////
    [originsArray addObject:[LPLocation locationWithLatitude:54.9295559 longitude:10.8084975]];
    [destinationsArray addObject:[LPLocation locationWithLatitude:54.8788256 longitude:10.991052]];
    
    [self.googleFunctions loadDistanceMatrixForOrigins:originsArray forDestinations:destinationsArray directionsTravelMode:LPGoogleDistanceMatrixModeDriving directionsAvoidTolls:LPGoogleDistanceMatrixAvoidFerries directionsUnit:LPGoogleDistanceMatrixUnitMetric departureTime:nil successfulBlock:^(LPDistanceMatrix *distanceMatrix) {
        self.distanceMatrix = distanceMatrix;
        
        self.textView.text = self.distanceMatrix.description;
    } failureBlock:^(LPGoogleStatus status) {
        NSLog(@"Error: %@", [LPGoogleFunctions getGoogleStatus:status]);
    }];
}

#pragma mark - CLLocationManager & Delegate

- (void)initLocationManager
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 5;
    
    if ([CLLocationManager locationServicesEnabled])
    {
        NSLog(@"location services enabled");
    } else {
        NSLog(@"location services disabled");
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations.count > 0) {
        CLLocation *currentLocation = (CLLocation*)[locations objectAtIndex:0];
        
        NSMutableArray *originsArray = [NSMutableArray new];
        NSMutableArray *destinationsArray = [NSMutableArray new];
        [originsArray addObject:[LPLocation locationWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude]];
                [destinationsArray addObject:[LPLocation locationWithLatitude:46.033928 longitude:14.447681]];
        
        [self.googleFunctions loadDistanceMatrixForOrigins:originsArray forDestinations:destinationsArray directionsTravelMode:LPGoogleDistanceMatrixModeDriving directionsAvoidTolls:LPGoogleDistanceMatrixAvoidFerries directionsUnit:LPGoogleDistanceMatrixUnitMetric departureTime:nil successfulBlock:^(LPDistanceMatrix *distanceMatrix) {
            self.distanceMatrix = distanceMatrix;
            
            self.textView.text = self.distanceMatrix.description;
        } failureBlock:^(LPGoogleStatus status) {
            NSLog(@"Error: %@", [LPGoogleFunctions getGoogleStatus:status]);
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationManager - didFailWithError: %@",error.description);
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

#pragma mark - LPGoogleFunctions Delegate

- (void)googleFunctionsWillLoadPlacesAutocomplate:(LPGoogleFunctions *)googleFunctions forInput:(NSString *)input
{
    NSLog(@"willLoadPlacesAutcompleteForInput: %@", input);
}

- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadPlacesAutocomplate:(LPPlacesAutocomplete *)placesAutocomplate
{
    NSLog(@"didLoadPlacesAutocomplete - Delegate");
}

- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingPlacesAutocomplateWithStatus:(LPGoogleStatus)status
{
    NSLog(@"errorLoadingPlacesAutocomplateWithStatus - Delegate: %@", [LPGoogleFunctions getGoogleStatus:status]);
}


@end
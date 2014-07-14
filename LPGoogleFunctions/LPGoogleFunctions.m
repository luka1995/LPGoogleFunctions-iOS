//
//  LPGoogleFunctions.m
//
//  Created by Luka Penger on 7/4/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2013 Luka Penger
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LPGoogleFunctions.h"


NSString *const STATUS_OK = @"OK";
NSString *const STATUS_NOT_FOUND = @"NOT_FOUND";
NSString *const STATUS_ZERO_RESULTS = @"ZERO_RESULTS";
NSString *const STATUS_MAX_WAYPOINTS_EXCEEDED = @"MAX_WAYPOINTS_EXCEEDED";
NSString *const STATUS_INVALID_REQUEST = @"INVALID_REQUEST";
NSString *const STATUS_OVER_QUERY_LIMIT = @"OVER_QUERY_LIMIT";
NSString *const STATUS_REQUEST_DENIED = @"REQUEST_DENIED";
NSString *const STATUS_UNKNOWN_ERROR = @"UNKNOWN_ERROR";

NSString *const googleAPIDirectionsURL = @"http://maps.googleapis.com/maps/api/directions/json?";
NSString *const googleAPIStaticMapImageURL = @"http://maps.googleapis.com/maps/api/staticmap?";
NSString *const googleAPIStreetViewImageURL = @"http://maps.googleapis.com/maps/api/streetview?";
NSString *const googleAPIPlacesAutocompleteURL = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?";
NSString *const googleAPITextToSpeechURL = @"http://translate.google.com/translate_tts?";
NSString *const googleAPIPlaceDetailsURL = @"https://maps.googleapis.com/maps/api/place/details/json?";
NSString *const googleAPIGeocodingURL = @"http://maps.googleapis.com/maps/api/geocode/json?";
NSString *const googleAPIPlaceTextSearchURL = @"https://maps.googleapis.com/maps/api/place/textsearch/json?";
NSString *const googleAPIPlacePhotoURL = @"https://maps.googleapis.com/maps/api/place/photo?";
NSString *const googleAPIDistanceMatrixURL = @"https://maps.googleapis.com/maps/api/distancematrix/json?";

@interface LPGoogleFunctions ()

@end


@implementation LPGoogleFunctions

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        self.sensor = YES;
        self.languageCode = @"en";
    }
    return self;
}

#pragma mark - Functions

+ (NSString *)getMapType:(LPGoogleMapType)maptype
{
    switch (maptype) {
        case LPGoogleMapTypeRoadmap:
            return @"roadmap";
        case LPGoogleMapTypeHybrid:
            return @"hybrid";
        case LPGoogleMapTypeSatellite:
            return @"satellite";
        default:
            return @"terrain";
    }
}

+ (LPGoogleStatus)getGoogleStatusFromString:(NSString *)status
{
    if ([status isEqualToString:STATUS_OK]) {
        return LPGoogleStatusOK;
    } else if ([status isEqualToString:STATUS_NOT_FOUND]) {
        return LPGoogleStatusNotFound;
    } else if ([status isEqualToString:STATUS_ZERO_RESULTS]) {
        return LPGoogleStatusZeroResults;
    } else if ([status isEqualToString:STATUS_MAX_WAYPOINTS_EXCEEDED]) {
        return LPGoogleStatusMaxWaypointsExceeded;
    } else if ([status isEqualToString:STATUS_INVALID_REQUEST]) {
        return LPGoogleStatusInvalidRequest;
    } else if ([status isEqualToString:STATUS_OVER_QUERY_LIMIT]) {
        return LPGoogleStatusOverQueryLimit;
    } else if ([status isEqualToString:STATUS_REQUEST_DENIED]) {
        return LPGoogleStatusRequestDenied;
    } else {
        return LPGoogleStatusUnknownError;
    }
}

+ (NSString*)getGoogleStatus:(LPGoogleStatus)status
{
    switch (status) {
        case LPGoogleStatusOK:
            return STATUS_OK;
        case LPGoogleStatusInvalidRequest:
            return STATUS_INVALID_REQUEST;
        case LPGoogleStatusMaxWaypointsExceeded:
            return STATUS_MAX_WAYPOINTS_EXCEEDED;
        case LPGoogleStatusNotFound:
            return STATUS_NOT_FOUND;
        case LPGoogleStatusOverQueryLimit:
            return STATUS_OVER_QUERY_LIMIT;
        case LPGoogleStatusRequestDenied:
            return STATUS_REQUEST_DENIED;
        case LPGoogleStatusZeroResults:
            return STATUS_ZERO_RESULTS;
        default:
            return STATUS_UNKNOWN_ERROR;
    }
}

- (void)loadDirectionsForOrigin:(LPLocation *)origin forDestination:(LPLocation *)destination directionsTravelMode:(LPGoogleDirectionsTravelMode)travelMode directionsAvoidTolls:(LPGoogleDirectionsAvoid)avoid directionsUnit:(LPGoogleDirectionsUnit)unit directionsAlternatives:(BOOL)alternatives departureTime:(NSDate *)departureTime arrivalTime:(NSDate *)arrivalTime waypoints:(NSArray *)waypoints successfulBlock:(void (^)(LPDirections *directions))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    if ([self.delegate respondsToSelector:@selector(googleFunctionsWillLoadDirections:)]) {
        [self.delegate googleFunctionsWillLoadDirections:self];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", origin.latitude, origin.longitude] forKey:@"origin"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", destination.latitude, destination.longitude] forKey:@"destination"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"language"];
    [parameters setObject:[LPStep getDirectionsTravelMode:travelMode] forKey:@"mode"];
    [parameters setObject:[LPDirections getDirectionsAvoid:avoid] forKey:@"avoid"];
    [parameters setObject:[LPDirections getDirectionsUnit:unit] forKey:@"units"];
    [parameters setObject:[NSString stringWithFormat:@"%@", alternatives ? @"true" : @"false"] forKey:@"alternatives"];

    if (departureTime) {
        [parameters setObject:[NSString stringWithFormat:@"%.0f", [departureTime timeIntervalSince1970]] forKey:@"departure_time"];
    }

    if (arrivalTime) {
        [parameters setObject:[NSString stringWithFormat:@"%.0f", [arrivalTime timeIntervalSince1970]] forKey:@"arrival_time"];
    }
    
    if (waypoints.count > 0) {
        NSString *waypointsString = @"";
        
        for (int i=0; i<[waypoints count]; i++) {
            LPWaypoint *waypoint = (LPWaypoint *)[waypoints objectAtIndex:i];
            
            waypointsString = [waypointsString stringByAppendingFormat:@"%f,%f|", waypoint.location.latitude, waypoint.location.longitude];
        }
        
        [parameters setObject:waypointsString forKey:@"waypoints"];
    }

    [manager GET:googleAPIDirectionsURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LPDirections *directions = [LPDirections directionsWithObjects:responseObject];
        directions.requestTravelMode = travelMode;
        
        LPGoogleStatus status = [LPGoogleFunctions getGoogleStatusFromString:directions.statusCode];
        
        if (status == LPGoogleStatusOK) {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:didLoadDirections:)]) {
                [self.delegate googleFunctions:self didLoadDirections:directions];
            }
            
            if (successful)
                successful(directions);
        } else {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingDirectionsWithStatus:)]) {
                [self.delegate googleFunctions:self errorLoadingDirectionsWithStatus:status];
            }
            
            if (failure)
                failure(status);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingDirectionsWithStatus:)]) {
            [self.delegate googleFunctions:self errorLoadingDirectionsWithStatus:LPGoogleStatusUnknownError];
        }
        
        if (failure)
            failure(LPGoogleStatusUnknownError);
        
    }];
}

- (void)loadStreetViewImageForLocation:(LPLocation *)location imageSize:(CGSize)size heading:(float)heading fov:(float)fov pitch:(float)pitch successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.googleAPIBrowserKey] forKey:@"key"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%dx%d", (int)size.width, (int)size.height] forKey:@"size"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude] forKey:@"location"];
    [parameters setObject:[NSString stringWithFormat:@"%.2f", heading] forKey:@"heading"];
    [parameters setObject:[NSString stringWithFormat:@"%.2f", fov] forKey:@"fov"];
    [parameters setObject:[NSString stringWithFormat:@"%.2f", pitch] forKey:@"pitch"];

    [manager GET:googleAPIStreetViewImageURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (successful)
            successful(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
            failure(error);
        
    }];
}

- (void)loadStreetViewImageForAddress:(NSString *)address imageSize:(CGSize)size heading:(float)heading fov:(float)fov pitch:(float)pitch successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.googleAPIBrowserKey] forKey:@"key"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%dx%d", (int)size.width, (int)size.height] forKey:@"size"];
    [parameters setObject:[NSString stringWithFormat:@"%@", address] forKey:@"location"];
    [parameters setObject:[NSString stringWithFormat:@"%.2f", heading] forKey:@"heading"];
    [parameters setObject:[NSString stringWithFormat:@"%.2f", fov] forKey:@"fov"];
    [parameters setObject:[NSString stringWithFormat:@"%.2f", pitch] forKey:@"pitch"];
    
    [manager GET:googleAPIStreetViewImageURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (successful)
            successful(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
            failure(error);
        
    }];
}

- (void)loadStaticMapImageForLocation:(LPLocation *)location zoomLevel:(int)zoom imageSize:(CGSize)size imageScale:(int)scale mapType:(LPGoogleMapType)maptype markersArray:(NSArray *)markers successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude] forKey:@"center"];
    [parameters setObject:(self.sensor ? @"true" : @"false") forKey:@"sensor"];
    [parameters setObject:[NSNumber numberWithInt:zoom] forKey:@"zoom"];
    [parameters setObject:[NSNumber numberWithInt:scale] forKey:@"scale"];
    [parameters setObject:[NSString stringWithFormat:@"%dx%d", (int)size.width, (int)size.height] forKey:@"size"];
    [parameters setObject:[LPGoogleFunctions getMapType:maptype] forKey:@"maptype"];
    
    NSMutableSet *parametersMarkers = [[NSMutableSet alloc] init];
    for (int i=0; i<[markers count]; i++) {
        LPMapImageMarker *marker = (LPMapImageMarker *)[markers objectAtIndex:i];
        [parametersMarkers addObject:[marker getMarkerURLString]];
    }
    [parameters setObject:parametersMarkers forKey:@"markers"];
    
    [manager GET:googleAPIStaticMapImageURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(successful)
            successful(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(failure)
            failure(error);
        
    }];
}

- (void)loadStaticMapImageForAddress:(NSString *)address zoomLevel:(int)zoom imageSize:(CGSize)size imageScale:(int)scale mapType:(LPGoogleMapType)maptype markersArray:(NSArray *)markers successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", address] forKey:@"center"];
    [parameters setObject:(self.sensor ? @"true" : @"false") forKey:@"sensor"];
    [parameters setObject:[NSNumber numberWithInt:zoom] forKey:@"zoom"];
    [parameters setObject:[NSNumber numberWithInt:scale] forKey:@"scale"];
    [parameters setObject:[NSString stringWithFormat:@"%dx%d", (int)size.width, (int)size.height] forKey:@"size"];
    [parameters setObject:[LPGoogleFunctions getMapType:maptype] forKey:@"maptype"];
    
    NSMutableSet *parametersMarkers = [[NSMutableSet alloc] init];
    for (int i=0; i<[markers count]; i++) {
        LPMapImageMarker *marker = (LPMapImageMarker *)[markers objectAtIndex:i];
        [parametersMarkers addObject:[marker getMarkerURLString]];
    }
    [parameters setObject:parametersMarkers forKey:@"markers"];
    
    [manager GET:googleAPIStaticMapImageURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(successful)
            successful(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(failure)
            failure(error);
        
    }];
}

- (void)loadPlacesAutocompleteForInput:(NSString *)input offset:(int)offset radius:(int)radius location:(LPLocation *)location placeType:(LPGooglePlaceType)placeType countryRestriction:(NSString *)countryRestriction successfulBlock:(void (^)(LPPlacesAutocomplete *placesAutocomplete))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    if ([self.delegate respondsToSelector:@selector(googleFunctionsWillLoadPlacesAutocomplete:forInput:)]) {
        [self.delegate googleFunctionsWillLoadPlacesAutocomplete:self forInput:input];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.googleAPIBrowserKey] forKey:@"key"];
    [parameters setObject:[NSString stringWithFormat:@"%@", input] forKey:@"input"];
    [parameters setObject:[LPPrediction getStringFromGooglePlaceType:placeType] forKey:@"types"];
    [parameters setObject:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
    [parameters setObject:[NSString stringWithFormat:@"%d", radius] forKey:@"radius"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f",location.latitude, location.longitude] forKey:@"location"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"language"];

    if(countryRestriction) {
        [parameters setObject:[NSString stringWithFormat:@"country:%@", countryRestriction] forKey:@"components"];
    }
    
    [manager GET:googleAPIPlacesAutocompleteURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LPPlacesAutocomplete *placesAutocomplete = [LPPlacesAutocomplete placesAutocompleteWithObjects:responseObject];
        
        NSString *statusCode = placesAutocomplete.statusCode;
        
        if ([statusCode isEqualToString:@"OK"]) {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:didLoadPlacesAutocomplete:)]) {
                [self.delegate googleFunctions:self didLoadPlacesAutocomplete:placesAutocomplete];
            }
            
            if (successful)
                successful(placesAutocomplete);
        } else {
            LPGoogleStatus status = [LPGoogleFunctions getGoogleStatusFromString:statusCode];
            
            if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingPlacesAutocompleteWithStatus:)]) {
                [self.delegate googleFunctions:self errorLoadingPlacesAutocompleteWithStatus:status];
            }
            
            if (failure)
                failure(status);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingPlacesAutocompleteWithStatus:)]) {
            [self.delegate googleFunctions:self errorLoadingPlacesAutocompleteWithStatus:LPGoogleStatusUnknownError];
        }
        
        if (failure)
            failure(LPGoogleStatusUnknownError);
        
    }];
}

- (void)loadPlaceDetailsForReference:(NSString *)reference successfulBlock:(void (^)(LPPlaceDetailsResults *placeDetailsResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    if ([self.delegate respondsToSelector:@selector(googleFunctionsWillLoadPlaceDetailsResult:forReference:)]) {
        [self.delegate googleFunctionsWillLoadPlaceDetailsResult:self forReference:reference];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.googleAPIBrowserKey] forKey:@"key"];
    [parameters setObject:[NSString stringWithFormat:@"%@", reference] forKey:@"reference"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"language"];
    
    [manager GET:googleAPIPlaceDetailsURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LPPlaceDetailsResults *placeDetailsResults = [LPPlaceDetailsResults placeDetailsResultsWithObjects:responseObject];
        
        NSString *statusCode = placeDetailsResults.statusCode;
        
        if ([statusCode isEqualToString:@"OK"]) {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:didLoadPlaceDetailsResult:)]) {
                [self.delegate googleFunctions:self didLoadPlaceDetailsResult:placeDetailsResults];
            }
            
            if (successful)
                successful(placeDetailsResults);
        } else {
            LPGoogleStatus status = [LPGoogleFunctions getGoogleStatusFromString:statusCode];
            
            if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingPlaceDetailsResultWithStatus:)]) {
                [self.delegate googleFunctions:self errorLoadingPlaceDetailsResultWithStatus:status];
            }
            
            if (failure)
                failure(status);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingPlacesAutocompleteWithStatus:)]) {
            [self.delegate googleFunctions:self errorLoadingPlaceDetailsResultWithStatus:LPGoogleStatusUnknownError];
        }
        
        if (failure)
            failure(LPGoogleStatusUnknownError);
        
    }];
}

- (void)speakText:(NSString *)text failureBlock:(void (^)(NSError *error))failure
{
    [googlePlayer stop];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"tl"];
    [parameters setObject:[NSString stringWithFormat:@"%@", text] forKey:@"q"];
    
    [manager GET:googleAPITextToSpeechURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error = nil;
        
        googlePlayer = [[AVAudioPlayer alloc] initWithData:responseObject error:&error];
        googlePlayer.delegate = self;
        [googlePlayer play];
        
        if(error) {
            if(failure)
                failure(error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(failure)
            failure(error);
        
    }];
}

- (void)loadGeocodingForAddress:(NSString *)address filterComponents:(NSArray *)filterComponents successfulBlock:(void (^)(LPGeocodingResults *geocodingResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    if ([self.delegate respondsToSelector:@selector(googleFunctionsWillLoadGeocoding:forAddress:filterComponents:)]) {
        [self.delegate googleFunctionsWillLoadGeocoding:self forAddress:address filterComponents:filterComponents];
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", address] forKey:@"address"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"language"];

    if ([filterComponents count] > 0) {
        NSString *comString = @"components=";
        
        for (int i=0; i<[filterComponents count]; i++) {
            LPGeocodingFilter *filter = (LPGeocodingFilter *)[filterComponents objectAtIndex:i];
            
            comString = [comString stringByAppendingFormat:@"%@:%@|", [LPGeocodingFilter getGeocodingFilter:filter.filter], filter.value];
        }
    }

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:googleAPIGeocodingURL parameters:parameters error:nil];
    
    [self loadGeocodingRequest:request successfulBlock:^(LPGeocodingResults *geocodingResults) {
        
        if (successful)
            successful(geocodingResults);
        
    } failureBlock:^(LPGoogleStatus status) {
        
        if (failure)
            failure(status);
        
    }];
}

- (void)loadGeocodingForLocation:(LPLocation *)location filterComponents:(NSArray *)filterComponents successfulBlock:(void (^)(LPGeocodingResults *geocodingResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    if ([self.delegate respondsToSelector:@selector(googleFunctionsWillLoadGeocoding:forLocation:filterComponents:)]) {
        [self.delegate googleFunctionsWillLoadGeocoding:self forLocation:location filterComponents:filterComponents];
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude] forKey:@"latlng"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"language"];
    
    if ([filterComponents count] > 0) {
        NSString *comString = @"components=";
        
        for (int i=0; i<[filterComponents count]; i++) {
            LPGeocodingFilter *filter = (LPGeocodingFilter *)[filterComponents objectAtIndex:i];
            
            comString = [comString stringByAppendingFormat:@"%@:%@|", [LPGeocodingFilter getGeocodingFilter:filter.filter], filter.value];
        }
    }

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:googleAPIGeocodingURL parameters:parameters error:nil];
    
    [self loadGeocodingRequest:request successfulBlock:^(LPGeocodingResults *geocodingResults) {
        
        if (successful)
            successful(geocodingResults);
        
    } failureBlock:^(LPGoogleStatus status) {
        
        if (failure)
            failure(status);
        
    }];
}

- (void)loadGeocodingRequest:(NSMutableURLRequest *)request successfulBlock:(void (^)(LPGeocodingResults *geocodingResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LPGeocodingResults *results = [LPGeocodingResults geocodingResultsWithObjects:responseObject];
        
        NSString *statusCode = results.statusCode;
        
        if ([statusCode isEqualToString:@"OK"]) {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:didLoadGeocodingResults:)]) {
                [self.delegate googleFunctions:self didLoadGeocodingResults:results];
            }
            
            if (successful)
                successful(results);
        } else {
            LPGoogleStatus status = [LPGoogleFunctions getGoogleStatusFromString:statusCode];
            
            if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingGeocodingWithStatus:)]) {
                [self.delegate googleFunctions:self errorLoadingGeocodingWithStatus:status];
            }
            
            if (failure)
                failure(status);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingGeocodingWithStatus:)]) {
            [self.delegate googleFunctions:self errorLoadingGeocodingWithStatus:LPGoogleStatusUnknownError];
        }
        
        if (failure)
            failure(LPGoogleStatusUnknownError);
        
    }];
    
    [[NSOperationQueue mainQueue] addOperation:requestOperation];
}

- (void)loadPlacesAutocompleteWithDetailsForInput:(NSString *)input offset:(int)offset radius:(int)radius location:(LPLocation *)location placeType:(LPGooglePlaceType)placeType countryRestriction:(NSString *)countryRestriction successfulBlock:(void (^)(NSArray *placesWithDetails))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    [self loadPlacesAutocompleteForInput:input offset:offset radius:radius location:location placeType:placeType countryRestriction:countryRestriction successfulBlock:^(LPPlacesAutocomplete *placesAutocomplete) {
        
        __block int whichLoaded = 0;
        NSMutableArray *array = [NSMutableArray new];
        __block BOOL blockSend = NO;
        
        for (int i=0; i<[placesAutocomplete.predictions count]; i++) {
            NSString *reference = ((LPPrediction *)[placesAutocomplete.predictions objectAtIndex:i]).reference;
            
            [self loadPlaceDetailsForReference:reference successfulBlock:^(LPPlaceDetailsResults *placeDetailsResults) {
                LPPlaceDetails *placeWithDetails = [placeDetailsResults.result copy];

                [array addObject:placeWithDetails];

                whichLoaded++;

                if (whichLoaded >= [placesAutocomplete.predictions count]) {
                    if ([array count] > 0) {
                        if (!blockSend) {
                            if (successful)
                                successful(array);
                            
                            blockSend = YES;
                        }
                    } else {
                        if (!blockSend) {
                            if (failure)
                                failure(LPGoogleStatusZeroResults);
                            
                            blockSend = YES;
                        }
                    }
                }
            } failureBlock:^(LPGoogleStatus status) {
                whichLoaded++;

                if (whichLoaded >= [placesAutocomplete.predictions count]) {
                    if ([array count] > 0) {
                        if (!blockSend) {
                            if (successful)
                                successful(array);
                            
                            blockSend = YES;
                        }
                    } else {
                        if (!blockSend) {
                            if (failure)
                                failure(LPGoogleStatusZeroResults);
                            
                            blockSend = YES;
                        }
                    }
                }
            }];
        }
        
    } failureBlock:^(LPGoogleStatus status) {
        if (failure)
            failure(status);
    }];
}

- (void)loadPlaceTextSearchForQuery:(NSString *)query location:(LPLocation *)location radius:(int)radius successfulBlock:(void (^)(LPPlaceSearchResults *placeResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    if ([self.delegate respondsToSelector:@selector(googleFunctionsWillLoadPlaceSearch:forQuery:)]) {
        [self.delegate googleFunctionsWillLoadPlaceSearch:self forQuery:query];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.googleAPIBrowserKey] forKey:@"key"];
    [parameters setObject:[NSString stringWithFormat:@"%@", query] forKey:@"query"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"language"];
    
    if (location && radius > 0) {
        [parameters setObject:[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude] forKey:@"location"];
        [parameters setObject:[NSString stringWithFormat:@"%d", radius] forKey:@"radius"];
    }
    
    
    [manager GET:googleAPIPlaceTextSearchURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LPPlaceSearchResults *placeDetailsResults = [LPPlaceSearchResults placeSearchResultsWithObjects:responseObject];
        
        NSString *statusCode = placeDetailsResults.statusCode;
        
        if ([statusCode isEqualToString:@"OK"]) {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:didLoadPlaceSearch:)]) {
                [self.delegate googleFunctions:self didLoadPlaceSearch:placeDetailsResults];
            }
            
            if (successful)
                successful(placeDetailsResults);
        } else {
            LPGoogleStatus status = [LPGoogleFunctions getGoogleStatusFromString:statusCode];
            
            if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingPlaceSearchWithStatus:)]) {
                [self.delegate googleFunctions:self errorLoadingPlaceSearchWithStatus:status];
            }
            
            if (failure)
                failure(status);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingPlaceSearchWithStatus:)]) {
            [self.delegate googleFunctions:self errorLoadingPlaceSearchWithStatus:LPGoogleStatusUnknownError];
        }
        
        if (failure)
            failure(LPGoogleStatusUnknownError);
        
    }];
}

- (void)loadPlacePhotoForReference:(NSString *)reference maxHeight:(int)maxHeight maxWidth:(int)maxWidth successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.googleAPIBrowserKey] forKey:@"key"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.sensor ? @"true" : @"false"] forKey:@"sensor"];
    [parameters setObject:[NSString stringWithFormat:@"%@", reference] forKey:@"photoreference"];
    
    if (maxHeight > 0 && maxHeight <= 1600) {
        [parameters setObject:[NSString stringWithFormat:@"%d", maxHeight] forKey:@"maxheight"];
    }
    
    if (maxWidth > 0 && maxWidth <= 1600) {
        [parameters setObject:[NSString stringWithFormat:@"%d", maxWidth] forKey:@"maxwidth"];
    }
    
    [manager GET:googleAPIPlacePhotoURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(successful)
            successful(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
            failure(error);
        
    }];
}

- (void)loadDistanceMatrixForOrigins:(NSArray *)origins forDestinations:(NSArray *)destinations directionsTravelMode:(LPGoogleDistanceMatrixTravelMode)travelMode directionsAvoidTolls:(LPGoogleDistanceMatrixAvoid)avoid directionsUnit:(LPGoogleDistanceMatrixUnit)unit departureTime:(NSDate *)departureTime successfulBlock:(void (^)(LPDistanceMatrix *distanceMatrix))successful failureBlock:(void (^)(LPGoogleStatus status))failure
{
    if ([self.delegate respondsToSelector:@selector(googleFunctionsWillLoadDistanceMatrix:)]) {
        [self.delegate googleFunctionsWillLoadDistanceMatrix:self];
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new]; 
    
    NSMutableString *originsString = [NSMutableString new];
    for (int i=0; i<[origins count]; i++) {
        LPLocation *location = (LPLocation *)[origins objectAtIndex:i];
        
        NSString *coordinate = [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude];
        
        [originsString appendString:coordinate];
        
        if ([origins count] > 1 && i<([origins count]-1)) {
            [originsString appendString:@"|"];
        }
    }
    [parameters setObject:[NSString stringWithFormat:@"%@", originsString] forKey:@"origins"];
    
    NSMutableString *destinationsString = [NSMutableString new];
    for (int i=0; i<[destinations count]; i++) {
        LPLocation *location = (LPLocation *)[destinations objectAtIndex:i];
        
        NSString *coordinate = [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude];
        
        [destinationsString appendString:coordinate];
        
        if ([destinations count] > 1 && i<([destinations count]-1)) {
            [destinationsString appendString:@"|"];
        }
    }
    [parameters setObject:[NSString stringWithFormat:@"%@", destinationsString] forKey:@"destinations"];
    
    [parameters setObject:[NSString stringWithFormat:@"%@", self.googleAPIBrowserKey] forKey:@"key"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.languageCode] forKey:@"language"];
    [parameters setObject:[LPDistanceMatrix getDistanceMatrixTravelMode:travelMode] forKey:@"mode"];
    [parameters setObject:[LPDistanceMatrix getDistanceMatrixAvoid:avoid] forKey:@"avoid"];
    [parameters setObject:[LPDistanceMatrix getDistanceMatrixUnit:unit] forKey:@"units"];
    
    if (departureTime) {
        [parameters setObject:[NSString stringWithFormat:@"%.0f", [departureTime timeIntervalSince1970]] forKey:@"departure_time"];
    }
    
    [manager GET:googleAPIDistanceMatrixURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LPDistanceMatrix *distanceMatrix = [LPDistanceMatrix distanceMatrixWithObjects:responseObject];
        distanceMatrix.requestTravelMode = travelMode;
        
        LPGoogleStatus status = [LPGoogleFunctions getGoogleStatusFromString:distanceMatrix.statusCode];
        
        if (status == LPGoogleStatusOK) {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:didLoadDistanceMatrix:)]) {
                [self.delegate googleFunctions:self didLoadDistanceMatrix:distanceMatrix];
            }
            
            if (successful)
                successful(distanceMatrix);
        } else {
            if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingDistanceMatrixWithStatus:)]) {
                [self.delegate googleFunctions:self errorLoadingDistanceMatrixWithStatus:status];
            }
            
            if (failure)
                failure(status);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(googleFunctions:errorLoadingDistanceMatrixWithStatus:)]) {
            [self.delegate googleFunctions:self errorLoadingDistanceMatrixWithStatus:LPGoogleStatusUnknownError];
        }
        
        if (failure)
            failure(LPGoogleStatusUnknownError);
        
    }];
}

@end
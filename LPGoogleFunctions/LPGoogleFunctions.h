//
//  LPGoogleFunctions.h
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"

//Objects
#import "LPDirections.h"
#import "LPMapImageMarker.h"
#import "LPPlacesAutocomplete.h"
#import "LPPlaceDetailsResults.h"
#import "LPGeocodingFilter.h"
#import "LPGeocodingResults.h"
#import "LPPlaceSearchResults.h"
#import "LPDistanceMatrix.h"


typedef enum {
    LPGoogleStatusUnknownError,
    LPGoogleStatusOK,
    LPGoogleStatusNotFound,
    LPGoogleStatusZeroResults,
    LPGoogleStatusMaxWaypointsExceeded,
    LPGoogleStatusInvalidRequest,
    LPGoogleStatusOverQueryLimit,
    LPGoogleStatusRequestDenied
} LPGoogleStatus;

typedef enum {
    LPGoogleMapTypeRoadmap,
    LPGoogleMapTypeSatellite,
    LPGoogleMapTypeHybrid,
    LPGoogleMapTypeTerrain
} LPGoogleMapType;


@protocol LPGoogleFunctionsDelegate;

@interface LPGoogleFunctions : NSObject <CLLocationManagerDelegate, AVAudioPlayerDelegate>
{
    AVAudioPlayer *googlePlayer;
}

@property (nonatomic, weak) id <LPGoogleFunctionsDelegate> delegate;

@property (nonatomic, assign) BOOL sensor; /** Using GPS location sensor */
@property (nonatomic, strong) NSString *languageCode; /** Language ISO code (default "en") */
@property (nonatomic, strong) NSString *googleAPIBrowserKey;

+ (NSString *)getMapType:(LPGoogleMapType)maptype;
+ (LPGoogleStatus)getGoogleStatusFromString:(NSString *)status;
+ (NSString *)getGoogleStatus:(LPGoogleStatus)status;

/**
 * The Google Directions API is a service that calculates directions between locations using an HTTP request. You can search for directions for several modes of transportation, include transit, driving, walking or cycling. Directions may specify origins, destinations and waypoints either as text strings (e.g. "Chicago, IL" or "Darwin, NT, Australia") or as latitude/longitude coordinates. The Directions API can return multi-part directions using a series of waypoints.
 * @param The latitude/longitude value from which you wish to calculate directions.
 * @param The latitude/longitude value from which you wish to calculate directions.
 * @param Specifies the mode of transport to use when calculating directions. If you set the mode to "transit" you must also specify either a departure time or an arrival time.
 * @param Indicates that the calculated route(s) should avoid the indicated features.
 * @param Specifies the unit system to use when displaying results.
 * @param If set to true, specifies that the Directions service may provide more than one route alternative in the response. Note that providing route alternatives may increase the response time from the server.
 * @param Departure time.
 * @param Arrival time.
 * @param Waypoints.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadDirectionsForOrigin:(LPLocation *)origin forDestination:(LPLocation *)destination directionsTravelMode:(LPGoogleDirectionsTravelMode)travelMode directionsAvoidTolls:(LPGoogleDirectionsAvoid)avoid directionsUnit:(LPGoogleDirectionsUnit)unit directionsAlternatives:(BOOL)alternatives departureTime:(NSDate *)departureTime arrivalTime:(NSDate *)arrivalTime waypoints:(NSArray *)waypoints successfulBlock:(void (^)(LPDirections *directions))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

/**
 * The Google Maps Image APIs make it easy to embed a street view image into your image view.
 * @param The location (such as 40.457375,-80.009353).
 * @param Specifies the output size of the image in pixels.
 * @param Indicates the compass heading of the camera. Accepted values are from 0 to 360 (both values indicating North, with 90 indicating East, and 180 South). If no heading is specified, a value will be calculated that directs the camera towards the specified location, from the point at which the closest photograph was taken.
 * @param Determines the horizontal field of view of the image. The field of view is expressed in degrees, with a maximum allowed value of 120. When dealing with a fixed-size viewport, as with a Street View image of a set size, field of view in essence represents zoom, with smaller numbers indicating a higher level of zoom.
 * @param Specifies the up or down angle of the camera relative to the Street View vehicle. This is often, but not always, flat horizontal. Positive values angle the camera up (with 90 degrees indicating straight up); negative values angle the camera down (with -90 indicating straight down).
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadStreetViewImageForLocation:(LPLocation *)location imageSize:(CGSize)size heading:(float)heading fov:(float)fov pitch:(float)pitch successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure;

/**
 * The Google Maps Image APIs make it easy to embed a street view image into your image view.
 * @param The address (such as Chagrin Falls, OH).
 * @param Specifies the output size of the image in pixels.
 * @param Indicates the compass heading of the camera. Accepted values are from 0 to 360 (both values indicating North, with 90 indicating East, and 180 South). If no heading is specified, a value will be calculated that directs the camera towards the specified location, from the point at which the closest photograph was taken.
 * @param Determines the horizontal field of view of the image. The field of view is expressed in degrees, with a maximum allowed value of 120. When dealing with a fixed-size viewport, as with a Street View image of a set size, field of view in essence represents zoom, with smaller numbers indicating a higher level of zoom.
 * @param Specifies the up or down angle of the camera relative to the Street View vehicle. This is often, but not always, flat horizontal. Positive values angle the camera up (with 90 degrees indicating straight up); negative values angle the camera down (with -90 indicating straight down).
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadStreetViewImageForAddress:(NSString *)address imageSize:(CGSize)size heading:(float)heading fov:(float)fov pitch:(float)pitch successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure;

/**
 * The Google Maps Image APIs make it easy to embed a static Google Maps image into your image view.
 * @param Defines the center of the map.
 * @param (required if markers not present) defines the zoom level of the map, which determines the magnification level of the map. This parameter takes a numerical value corresponding to the zoom level of the region desired.
 * @param (required) Specifies the output size of the image in pixels.
 * @param (optional) affects the number of pixels that are returned. scale=2 returns twice as many pixels as scale=1 while retaining the same coverage area and level of detail (i.e. the contents of the map don't change). This is useful when developing for high-resolution displays, or when generating a map for printing. The default value is 1. Accepted values are 2 and 4 (4 is only available to Maps API for Business customers.)
 * @param (optional) defines the type of map to construct. There are several possible maptype values, including roadmap, satellite, hybrid, and terrain. Use LPGoogleMapType.
 * @param (optional) define one or more markers to attach to the image at specified locations. This parameter takes a single marker definition with parameters separated by the pipe character (|). Multiple markers may be placed within the same markers parameter as long as they exhibit the same style; you may add additional markers of differing styles by adding additional markers parameters. Note that if you supply markers for a map, you do not need to specify the (normally required) center and zoom parameters. Use LPMapImageMarker.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadStaticMapImageForLocation:(LPLocation *)location zoomLevel:(int)zoom imageSize:(CGSize)size imageScale:(int)scale mapType:(LPGoogleMapType)maptype markersArray:(NSArray *)markers successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure;

/**
 * The Google Maps Image APIs make it easy to embed a static Google Maps image into your image view.
 * @param Defines the center of the map.
 * @param (required if markers not present) defines the zoom level of the map, which determines the magnification level of the map. This parameter takes a numerical value corresponding to the zoom level of the region desired.
 * @param (required) Specifies the output size of the image in pixels.
 * @param (optional) affects the number of pixels that are returned. scale=2 returns twice as many pixels as scale=1 while retaining the same coverage area and level of detail (i.e. the contents of the map don't change). This is useful when developing for high-resolution displays, or when generating a map for printing. The default value is 1. Accepted values are 2 and 4 (4 is only available to Maps API for Business customers.)
 * @param (optional) defines the type of map to construct. There are several possible maptype values, including roadmap, satellite, hybrid, and terrain. Use LPGoogleMapType.
 * @param (optional) define one or more markers to attach to the image at specified locations. This parameter takes a single marker definition with parameters separated by the pipe character (|). Multiple markers may be placed within the same markers parameter as long as they exhibit the same style; you may add additional markers of differing styles by adding additional markers parameters. Note that if you supply markers for a map, you do not need to specify the (normally required) center and zoom parameters. Use LPMapImageMarker.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadStaticMapImageForAddress:(NSString *)address zoomLevel:(int)zoom imageSize:(CGSize)size imageScale:(int)scale mapType:(LPGoogleMapType)maptype markersArray:(NSArray*)markers successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure;

/**
 * The Google Places Autocomplete API is a web service that returns Place information based on text search terms, and, optionally, geographic bounds. The API can be used to provide autocomplete functionality for text-based geographic searches, by returning Places such as businesses, addresses, and points of interest as a user types.
 * @param The text string on which to search. The Place service will return candidate matches based on this string and order results based on their perceived relevance.
 * @param The character position in the input term at which the service uses text for predictions. For example, if the input is 'Googl' and the completion point is 3, the service will match on 'Goo'. The offset should generally be set to the position of the text caret. If no offset is supplied, the service will use the entire term.
 * @param The distance (in meters) within which to return Place results. Note that setting a radius biases results to the indicated area, but may not fully restrict results to the specified area.
 * @param The point around which you wish to retrieve Place information. Must be specified as latitude,longitude.
 * @param The types of Place results to return. If no type is specified, all types will be returned. See LPPrediction.h for types.
 * @param A grouping of places to which you would like to restrict your results. Currently, you can use components to filter by country. The country must be passed as a two character, ISO 3166-1 Alpha-2 compatible country code.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadPlacesAutocompleteForInput:(NSString *)input offset:(int)offset radius:(int)radius location:(LPLocation *)location placeType:(LPGooglePlaceType)placeType countryRestriction:(NSString *)countryRestriction successfulBlock:(void (^)(LPPlacesAutocomplete *placesAutocomplete))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

/**
 * Once you have a reference from a Place Search, you can request more details about a particular establishment or point of interest by initiating a Place Details request. A Place Details request returns more comprehensive information about the indicated place such as its complete address, phone number, user rating and reviews.
 * @param A textual identifier that uniquely identifies a place, returned from a Place search.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadPlaceDetailsForReference:(NSString *)reference successfulBlock:(void (^)(LPPlaceDetailsResults *placeDetailsResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

/**
 * Google Speak Text.
 * @param Text for convert.
 */
- (void)speakText:(NSString *)text failureBlock:(void (^)(NSError *error))failure;

/**
 * Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place markers or position the map.
 * @param The address that you want to geocode.
 * @param A component filter for which you wish to obtain a geocode. The components filter will also be accepted as an optional parameter if an address is provided. See LPGeocodingFilter.h for components.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadGeocodingForAddress:(NSString *)address filterComponents:(NSArray *)filterComponents successfulBlock:(void (^)(LPGeocodingResults *geocodingResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

/**
 * Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place markers or position the map.
 * @param The location that you want to geocode.
 * @param A component filter for which you wish to obtain a geocode. The components filter will also be accepted as an optional parameter if an address is provided. See LPGeocodingFilter.h for components.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadGeocodingForLocation:(LPLocation *)location filterComponents:(NSArray *)filterComponents successfulBlock:(void (^)(LPGeocodingResults *geocodingResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

/**
 * The Google Places Autocomplete API is a web service that returns Place information based on text search terms, and, optionally, geographic bounds.
 * @param The text string on which to search. The Place service will return candidate matches based on this string and order results based on their perceived relevance.
 * @param The character position in the input term at which the service uses text for predictions. For example, if the input is 'Googl' and the completion point is 3, the service will match on 'Goo'. The offset should generally be set to the position of the text caret. If no offset is supplied, the service will use the entire term.
* @param The distance (in meters) within which to return Place results. Note that setting a radius biases results to the indicated area, but may not fully restrict results to the specified area.
 * @param The point around which you wish to retrieve Place information. Must be specified as latitude,longitude.
 * @param The types of Place results to return. If no type is specified, all types will be returned. See LPPrediction.h for types.
 * @param A grouping of places to which you would like to restrict your results. Currently, you can use components to filter by country. The country must be passed as a two character, ISO 3166-1 Alpha-2 compatible country code.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadPlacesAutocompleteWithDetailsForInput:(NSString *)input offset:(int)offset radius:(int)radius location:(LPLocation *)location placeType:(LPGooglePlaceType)placeType countryRestriction:(NSString *)countryRestriction successfulBlock:(void (^)(NSArray *placesWithDetails))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

/**
 * The Google Places API Text Search Service is a web service that returns information about a set of Places based on a string — for example "pizza in New York" or "shoe stores near Ottawa".
 * @param The text string on which to search, for example: "restaurant". The Place service will return candidate matches based on this string and order the results based on their perceived relevance.
 * @param The latitude/longitude around which to retrieve Place information. This must be specified as latitude,longitude. If you specify a location parameter, you must also specify a radius parameter.
 * @param Defines the distance (in meters) within which to bias Place results. The maximum allowed radius is 50 000 meters. Results inside of this region will be ranked higher than results outside of the search circle; however, prominent results from outside of the search radius may be included.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadPlaceTextSearchForQuery:(NSString *)query location:(LPLocation *)location radius:(int)radius successfulBlock:(void (^)(LPPlaceSearchResults *placeResults))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

/**
 * The Places Photo service is a read-only API that allows you to easily add high quality photographic content to your application. The Photo service gives you access to the millions of photos stored in the Places and Google+ Local database. When you search for Places using either a Place Search or Place Details request, photo references will be returned for relevant photographic content. The Photo service lets you access the referenced photos, and resize the image to the optimal size for your application.
 * @param A string identifier that uniquely identifies a photo. Photo references are returned from either a Place Search or Place Details request.
 * @param Max image height (accept an integer between 1 and 1600).
 * @param Min image height (accept an integer between 1 and 1600).
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadPlacePhotoForReference:(NSString *)reference maxHeight:(int)maxHeight maxWidth:(int)maxWidth successfulBlock:(void (^)(UIImage *image))successful failureBlock:(void (^)(NSError *error))failure;

/**
 * The Google Distance Matrix API is a service that provides travel distance and time for a matrix of origins and destinations. The information returned is based on the recommended route between start and end points, as calculated by the Google Maps API, and consists of rows containing duration and distance values for each pair.
 * @param Array of LPLocation - The latitude/longitude value from which you wish to calculate directions.
 * @param Array of LPLocation - The latitude/longitude value from which you wish to calculate directions.
 * @param Specifies the mode of transport to use when calculating directions. If you set the mode to "transit" you must also specify either a departure time or an arrival time.
 * @param Indicates that the calculated route(s) should avoid the indicated features.
 * @param Specifies the unit system to use when displaying results.
 * @param Departure time.
 * @param Successful block with results.
 * @param Failure block with status.
 */
- (void)loadDistanceMatrixForOrigins:(NSArray *)origins forDestinations:(NSArray *)destinations directionsTravelMode:(LPGoogleDistanceMatrixTravelMode)travelMode directionsAvoidTolls:(LPGoogleDistanceMatrixAvoid)avoid directionsUnit:(LPGoogleDistanceMatrixUnit)unit departureTime:(NSDate *)departureTime successfulBlock:(void (^)(LPDistanceMatrix *distanceMatrix))successful failureBlock:(void (^)(LPGoogleStatus status))failure;

@end


#pragma mark - Delegate Protocol

@protocol LPGoogleFunctionsDelegate <NSObject>

@optional

#pragma mark - Directions
- (void)googleFunctionsWillLoadDirections:(LPGoogleFunctions *)googleFunctions;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadDirections:(LPDirections *)directions;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingDirectionsWithStatus:(LPGoogleStatus)status;

#pragma mark - Places Autocomplete
- (void)googleFunctionsWillLoadPlacesAutocomplete:(LPGoogleFunctions *)googleFunctions forInput:(NSString *)input;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingPlacesAutocompleteWithStatus:(LPGoogleStatus)status;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadPlacesAutocomplete:(LPPlacesAutocomplete *)placesAutocomplete;

#pragma mark - Place Details
- (void)googleFunctionsWillLoadPlaceDetailsResult:(LPGoogleFunctions *)googleFunctions forReference:(NSString *)reference;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingPlaceDetailsResultWithStatus:(LPGoogleStatus)status;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadPlaceDetailsResult:(LPPlaceDetailsResults *)placeDetailsResults;

#pragma mark - Geocoding
- (void)googleFunctionsWillLoadGeocoding:(LPGoogleFunctions *)googleFunctions forAddress:(NSString *)address filterComponents:(NSArray *)filterComponents;
- (void)googleFunctionsWillLoadGeocoding:(LPGoogleFunctions *)googleFunctions forLocation:(LPLocation *)location filterComponents:(NSArray *)filterComponents;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingGeocodingWithStatus:(LPGoogleStatus)status;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadGeocodingResults:(LPGeocodingResults *)geocodingResults;

#pragma mark - Place Search
- (void)googleFunctionsWillLoadPlaceSearch:(LPGoogleFunctions *)googleFunctions forQuery:(NSString *)guery;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadPlaceSearch:(LPPlaceSearchResults *)placeResults;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingPlaceSearchWithStatus:(LPGoogleStatus)status;

#pragma mark - Distance Matrix
- (void)googleFunctionsWillLoadDistanceMatrix:(LPGoogleFunctions *)googleFunctions;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions didLoadDistanceMatrix:(LPDistanceMatrix *)distanceMatrix;
- (void)googleFunctions:(LPGoogleFunctions *)googleFunctions errorLoadingDistanceMatrixWithStatus:(LPGoogleStatus)status;

@end
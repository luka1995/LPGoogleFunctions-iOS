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
@property (nonatomic, strong) NSMutableArray *placesList;

@end


@implementation LPMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Places Autocomplete";
    
    [self loadPlacesAutocompleteForInput:@"New York"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.placesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPCell *cell = [LPCell cellFromNibNamed:@"LPCell"];
    
    LPPlaceDetails *placeDetails = (LPPlaceDetails *)[self.placesList objectAtIndex:indexPath.row];
    
    cell.topLabel.text = placeDetails.name;
    cell.bottomLabel.text = placeDetails.formattedAddress;
    
    [self setImageForCell:cell fromURL:placeDetails.icon withColor:[UIColor colorWithRed:(170.0/255.0) green:(170.0/255.0) blue:(170.0/255.0) alpha:1.0]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.searchDisplayController isActive]) {
        [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:NO];
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
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

- (void)loadPlacesAutocompleteForInput:(NSString *)input
{
    self.searchDisplayController.searchBar.text = input;
    
    [self.googleFunctions loadPlacesAutocompleteWithDetailsForInput:input offset:(int)[input length] radius:0 location:nil placeType:LPGooglePlaceTypeGeocode countryRestriction:nil successfulBlock:^(NSArray *placesWithDetails) {
        NSLog(@"successful");
        
        self.placesList = [NSMutableArray arrayWithArray:placesWithDetails];
        
        if ([self.searchDisplayController isActive]) {
            [self.searchDisplayController.searchResultsTableView reloadData];
        } else {
            [self.tableView reloadData];
        }
    } failureBlock:^(LPGoogleStatus status) {
        NSLog(@"Error - Block: %@", [LPGoogleFunctions getGoogleStatus:status]);
        
        self.placesList = [NSMutableArray new];
        
        if ([self.searchDisplayController isActive]) {
            [self.searchDisplayController.searchResultsTableView reloadData];
        } else {
            [self.tableView reloadData];
        }
    }];
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

#pragma mark - Search Controller

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self loadPlacesAutocompleteForInput:searchText];
}

#pragma mark - LPImage

- (void)setImageForCell:(LPCell *)cell fromURL:(NSString *)URL withColor:(UIColor *)color
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    __weak LPCell *weakCell = cell;
    
    [cell.leftImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        weakCell.leftImageView.image = [[image imageTintedWithColor:color] changeImageSize:CGSizeMake(24.0f, 24.0f)];
        
    } failure:nil];
}

@end
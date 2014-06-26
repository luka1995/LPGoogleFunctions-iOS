//
//  LPMainViewController.h
//  LPPlacesAutocomplateService
//
//  Created by Luka Penger on 8/21/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "LPGoogleFunctions.h"
#import "LPImage.h"
#import "LPCell.h"


@interface LPMainViewController : UIViewController <LPGoogleFunctionsDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
    
@end

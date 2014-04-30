//
//  LPMainViewController.h
//  PlacesAutocomplateService
//
//  Created by Luka Penger on 8/21/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPGoogleFunctions.h"


@interface LPMainViewController : UIViewController <LPGoogleFunctionsDelegate>

@property (nonatomic, strong) LPGoogleFunctions *googleFunctions;
@property (nonatomic, strong) IBOutlet UITextView *textView;
    
@end

//
//  LPMainViewController.h
//  StreetViewImagesService
//
//  Created by Luka Penger on 8/20/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPGoogleFunctions.h"


@interface LPMainViewController : UIViewController <LPGoogleFunctionsDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) LPGoogleFunctions *googleFunctions;

@end

//
//  LPCell.h
//  LPPlacesAutocompleteService
//
//  Created by Luka Penger on 01/05/14.
//  Copyright (c) 2014 Luka Penger. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LPCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *topLabel;
@property (nonatomic, strong) IBOutlet UILabel *bottomLabel;
@property (nonatomic, strong) IBOutlet UIImageView *leftImageView;

+ (LPCell *)cellFromNibNamed:(NSString *)nibName;

@end

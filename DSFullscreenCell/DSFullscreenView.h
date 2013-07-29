//
//  DSFullscreenView.h
//  DSFullscreenCell
//
//  Created by Diego Serrano on 7/29/13.
//  Copyright (c) 2013 Brounie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSFullscreenView : UIViewController

@property CGFloat previousViewOriginX;

@property CGFloat previousViewOriginY;

@property CGFloat previousViewSizeWidth;

@property CGFloat previousViewSizeHeight;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)doneButtonPressed:(UIButton *)sender;

@end

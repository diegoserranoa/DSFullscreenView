//
//  DSFullscreenView.m
//  DSFullscreenCell
//
//  Created by Diego Serrano on 7/29/13.
//  Copyright (c) 2013 Brounie. All rights reserved.
//

#import "DSFullscreenView.h"

@implementation DSFullscreenView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(animationFinished:)
                                                     name:@"animationFinished"
                                                   object:nil];
    }
    return self;
}

- (void) animationFinished:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"animationFinished"]){
        NSLog(@"Animation finished. Present mainView with fade in animation.");
        
        CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
        flash.delegate = self;
        flash.fromValue = [NSNumber numberWithFloat:0.0f];
        flash.toValue = [NSNumber numberWithFloat:1.0f];
        flash.duration = 1.0f;        // 1 second
        flash.autoreverses = NO;    // Back
        flash.repeatCount = 0;       // Or whatever
        
        
        [self.mainView.layer addAnimation:flash forKey:@"fadeInAnimation"];
        
        self.mainView.layer.opacity = 1.0f;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)doneButtonPressed:(UIButton *)sender {
    NSLog(@"Done button pressed. Fade out mainView.");
    
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.delegate = self;
    flash.fromValue = [NSNumber numberWithFloat:1.0f];
    flash.toValue = [NSNumber numberWithFloat:0.0f];
    flash.duration = 1.0f;        // 1 second
    flash.autoreverses = NO;    // Back
    flash.repeatCount = 0;       // Or whatever
    
    [self.mainView.layer addAnimation:flash forKey:@"fadeOutAnimation"];
    
    self.mainView.layer.opacity = 0.0f;
    
    [UIView animateWithDuration:1.0f animations:^{
        CGRect theFrame = self.view.frame;
        theFrame.size.height = self.previousViewSizeHeight;
        theFrame.origin.y = self.previousViewOriginY;
        self.view.frame = theFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fullscreenViewDismissed" object:self];
        }
    }];
    
}
@end

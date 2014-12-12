//
//  CustomProgress.h
//  ChinaBond
//
//  Created by DLL on 14/11/13.
//  Copyright (c) 2014年 chinabond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomProgress : UIImageView {
    BOOL _animating;
}

/**
 A Boolean value that controls whether the receiver is hidden when the animation is stopped.
 
 If the value of this property is YES (the default), the receiver sets its hidden property (UIView) to YES when receiver
 is not animating. If the hidesWhenStopped property is NO, the receiver is not hidden when animation stops. You stop an
 animating progress indicator with the stopAnimating method.
 */
@property(nonatomic, assign) BOOL hidesWhenStopped;

/**
 Starts the animation of the progress indicator.
 
 When the progress indicator is animated, the gear spins to indicate indeterminate progress. The indicator is animated
 until stopAnimating is called.
 */
- (void)startAnimating;

/**
 Stops the animation of the progress indicator.
 
 Call this method to stop the animation of the progress indicator started with a call to startAnimating. When animating
 is stopped, the indicator is hidden, unless hidesWhenStopped is NO.
 */
- (void)stopAnimating;

/**
 Returns whether the receiver is animating.
 
 @return YES if the receiver is animating, otherwise NO.
 */
- (BOOL)isAnimating;

@end


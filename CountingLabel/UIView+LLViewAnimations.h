//
//  UIView+LLViewAnimations.h
//  CoutingLabel
//
//  Created by Lars Lockefeer on 17/07/14.
//
//

#import <UIKit/UIKit.h>

@class GSQMediaTimingFunction;

@interface UIView (LLViewAnimations)

/**
 * Perform a (view-based) animation with a custom timing function
 *
 * The animation will be performed by calling the `animationStateForProgress` block for every frame of the animation, at the refresh rate of the display.
 * The block is passed the total progress of the animation as a parameter. The calculation of this progress is based on the timing function `timing`,
 * to allow for non-linear animations. The caller is responsible for updating the view depending on the amount of progress that was made in the animation.
 *
 * Note that the value of `progress` may be outside the {0,1} range; for example in the case of an overshoot in the animation.
 *
 * @param timing                    The timing function to use for the animation
 * @param duration                  The total duration of the animation
 * @param animationStateForProgress A block that updates the state of the view depending on the progress of the animation
 * @param completion                A block of actions to perform when the animation completed
 */
+ (void)animateWithMediaTimingFunction:(GSQMediaTimingFunction *)timing duration:(CGFloat)duration animationStateForProgress:(void(^)(CGFloat progress))animationStateForProgress completion:(void (^)(void))completion;


@end

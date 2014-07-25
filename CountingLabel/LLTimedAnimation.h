//
//  LLTimedAnimation.h
//  CoutingLabel
//
//  Created by Lars Lockefeer on 17/07/14.
//
//

#import <Foundation/Foundation.h>

@class GSQMediaTimingFunction;

/**
 * `LLTimedAnimation` is a wrapper that sets up and manages a display-link based animation.
 *
 * The animation will be performed by calling the `animationStateForProgress` block for every frame of the animation, at the refresh rate of the display.
 * The block is passed the total progress of the animation as a parameter. The calculation of this progress is based on the timing function `timing`,
 * to allow for non-linear animations. The caller is responsible for updating the view depending on the amount of progress that was made in the animation.
 *
 * Note that the value of `progress` may be outside the {0,1} range; for example in the case of an overshoot in the animation.
 */
@interface LLTimedAnimation : NSObject

/**
 * Creates a `TSTimedAnimation` object
 *
 * @param timingFunction            The timing function to use for this animation
 * @param duration                  The total duration of the animation
 * @param animationStateForProgress The block to execute at each frame of the animation
 * @param completion                The block to execute after the animation has completed
 *
 * @return An initialized `TSTimedAnimation` instance
 */
- (instancetype)initWithMediaTimingFunction:(GSQMediaTimingFunction *)timingFunction duration:(CGFloat)duration animationStateForProgress:(void(^)(CGFloat progress))animationStateForProgress completion:(void (^)(void))completion;

/**
 * Begin the animation
 */
- (void)begin;

@end

//
//  UIView+LLViewAnimations.m
//  CoutingLabel
//
//  Created by Lars Lockefeer on 17/07/14.
//
//

#import "UIView+LLViewAnimations.h"
#import "GSQMediaTimingFunction.h"
#import "LLTimedAnimation.h"

@implementation UIView (LLViewAnimations)

+ (void)animateWithMediaTimingFunction:(GSQMediaTimingFunction *)timing duration:(CGFloat)duration animationStateForProgress:(void(^)(CGFloat progress))animationStateForProgress completion:(void (^)(void))completion;
{
    LLTimedAnimation *animation = [[LLTimedAnimation alloc] initWithMediaTimingFunction:timing duration:duration animationStateForProgress:animationStateForProgress completion:completion];
    [animation begin];
}

@end

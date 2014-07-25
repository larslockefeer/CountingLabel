//
//  LLCountingLabel.m
//  CoutingLabel
//
//  Created by Lars Lockefeer on 16/07/14.
//
//

#import "LLCountingLabel.h"
#import "GSQMediaTimingFunction.h"
#import "UIView+LLViewAnimations.h"

@interface LLCountingLabel ()

@property(nonatomic) NSInteger currentValue;

@end

@implementation LLCountingLabel

- (id)init
{
    self = [super init];
    if (self) {
        _currentValue = 0;
    }
    return self;
}

- (void)setCounter:(NSInteger)newCounterValue animated:(BOOL)animated completion:(void (^)(void))completion
{
    if (! animated) {
        self.currentValue = newCounterValue;
        [self setText:[NSString stringWithFormat:@"%@", @(newCounterValue)]];
        return;
    }
    
    NSInteger valueAtStart = self.currentValue;
    NSInteger diff = newCounterValue - valueAtStart;
    
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithMediaTimingFunction:[GSQMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] duration:1.0f animationStateForProgress:^(CGFloat progress) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (! strongSelf) {
            return;
        }
        
        NSInteger valueForProgress = valueAtStart + (diff * progress);
        strongSelf.currentValue = valueForProgress;
        [strongSelf setText:[NSString stringWithFormat:@"%@", @(valueForProgress)]];
        
    } completion:completion];
}

@end

//
//  LLTimedAnimation.m
//  CoutingLabel
//
//  Created by Lars Lockefeer on 17/07/14.
//
//

#import "LLTimedAnimation.h"
#import "GSQMediaTimingFunction.h"

@interface LLTimedAnimation ()

@property(nonatomic) NSTimeInterval beginTime;
@property(nonatomic) CGFloat duration;
@property(nonatomic) GSQMediaTimingFunction *timingFunction;
@property (nonatomic, copy) void (^animationStateForProgress)(CGFloat);
@property (nonatomic, copy) void (^completion)(void);

@end

@implementation LLTimedAnimation


- (instancetype)initWithMediaTimingFunction:(GSQMediaTimingFunction *)timingFunction duration:(CGFloat)duration animationStateForProgress:(void(^)(CGFloat progress))animationStateForProgress completion:(void (^)(void))completion;
{
    self = [super init];
    
    if (self) {
        self.duration = duration;
        self.timingFunction = timingFunction;
        self.animationStateForProgress = animationStateForProgress;
        self.completion = completion;
    }
    return self;
}

#pragma mark -
#pragma mark Public methods
#pragma mark -

- (void)begin
{
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(performAnimationFrame:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark -
#pragma mark Private methods
#pragma mark -

- (void)performAnimationFrame:(CADisplayLink *)sender
{
    CGFloat durationDone = 0;
    CGFloat progress;
    
    if (sender) {
        if (self.beginTime && self.beginTime != 0) {
            durationDone = (sender.timestamp - self.beginTime);
        } else {
            self.beginTime = sender.timestamp;
        }
        
        if (self.duration > 0) {
            progress = [self.timingFunction evaluateYAtX:durationDone/_duration];
        } else {
            progress = 1.0;
        }
    } else {
        progress = 1.0;
    }
    
    if (durationDone >= self.duration) {
        
        // Make sure the end state is 'clean'
        progress = MAX(progress, 1.0);
        
    }
    
    if(self.animationStateForProgress) {
        self.animationStateForProgress(progress);
    }
    
    if (durationDone >= self.duration) {
        
        [sender removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        if (self.completion) {
            self.completion();
        }
    }
}

@end

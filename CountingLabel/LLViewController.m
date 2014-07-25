//
//  LLViewController.m
//  CoutingLabel
//
//  Created by Lars Lockefeer on 16/07/14.
//
//

#import "LLViewController.h"
#import "LLCountingLabel.h"
#import "UIView+LLViewAnimations.h"
#import "GSQMediaTimingFunction.h"

@interface LLViewController ()

@property(nonatomic) LLCountingLabel *label;

@property(nonatomic) UIButton *button;

@end

@implementation LLViewController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.99 green:0.67 blue:0.31 alpha:1]];
    
    self.label = [LLCountingLabel new];
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:80.0f];
    self.label.textColor = [UIColor whiteColor];
    [self.label setCounter:0 animated:NO completion:nil];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.label];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    self.button = [UIButton new];
    self.button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    [self.button setTitle:@"Animate" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.button];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label]-20-[_button]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_label, _button)]];
}

- (void)buttonTapped:(id)sender
{
    NSUInteger targetValue = arc4random_uniform(512);
    self.button.enabled = NO;
    
    __weak __typeof(self)weakSelf = self;
    [self.label setCounter:targetValue animated:YES completion:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (! strongSelf) {
            return;
        }
        strongSelf.button.enabled = YES;
    }];
}

@end

//
//  LLAppDelegate.m
//  CoutingLabel
//
//  Created by Lars Lockefeer on 16/07/14.
//
//

#import "LLAppDelegate.h"
#import "LLViewController.h"

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    LLViewController *viewController = [LLViewController new];
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

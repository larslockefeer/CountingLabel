//
//  GSQMediaTimingFunction.h
//  CoutingLabel
//
//  Created by Lars Lockefeer on 16/07/14.
//
//

#import <Foundation/Foundation.h>

/**
 * Custom implementation of CAMediaTimingFunction, from GNUStep
 */
@interface GSQMediaTimingFunction : NSObject

+ (id) functionWithName:(NSString *)name;

+ (id) functionWithControlPoints: (CGFloat)c1x
                                : (CGFloat)c1y
                                : (CGFloat)c2x
                                : (CGFloat)c2y;

- (CGFloat) evaluateYAtX: (CGFloat)x;

@end

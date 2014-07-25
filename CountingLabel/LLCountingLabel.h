//
//  LLCountingLabel.h
//  CoutingLabel
//
//  Created by Lars Lockefeer on 16/07/14.
//
//

#import <UIKit/UIKit.h>

/**
 * A label that has an integer as its text and may be updated in an animated fashion,
 * by counting up or down from its previous value to its new value
 */
@interface LLCountingLabel : UILabel

/**
 * Set the counter of the `BBCountingLabel`
 *
 * @param newCounterValue The new value for the counter
 * @param animated        Whether to animate from the current to the new value
 * @param completion      The completion block to execute when the animation finishes
 */
- (void)setCounter:(NSInteger)newCounterValue animated:(BOOL)animated completion:(void (^)(void))completion;

@end

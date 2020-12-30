//
//  JSSkeletonBreathingAnimation.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonBreathingAnimation.h"
#import "JSSkeletonLayoutView.h"

@implementation JSSkeletonBreathingAnimation

- (void)addAnimationWithLayoutView:(JSSkeletonLayoutView *)layoutView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.1];
    animation.toValue = [NSNumber numberWithFloat:0.6];
    animation.autoreverses = YES;
    animation.duration = 0.5;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layoutView.layer addAnimation:animation forKey:NSStringFromClass(self.class)];
}

- (void)removeAnimationWithLayoutView:(JSSkeletonLayoutView *)layoutView {
    [layoutView.layer removeAnimationForKey:NSStringFromClass(self.class)];
}

@end

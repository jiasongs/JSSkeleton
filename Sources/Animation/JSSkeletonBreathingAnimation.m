//
//  JSSkeletonBreathingAnimation.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonBreathingAnimation.h"
#import "JSSkeletonLayoutLayer.h"

@implementation JSSkeletonBreathingAnimation

- (void)addAnimationWithLayoutLayer:(JSSkeletonLayoutLayer *)layoutLayer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.1];
    animation.toValue = [NSNumber numberWithFloat:0.6];
    animation.autoreverses = YES;
    animation.duration = 0.5;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layoutLayer addAnimation:animation forKey:NSStringFromClass(self.class)];
}

- (void)removeAnimationWithLayoutLayer:(JSSkeletonLayoutLayer *)layoutLayer {
    [layoutLayer removeAnimationForKey:NSStringFromClass(self.class)];
}

@end

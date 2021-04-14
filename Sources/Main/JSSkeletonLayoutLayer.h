//
//  JSSkeletonLayoutLayer.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JSSkeletonLayoutSimulate) {
    JSSkeletonLayoutSimulateView,
    JSSkeletonLayoutSimulateLabel,
};

@interface JSSkeletonLayoutLayer : CALayer

@property (nonatomic, weak, readonly) __kindof UIView *simulateView;
@property (nonatomic, assign, readonly) JSSkeletonLayoutSimulate simulateType;

- (instancetype)initWithSimulateView:(__kindof UIView *)simulateView;

- (void)updateLayoutIfNeeded;

- (void)startAnimation;
- (void)endAnimation;

@end

NS_ASSUME_NONNULL_END

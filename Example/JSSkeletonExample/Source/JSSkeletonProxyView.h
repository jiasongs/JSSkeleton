//
//  JSSkeletonProxyView.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSkeletonLayoutView;
@class JSSkeletonProxyCoordinator;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyView : UIView

@property (nonatomic, weak, readonly) __kindof UIView *targetView;
@property (nonatomic, strong) JSSkeletonProxyCoordinator *coordinator;

- (instancetype)initWithTargetView:(__kindof UIView *)targetView NS_REQUIRES_SUPER;
- (void)didInitialize NS_REQUIRES_SUPER;

- (BOOL)filterByRulesView:(__kindof UIView *)view;
- (void)enumerateLayoutViewUsingBlock:(void(NS_NOESCAPE ^)(JSSkeletonLayoutView *layoutView))block;
- (void)start;
- (void)end;

@end

NS_ASSUME_NONNULL_END

//
//  JSSkeletonProxyView.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyView.h"
#import "JSSkeletonLayoutView.h"
#import "JSSkeletonBreathingAnimation.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonProxyCoordinator.h"

@interface JSSkeletonProxyView ()

@property (nonatomic, weak, readwrite) __kindof UIView *targetView;

@end

@implementation JSSkeletonProxyView

- (instancetype)initWithTargetView:(__kindof UIView *)targetView {
    if (self = [super initWithFrame:CGRectZero]) {
        self.targetView = targetView;
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.backgroundColor = UIColor.whiteColor;
    self.coordinator = [[JSSkeletonProxyCoordinator alloc] init];
    self.coordinator.bindView = self;
}

#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.targetView.superview == self) {
        self.targetView.frame = self.bounds;
    }
}

#pragma mark - public

- (BOOL)filterByRulesView:(__kindof UIView *)view {
    BOOL needRemove = false;
    if ([view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]] ||
        [view isKindOfClass:[NSClassFromString(@"_UITableViewHeaderFooterContentView") class]] ||
        [view isKindOfClass:[NSClassFromString(@"_UITableViewHeaderFooterViewBackground") class]] ||
        [view isKindOfClass:[NSClassFromString(@"UITableViewLabel") class]]) {
        needRemove = true;
    }
    if ((!view.isHidden || !view.js_skeletonInvalid) && !needRemove) {
        return true;
    }
    return false;
}

- (void)enumerateLayoutViewUsingBlock:(void(NS_NOESCAPE ^)(JSSkeletonLayoutView *layoutView))block {
    [self.subviews enumerateObjectsUsingBlock:^(JSSkeletonLayoutView *subview, NSUInteger idx, BOOL *stop) {
        if ([subview isKindOfClass:JSSkeletonLayoutView.class]) {
            block(subview);
        }
    }];
}

- (void)start {
    if (!self.js_skeletonDisplay) {
        [self enumerateLayoutViewUsingBlock:^(JSSkeletonLayoutView *layoutView) {
            [layoutView startAnimation];
        }];
        [self.superview bringSubviewToFront:self];
        self.hidden = false;
        self.js_skeletonDisplay = true;
    }
}

- (void)end {
    if (self.js_skeletonDisplay) {
        [self enumerateLayoutViewUsingBlock:^(JSSkeletonLayoutView *layoutView) {
            [layoutView endAnimation];
        }];
        [UIView animateWithDuration:0.25f delay:0 options:(7<<16) animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.hidden = true;
                self.alpha = 1.0;
            }
        }];
        self.js_skeletonDisplay = false;
    }
}

#pragma mark - setter

- (void)setTargetView:(__kindof UIView *)targetView {
    _targetView = targetView;
    /// 生产视图
    for (__kindof UIView *subview in self.targetView.subviews) {
        if ([self filterByRulesView:subview]) {
            if (!subview.js_skeletonAnimation) {
                subview.js_skeletonAnimation = JSSkeletonBreathingAnimation.new;
            }
            JSSkeletonLayoutView *layoutView = [[JSSkeletonLayoutView alloc] initWithSimulateView:subview];
            [self addSubview:layoutView];
            subview.js_skeletonLayoutView = layoutView;
            subview.qmui_frameDidChangeBlock = ^(__kindof UIView *view, CGRect precedingFrame) {
                [view.js_skeletonLayoutView updateLayout];
            };
        }
    }
}

@end

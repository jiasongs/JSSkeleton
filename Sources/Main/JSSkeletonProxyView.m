//
//  JSSkeletonProxyView.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyView.h"
#import "JSSkeletonLayoutView.h"
#import "JSSkeletonProxyCoordinator.h"
#import "JSSkeletonProxyProducer.h"
#import "JSSkeletonAppearance.h"

@interface JSSkeletonProxyView ()

@end

@implementation JSSkeletonProxyView

- (instancetype)initWithRegisterView:(__kindof UIView *)registerView
                          targetView:(nullable __kindof UIView *)targetView {
    if (self = [super initWithFrame:CGRectZero]) {
        _registerView = registerView;
        _targetView = targetView;
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.backgroundColor = JSSkeletonAppearance.appearance.skeletonBackgroundColor;
    self.hidden = true;
    self.coordinator = [[JSSkeletonProxyCoordinator alloc] initWithProxyView:self];
    self.producer = [[JSSkeletonProxyProducer alloc] init];
    if (self.targetView.subviews.count > 0) {
        NSArray *layoutViews = [self.producer produceLayoutViewWithViews:self.targetView.subviews];
        for (JSSkeletonLayoutView *layoutView in layoutViews) {
            [self addSubview:layoutView];
        }
    }
}

#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.targetView.superview == self) {
        self.targetView.frame = self.bounds;
    }
}

@end

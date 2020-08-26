//
//  JSSkeletonProxyCoordinator.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyCoordinator.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonLayoutView.h"
#import "JSSkeletonProxyView.h"
#import "JSSkeletonProxyProducer.h"

@interface JSSkeletonProxyCoordinator ()

@end

@implementation JSSkeletonProxyCoordinator

- (instancetype)initWithProxyView:(__kindof JSSkeletonProxyView *)proxyView {
    if (self = [super init]) {
        _proxyView = proxyView;
    }
    return self;
}

- (BOOL)start {
    __kindof UIView *registerView = self.proxyView.registerView;
    if (!registerView.js_skeletonDisplay) {
        registerView.js_skeletonDisplay = true;
        [self.proxyView.producer enumerateLayoutViewsUsingBlock:^(JSSkeletonLayoutView *layoutView, NSUInteger idx) {
            [layoutView startAnimation];
        }];
        [self.proxyView.superview bringSubviewToFront:self.proxyView];
        self.proxyView.hidden = false;
        return true;
    }
    return false;
}

- (BOOL)end {
    __kindof UIView *registerView = self.proxyView.registerView;
    if (registerView.js_skeletonDisplay) {
        registerView.js_skeletonDisplay = false;
        [self.proxyView.producer enumerateLayoutViewsUsingBlock:^(JSSkeletonLayoutView *layoutView, NSUInteger idx) {
            [layoutView endAnimation];
        }];
        [UIView animateWithDuration:0.25f delay:0 options:(7<<16) animations:^{
            self.proxyView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.proxyView.hidden = true;
                self.proxyView.alpha = 1.0;
            }
        }];
        return true;
    }
    return false;
}

@end

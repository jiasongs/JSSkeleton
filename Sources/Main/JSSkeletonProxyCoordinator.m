//
//  JSSkeletonProxyCoordinator.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyCoordinator.h"
#import "UIView+JSSkeleton.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonLayoutLayer.h"
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
        registerView.js_skeletonDisplay = YES;
        [self.proxyView.producer enumerateLayoutLayersUsingBlock:^(JSSkeletonLayoutLayer *layoutLayer, NSUInteger idx) {
            [layoutLayer startAnimation];
        }];
        [self.proxyView.superview bringSubviewToFront:self.proxyView];
        self.proxyView.hidden = NO;
        return YES;
    }
    return NO;
}

- (BOOL)end {
    __kindof UIView *registerView = self.proxyView.registerView;
    if (registerView.js_skeletonDisplay) {
        registerView.js_skeletonDisplay = NO;
        [self.proxyView.producer enumerateLayoutLayersUsingBlock:^(JSSkeletonLayoutLayer *layoutLayer, NSUInteger idx) {
            [layoutLayer endAnimation];
        }];
        self.proxyView.hidden = YES;
        return YES;
    }
    return NO;
}

@end

//
//  JSSkeletonProxyCoordinator.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyCoordinator.h"

@implementation JSSkeletonProxyCoordinator

#pragma mark - public

//- (BOOL)filterByRulesView:(__kindof UIView *)view {
//    BOOL needRemove = false;
//    if ([view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]] ||
//        [view isKindOfClass:[NSClassFromString(@"_UITableViewHeaderFooterContentView") class]] ||
//        [view isKindOfClass:[NSClassFromString(@"_UITableViewHeaderFooterViewBackground") class]] ||
//        [view isKindOfClass:[NSClassFromString(@"UITableViewLabel") class]]) {
//        needRemove = true;
//    }
//    if ((!view.isHidden || !view.js_skeletonInvalid) && !needRemove) {
//        return true;
//    }
//    return false;
//}
//
//- (void)enumerateLayoutViewUsingBlock:(void(NS_NOESCAPE ^)(JSSkeletonLayoutView *layoutView))block {
//    [self.bindView.subviews enumerateObjectsUsingBlock:^(JSSkeletonLayoutView *subview, NSUInteger idx, BOOL *stop) {
//        if ([subview isKindOfClass:JSSkeletonLayoutView.class]) {
//            block(subview);
//        }
//    }];
//}
//
//- (void)start {
//    if (!self.js_skeletonDisplay) {
//        [self enumerateLayoutViewUsingBlock:^(JSSkeletonLayoutView *layoutView) {
//            [layoutView startAnimation];
//        }];
//        [self.superview bringSubviewToFront:self];
//        self.hidden = false;
//        self.js_skeletonDisplay = true;
//    }
//}
//
//- (void)end {
//    if (self.js_skeletonDisplay) {
//        [self enumerateLayoutViewUsingBlock:^(JSSkeletonLayoutView *layoutView) {
//            [layoutView endAnimation];
//        }];
//        [UIView animateWithDuration:0.25f delay:0 options:(7<<16) animations:^{
//            self.alpha = 0.0;
//        } completion:^(BOOL finished) {
//            if (finished) {
//                self.hidden = true;
//                self.alpha = 1.0;
//            }
//        }];
//        self.js_skeletonDisplay = false;
//    }
//}

@end

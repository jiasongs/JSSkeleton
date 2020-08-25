//
//  JSSkeletonProxyProducer.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/23.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyProducer.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonLayoutView.h"
#import "UIView+JSSkeletonExtension.h"
#import "JSSkeletonConfig.h"

@interface JSSkeletonProxyProducer ()

@property (nonatomic, strong, readwrite) NSPointerArray *layoutViews;

@end

@implementation JSSkeletonProxyProducer

- (NSArray<__kindof JSSkeletonLayoutView *> *)produceLayoutViewWithViews:(NSArray<__kindof UIView *> *)views; {
    NSMutableArray *array = [NSMutableArray array];
    for (__kindof UIView *subview in views) {
        if ([subview isKindOfClass:JSSkeletonLayoutView.class]) {
            [array addObject:subview];
            [self.layoutViews addPointer:(__bridge void *)(subview)];
        } else {
            if ([self filterByRulesView:subview]) {
                if (!subview.js_skeletonAnimation) {
                    subview.js_skeletonAnimation = JSSkeletonConfig.sharedConfig.skeletonAnimation;
                }
                if (!subview.js_frameDidChangeBlock) {
                    subview.js_frameDidChangeBlock = ^(__kindof UIView *view, CGRect precedingFrame) {
                        for (JSSkeletonLayoutView *layoutView in view.js_skeletonLayoutViews) {
                            [layoutView updateLayout];
                        }
                    };
                }
                JSSkeletonLayoutView *layoutView = [[JSSkeletonLayoutView alloc] initWithSimulateView:subview];
                [array addObject:layoutView];
//                [subview js_addSkeletonLayoutView:layoutView];
                [self.layoutViews addPointer:(__bridge void *)(layoutView)];
            }
        }
    }
    return array;
}

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

- (NSPointerArray *)layoutViews {
    if (!_layoutViews) {
        _layoutViews = [NSPointerArray weakObjectsPointerArray];
    }
    return _layoutViews;
}

@end

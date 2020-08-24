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

@interface JSSkeletonProxyProducer ()

@property (nonatomic, strong, readwrite) NSPointerArray *layoutViews;

@end

@implementation JSSkeletonProxyProducer

- (NSArray<JSSkeletonLayoutView *> *)produceLayoutViewWithViews:(NSArray<__kindof UIView *> *)views; {
    NSMutableArray *array = [NSMutableArray array];
    for (__kindof UIView *subview in views) {
        if ([subview isKindOfClass:JSSkeletonLayoutView.class]) {
            [array addObject:subview];
        } else {
            if ([self filterByRulesView:subview]) {
                JSSkeletonLayoutView *layoutView = [[JSSkeletonLayoutView alloc] initWithSimulateView:subview];
                [array addObject:layoutView];
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

//
//  JSSkeletonProxyProducer.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/23.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyProducer.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonLayoutView.h"
#import "UIView+JSLayout.h"
#import "JSSkeletonConfig.h"

@interface JSSkeletonProxyProducer ()

@property (nonatomic, strong) NSPointerArray *weakLayoutViews;

@end

@implementation JSSkeletonProxyProducer

#pragma mark - 生成LayoutView

- (NSArray<JSSkeletonLayoutView *> *)produceLayoutViewWithViews:(NSArray<__kindof UIView *> *)views {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (__kindof UIView *subview in views) {
        if ([subview isKindOfClass:JSSkeletonLayoutView.class]) {
            [self.weakLayoutViews addPointer:(__bridge void *)(subview)];
            [resultArray addObject:subview];
        } else {
            if ([self filterByRulesView:subview]) {
                /// 添加默认动画
                [self addDefaultSkeletonAnimationWithView:subview];
                /// 添加布局监听
                [self addFrameDidChangeBlockWithView:subview];
                /// 添加视图
                JSSkeletonLayoutView *layoutView = [self makeLayoutViewWithView:subview];
                [self.weakLayoutViews addPointer:(__bridge void *)layoutView];
                [resultArray addObject:layoutView];
            }
        }
    }
    return resultArray;
}

- (void)addDefaultSkeletonAnimationWithView:(__kindof UIView *)view {
    if (!view.js_skeletonAnimation) {
        view.js_skeletonAnimation = JSSkeletonConfig.sharedConfig.skeletonAnimation;
    }
}

- (void)addFrameDidChangeBlockWithView:(__kindof UIView *)view {
    if (!view.js_skeletonFrameDidChange) {
        view.js_skeletonFrameDidChange = ^(__kindof UIView *view, CGRect precedingFrame) {
            [view js_skeletonUpdateLayoutIfNeeded];
        };
    }
}

- (JSSkeletonLayoutView *)makeLayoutViewWithView:(__kindof UIView *)view {
    JSSkeletonLayoutView *layoutView = [[JSSkeletonLayoutView alloc] initWithSimulateView:view];
    [view js_addSkeletonLayoutView:layoutView];
    if (view.subviews.count > 0) {
        NSArray *resultArray = [self produceLayoutViewWithViews:view.subviews];
        for (JSSkeletonLayoutView *subLayoutView in resultArray) {
            [layoutView addSubview:subLayoutView];
        }
    }
    return layoutView;
}

#pragma mark - 过滤视图

- (BOOL)filterByRulesView:(__kindof UIView *)view {
    BOOL needRemove = false;
    if ([view isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView").class] ||
        [view isKindOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView").class] ||
        [view isKindOfClass:NSClassFromString(@"_UITableViewHeaderFooterViewBackground").class] ||
        [view isKindOfClass:NSClassFromString(@"UITableViewLabel").class]) {
        needRemove = true;
    }
    if ([view isKindOfClass:UIView.class] && !view.js_skeletonInvalid && !view.isHidden && !needRemove) {
        return true;
    }
    return false;
}

- (void)enumerateLayoutViewsUsingBlock:(void (NS_NOESCAPE ^)(JSSkeletonLayoutView *layoutView, NSUInteger idx))block {
    for (NSUInteger i = 0; i < self.weakLayoutViews.count; i++) {
        JSSkeletonLayoutView *layoutView = [self.weakLayoutViews pointerAtIndex:i];
        if (layoutView && [layoutView isKindOfClass:JSSkeletonLayoutView.class]) {
            block(layoutView, i);
        }
    }
}

#pragma mark - getter

- (nullable NSArray<JSSkeletonLayoutView *> *)layoutViews {
    if (self.weakLayoutViews.count > 0) {
        NSMutableArray *result = [NSMutableArray array];
        [self enumerateLayoutViewsUsingBlock:^(JSSkeletonLayoutView *layoutView, NSUInteger idx) {
            [result addObject:layoutView];
        }];
        return result;
    }
    return nil;
}

- (NSPointerArray *)weakLayoutViews {
    if (!_weakLayoutViews) {
        _weakLayoutViews = [NSPointerArray weakObjectsPointerArray];
    }
    return _weakLayoutViews;
}

@end

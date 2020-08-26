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

@property (nonatomic, strong) NSPointerArray *weakLayoutViews;

@end

@implementation JSSkeletonProxyProducer

#pragma mark - 生成LayoutView

- (void)produceLayoutViewWithViews:(NSArray<__kindof UIView *> *)views {
    for (__kindof UIView *subview in views) {
        if ([subview isKindOfClass:JSSkeletonLayoutView.class]) {
            [self.weakLayoutViews addPointer:(__bridge void *)(subview)];
        } else {
            if ([self filterByRulesView:subview]) {
                /// 添加默认动画
                [self addDefaultSkeletonAnimationWithView:subview];
                /// 添加布局监听
                [self addFrameDidChangeBlockWithView:subview];
                /// 添加视图
                [self addLayoutViewWithView:subview];
            }
        }
    }
}

- (void)addDefaultSkeletonAnimationWithView:(__kindof UIView *)view {
    if (!view.js_skeletonAnimation) {
        view.js_skeletonAnimation = JSSkeletonConfig.sharedConfig.skeletonAnimation;
    }
}

- (void)addFrameDidChangeBlockWithView:(__kindof UIView *)view {
    if (!view.js_frameDidChangeBlock) {
        view.js_frameDidChangeBlock = ^(__kindof UIView *view, CGRect precedingFrame) {
            for (JSSkeletonLayoutView *layoutView in view.js_skeletonLayoutViews) {
                if (layoutView && [layoutView isKindOfClass:JSSkeletonLayoutView.class]) {
                    [layoutView updateLayout];
                }
            }
        };
    }
}

- (void)addLayoutViewWithView:(__kindof UIView *)view {
    JSSkeletonLayoutView *layoutView = [[JSSkeletonLayoutView alloc] initWithSimulateView:view];
    [view js_addSkeletonLayoutView:layoutView];
    [self.weakLayoutViews addPointer:(__bridge void *)(layoutView)];
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
    if ([view isKindOfClass:UIView.class] && (!view.isHidden || !view.js_skeletonInvalid) && !needRemove) {
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

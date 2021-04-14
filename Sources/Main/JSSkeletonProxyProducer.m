//
//  JSSkeletonProxyProducer.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/23.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyProducer.h"
#import "UIView+JSSkeleton_Private.h"
#import "JSCoreKit.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonLayoutLayer.h"
#import "JSSkeletonAppearance.h"

@interface JSSkeletonProxyProducer ()

@property (nonatomic, strong) NSPointerArray *weakLayoutLayers;

@end

@implementation JSSkeletonProxyProducer

#pragma mark - 生成LayoutLayer

- (NSArray<JSSkeletonLayoutLayer *> *)produceLayoutLayerWithViews:(NSArray<__kindof UIView *> *)views {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (__kindof UIView *subview in views) {
        if ([self filterByRulesWithView:subview]) {
            /// 添加默认动画
            [self addDefaultSkeletonAnimationWithView:subview];
            /// 添加布局监听
            [self addLayoutSubviewsBlockWithView:subview];
            /// 添加视图
            JSSkeletonLayoutLayer *layoutLayer = [self makeLayoutLayerWithView:subview];
            [self addLayoutLayer:layoutLayer];
            [resultArray addObject:layoutLayer];
        }
    }
    return resultArray;
}

- (void)addDefaultSkeletonAnimationWithView:(__kindof UIView *)view {
    if (!view.js_skeletonAnimation) {
        view.js_skeletonAnimation = JSSkeletonAppearance.appearance.skeletonAnimation;
    }
}

- (void)addLayoutSubviewsBlockWithView:(__kindof UIView *)view {
    if (!view.js_skeletonLayoutSubviewsBlock) {
        view.js_skeletonLayoutSubviewsBlock = ^(__kindof UIView *view) {
            [view js_skeletonUpdateLayoutIfNeeded];
        };
    }
}

- (JSSkeletonLayoutLayer *)makeLayoutLayerWithView:(__kindof UIView *)view {
    JSSkeletonLayoutLayer *layoutLayer = [[JSSkeletonLayoutLayer alloc] initWithSimulateView:view];
    [view js_addSkeletonLayoutLayer:layoutLayer];
    if (view.subviews.count > 0) {
        NSArray *resultArray = [self produceLayoutLayerWithViews:view.subviews];
        for (JSSkeletonLayoutLayer *subLayoutLayer in resultArray) {
            [layoutLayer addSublayer:subLayoutLayer];
        }
    }
    return layoutLayer;
}

- (void)addLayoutLayer:(JSSkeletonLayoutLayer *)layoutLayer {
    [self.weakLayoutLayers addPointer:(__bridge void *)layoutLayer];
}

#pragma mark - 过滤视图

- (BOOL)filterByRulesWithView:(__kindof UIView *)view {
    BOOL needRemove = NO;
    if ([view isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView").class] ||
        [view isKindOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView").class] ||
        [view isKindOfClass:NSClassFromString(@"_UITableViewHeaderFooterViewBackground").class] ||
        [view isKindOfClass:NSClassFromString(@"UITableViewLabel").class]) {
        needRemove = YES;
    }
    if ([view isKindOfClass:UIView.class] && !view.js_skeletonInvalid && !view.isHidden && !needRemove) {
        return YES;
    }
    return NO;
}

- (void)enumerateLayoutLayersUsingBlock:(void (NS_NOESCAPE ^)(JSSkeletonLayoutLayer *layoutLayer, NSUInteger idx))block {
    NSUInteger index = 0;
    for (JSSkeletonLayoutLayer *layoutLayer in self.weakLayoutLayers) {
        if (layoutLayer && [layoutLayer isKindOfClass:JSSkeletonLayoutLayer.class]) {
            block(layoutLayer, index);
            index++;
        }
    }
}

#pragma mark - getter

- (NSArray<JSSkeletonLayoutLayer *> *)layoutLayers {
    NSMutableArray *result = [NSMutableArray array];
    [self enumerateLayoutLayersUsingBlock:^(JSSkeletonLayoutLayer *layoutLayer, NSUInteger idx) {
        [result addObject:layoutLayer];
    }];
    return result;
}

- (NSPointerArray *)weakLayoutLayers {
    if (!_weakLayoutLayers) {
        _weakLayoutLayers = [NSPointerArray weakObjectsPointerArray];
    }
    return _weakLayoutLayers;
}

@end

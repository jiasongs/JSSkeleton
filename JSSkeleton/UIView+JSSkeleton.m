//
//  UIView+JSSkeleton.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeleton.h"
#import "JSSkeletonProxyView.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonProxyCoordinator.h"
#import <objc/runtime.h>

@interface UIView (__JSSkeleton)

@property (nonatomic, strong, readwrite) NSMutableArray<__kindof JSSkeletonProxyView *> *js_skeletonProxyViews;

@end

@implementation UIView (JSSkeleton)

- (__kindof UIView *)js_registerSkeleton {
    return [self __js_produceSkeletonProxyViewWithTargetView:self];
}

- (__kindof UIView *)js_registerSkeletonForViewClass:(Class)viewClass {
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(viewClass) ofType:@"nib"];
    UIView *skeletonView = nibPath ? [NSBundle.mainBundle loadNibNamed:NSStringFromClass(viewClass) owner:nil options:nil].firstObject : nil;
    if (!skeletonView) {
        skeletonView = [[viewClass alloc] init];
    }
    skeletonView.hidden = true;
    JSSkeletonProxyView *proxyView = [self __js_produceSkeletonProxyViewWithTargetView:skeletonView];
    [proxyView addSubview:skeletonView];
    return proxyView;
}

- (void)js_startSkeleton {
    for (__kindof JSSkeletonProxyView *proxyView in self.js_skeletonProxyViews) {
        [proxyView.coordinator start];
    }
}

- (void)js_endSkeleton {
    for (__kindof JSSkeletonProxyView *proxyView in self.js_skeletonProxyViews) {
        [proxyView.coordinator end];
    }
}

#pragma mark - 生产

- (__kindof JSSkeletonProxyView *)__js_produceSkeletonProxyViewWithTargetView:(UIView *)targetView {
    JSSkeletonProxyView *proxyView = [[JSSkeletonProxyView alloc] initWithRegisterView:self targetView:targetView];
    [self addSubview:proxyView];
    /// 添加到数组里
    [self.js_skeletonProxyViews addObject:proxyView];
    return proxyView;
}

- (NSMutableArray<__kindof JSSkeletonProxyView *> *)js_skeletonProxyViews {
    NSMutableArray *skeletonProxyViews = objc_getAssociatedObject(self, _cmd);
    if (!skeletonProxyViews) {
        skeletonProxyViews = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, skeletonProxyViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return skeletonProxyViews;
}

@end

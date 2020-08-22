//
//  UITableView+JSSkeleton.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UITableView+JSSkeleton.h"
#import "JSSkeletonProxyTableView.h"
#import "UIView+JSSkeleton.h"
#import "UIView+JSSkeletonProperty.h"

@interface UITableView (__JSSkeleton)

@end

@implementation UITableView (JSSkeleton)

- (__kindof UIView *)js_registerSkeletonForCellClass:(Class)cellClass {
    JSSkeletonProxyTableView *proxyView = [self __js_produceSkeletonProxyTableViewWithTargetView:self];
    [proxyView registerCellClass:cellClass];
    return proxyView;
}

- (__kindof JSSkeletonProxyView *)__js_produceSkeletonProxyTableViewWithTargetView:(UIView *)targetView {
    JSSkeletonProxyTableView *proxyView = [[JSSkeletonProxyTableView alloc] initWithTargetView:targetView];
    proxyView.hidden = true;
    [self.superview addSubview:proxyView];
    /// 添加到数组里
    [self.js_skeletonProxyViews addObject:proxyView];
    return proxyView;
}

@end

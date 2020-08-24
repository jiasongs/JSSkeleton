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
#import "JSSkeletonProxyCoordinator.h"
#import "UIView+JSSkeletonExtension.h"
#import <objc/runtime.h>

@interface UITableView (__JSSkeleton)

@property (nonatomic, strong, readwrite) NSMutableArray<__kindof JSSkeletonProxyView *> *js_skeletonProxyViews;

@end

@implementation UITableView (JSSkeleton)

#pragma mark - UITableViewCell

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForCellClass:(Class)cellClass heightForRow:(CGFloat)height {
    return [self js_registerSkeletonForCellClass:cellClass numberOfRow:0 heightForRow:height];
}

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForCellClass:(Class)cellClass
                                                           numberOfRow:(NSUInteger)numberOfRow
                                                          heightForRow:(CGFloat)height {
    JSSkeletonProxyTableView *tableProxyView = [self __js_currentSkeletonProxyTableView];
    tableProxyView.heightForRows = @[@(height)];
    tableProxyView.numberOfRows = numberOfRow ?  @[@(numberOfRow)] : @[];
    /// 最后注册
    [tableProxyView registerCellClass:@[cellClass]];
    return tableProxyView;
}

#pragma mark - UITableViewHeader-Footer

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableViewHeaderClass:(Class)viewClass heightForView:(CGFloat)height {
    JSSkeletonProxyTableView *tableProxyView = [self __js_currentSkeletonProxyTableView];
    UIView *tableHeaderView = tableProxyView.tableView.tableHeaderView;
    tableHeaderView.js_height = height;
    [tableHeaderView js_registerSkeletonForViewClass:viewClass];
    tableHeaderView.js_frameDidChangeBlock = ^(__kindof UIView *view, CGRect precedingFrame) {
        for (JSSkeletonProxyView *proxyView in view.js_skeletonProxyViews) {
            proxyView.frame = view.bounds;
        }
    };
    return tableProxyView;
}

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableViewFooterClass:(Class)viewClass heightForView:(CGFloat)height {
    JSSkeletonProxyTableView *tableProxyView = [self __js_currentSkeletonProxyTableView];
    UIView *tableFooterView = tableProxyView.tableView.tableFooterView;
    tableFooterView.js_height = height;
    [tableFooterView js_registerSkeletonForViewClass:viewClass];
    tableFooterView.js_frameDidChangeBlock = ^(__kindof UIView *view, CGRect precedingFrame) {
        for (JSSkeletonProxyView *proxyView in view.js_skeletonProxyViews) {
            proxyView.frame = view.bounds;
        }
    };
    return tableProxyView;
}

- (void)js_startSkeleton {
    for (JSSkeletonProxyTableView *proxyView in self.js_skeletonProxyViews) {
        [proxyView.coordinator start];
        [proxyView.tableView.tableHeaderView js_startSkeleton];
        [proxyView.tableView.tableFooterView js_startSkeleton];
    }
}

- (void)js_endSkeleton {
    for (JSSkeletonProxyTableView *proxyView in self.js_skeletonProxyViews) {
        [proxyView.coordinator end];
        [proxyView.tableView.tableHeaderView js_endSkeleton];
        [proxyView.tableView.tableFooterView js_endSkeleton];
    }
}

#pragma mark - 私有

- (__kindof JSSkeletonProxyView *)__js_produceSkeletonProxyTableView {
    JSSkeletonProxyTableView *proxyView = [[JSSkeletonProxyTableView alloc] initWithRegisterView:self targetView:nil];
    [self.superview addSubview:proxyView];
    [self.js_skeletonProxyViews addObject:proxyView];
    return proxyView;
}

- (__kindof JSSkeletonProxyView *)__js_currentSkeletonProxyTableView {
    JSSkeletonProxyTableView *tableProxyView;
    for (JSSkeletonProxyTableView *proxyView in self.js_skeletonProxyViews) {
        if (proxyView.registerView == self) {
            tableProxyView = proxyView;
            break;
        }
    }
    if (!tableProxyView) {
        tableProxyView = [self __js_produceSkeletonProxyTableView];
    }
    return tableProxyView;
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

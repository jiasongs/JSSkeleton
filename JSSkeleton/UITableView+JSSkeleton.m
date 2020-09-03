//
//  UITableView+JSSkeleton.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UITableView+JSSkeleton.h"
#import "JSSkeletonProxyTableView.h"
#import "UIView+JSSkeleton.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonProxyCoordinator.h"
#import "UIView+JSLayout.h"
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

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableHeaderView {
    return [self __js_registerForTableHeaderFooterViewWithTargetViewClass:nil heightForView:0 isHeaderView:true];
}

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableHeaderViewClass:(Class)viewClass heightForView:(CGFloat)height {
    return [self __js_registerForTableHeaderFooterViewWithTargetViewClass:viewClass heightForView:height isHeaderView:true];
}

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableFooterView {
    return [self __js_registerForTableHeaderFooterViewWithTargetViewClass:nil heightForView:0 isHeaderView:false];
}

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableFooterViewClass:(Class)viewClass heightForView:(CGFloat)height {
    return [self __js_registerForTableHeaderFooterViewWithTargetViewClass:viewClass heightForView:height isHeaderView:false];
}

- (__kindof JSSkeletonProxyTableView *)__js_registerForTableHeaderFooterViewWithTargetViewClass:(nullable Class)targetViewClass
                                                                                  heightForView:(CGFloat)height
                                                                                   isHeaderView:(BOOL)isHeaderView {
    JSSkeletonProxyTableView *tableProxyView = [self __js_currentSkeletonProxyTableView];
    __kindof UIView *tableHeaderFooterView = isHeaderView ? self.tableHeaderView : self.tableFooterView;
    UIView *tableHeaderFooterProxyView = isHeaderView ? tableProxyView.tableView.tableHeaderView : tableProxyView.tableView.tableFooterView;
    if (targetViewClass) {
        [tableHeaderFooterProxyView js_registerSkeletonForViewClass:targetViewClass];
    } else {
        [tableHeaderFooterProxyView js_registerSkeletonForView:tableHeaderFooterView];
    }
    tableHeaderFooterProxyView.js_height = height ? : tableHeaderFooterView.js_height;
    tableHeaderFooterProxyView.js_skeletonFrameDidChange = ^(__kindof UIView *view, CGRect precedingFrame) {
        for (JSSkeletonProxyView *proxyView in view.js_skeletonProxyViews) {
            proxyView.frame = view.bounds;
        }
    };
    return tableProxyView;
}

#pragma mark - 开始、结束

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

- (__kindof JSSkeletonProxyView *)__js_currentSkeletonProxyTableView {
    __block JSSkeletonProxyTableView *tableProxyView = nil;
    [self.js_skeletonProxyViews enumerateObjectsUsingBlock:^(JSSkeletonProxyTableView *proxyView, NSUInteger idx, BOOL *stop) {
        if (proxyView.registerView == self) {
            tableProxyView = proxyView;
            *stop = true;
        }
    }];
    if (!tableProxyView) {
        tableProxyView = [self __js_produceSkeletonProxyTableView];
    }
    return tableProxyView;
}

- (__kindof JSSkeletonProxyView *)__js_produceSkeletonProxyTableView {
    JSSkeletonProxyTableView *proxyView = [[JSSkeletonProxyTableView alloc] initWithRegisterView:self targetView:nil];
    if (self.superview) {
        [self.superview addSubview:proxyView];
    } else {
        [self addSubview:proxyView];
    }
    [self.js_skeletonProxyViews addObject:proxyView];
    return proxyView;
}

@end

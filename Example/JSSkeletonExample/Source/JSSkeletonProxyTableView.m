//
//  JSSkeletonProxyTableView.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyTableView.h"
#import "JSSkeletonProxyTableViewCell.h"
#import "JSSkeletonProxyView.h"
#import "UIView+JSSkeletonProperty.h"
#import "UIView+JSSkeleton.h"

@interface JSSkeletonProxyTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak, readwrite) __kindof UIView *targetView;
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, assign) Class cellCalss;
@property (nonatomic, strong) NSMapTable *cacheCellMapTable;

@end

@implementation JSSkeletonProxyTableView
@synthesize targetView = _targetView;

- (void)didInitialize {
    [super didInitialize];
    [self addSubview:self.tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_tableView) {
        _tableView.frame = self.bounds;
    }
}

- (void)registerCellClass:(nullable Class)cellClass {
    _cellCalss = cellClass;
    NSUInteger numberCount = [self.tableView numberOfRowsInSection:0];
    for (int i = 0; i < numberCount; i++) {
        NSString *key = [NSString stringWithFormat:@"%@-%@", @(0), @(i)];
        JSSkeletonProxyTableViewCell *cell = [self.cacheCellMapTable objectForKey:key];
        if (!cell) {
            cell = [[JSSkeletonProxyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(JSSkeletonProxyTableViewCell.class) targetCellClass:_cellCalss];
            [self.cacheCellMapTable setObject:cell forKey:key];
        }
    }
}

- (void)start {
    [self.tableView reloadData];
    [self scrollToTop];
    for (NSString *key in self.cacheCellMapTable) {
        JSSkeletonProxyTableViewCell *cell = [self.cacheCellMapTable objectForKey:key];
        [cell start];
    }
    [super start];
}

- (void)end {
    for (NSString *key in self.cacheCellMapTable) {
        JSSkeletonProxyTableViewCell *cell = [self.cacheCellMapTable objectForKey:key];
        [cell end];
    }
    [super end];
}

- (void)scrollToTop {
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    if (@available(iOS 11, *)) {
        contentInset = self.tableView.adjustedContentInset;
    } else {
        contentInset = self.tableView.contentInset;
    }
    [self.tableView setContentOffset:CGPointMake(-contentInset.left, -contentInset.top)];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (JSSkeletonProxyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];
    JSSkeletonProxyTableViewCell *cell = [self.cacheCellMapTable objectForKey:key];
    if (!cell) {
        cell = [[JSSkeletonProxyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(JSSkeletonProxyTableViewCell.class) targetCellClass:_cellCalss];
        [self.cacheCellMapTable setObject:cell forKey:key];
    }
    return cell;
}

#pragma mark - setter

- (void)setTargetView:(__kindof UITableView *)targetView {
    _targetView = targetView;
    self.tableView.contentInset = targetView.contentInset;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = nil;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _tableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.alwaysBounceVertical = true;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (NSMapTable *)cacheCellMapTable {
    if (!_cacheCellMapTable) {
        _cacheCellMapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    }
    return _cacheCellMapTable;
}

@end

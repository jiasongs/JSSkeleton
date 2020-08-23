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
#import "JSSkeletonProxyProducer.h"

@interface JSSkeletonProxyTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong) NSMapTable *cacheCellMapTable;

@end

@implementation JSSkeletonProxyTableView

- (void)didInitialize {
    [super didInitialize];
    self.numberOfSection = 1;
    [self addSubview:self.tableView];
    if ([self.registerView isKindOfClass:UITableView.class]) {
        UITableView *tableView = self.registerView;
        self.tableView.contentInset = tableView.contentInset;
        UIEdgeInsets contentInset = UIEdgeInsetsZero;
        if (@available(iOS 11, *)) {
            contentInset = self.tableView.adjustedContentInset;
        } else {
            contentInset = self.tableView.contentInset;
        }
        [self.tableView setContentOffset:CGPointMake(-contentInset.left, -contentInset.top)];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

#pragma mark - 注册

- (void)registerCellClass:(NSArray<Class> *)cellClasss {
    NSAssert(cellClasss.count == self.numberOfSection, @"");
    NSAssert(self.heightForRows.count != 0, @"");
    NSMutableArray *numberOfRows = [NSMutableArray arrayWithArray:self.numberOfRows ? : @[]];
    for (int section = 0; section < self.numberOfSection; section++) {
        if (self.numberOfRows.count == 0) {
            [numberOfRows addObject:@(10)];
        }
        Class cellClass = [cellClasss objectAtIndex:section];
        NSInteger numberOfRow = [[numberOfRows objectAtIndex:section] integerValue];
        for (int row = 0; row < numberOfRow; row++) {
            NSString *key = [NSString stringWithFormat:@"%@-%@", @(section), @(row)];
            JSSkeletonProxyTableViewCell *cell = [[JSSkeletonProxyTableViewCell alloc] initWithTargetCellClass:cellClass];
            [self.cacheCellMapTable setObject:cell forKey:key];;
            for (JSSkeletonLayoutView *layoutView in cell.producer.layoutViews) {
                [self.producer.layoutViews addPointer:(__bridge void *)(layoutView)];
            }
        }
    }
    self.numberOfRows = numberOfRows.copy;
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.numberOfRows objectAtIndex:section] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.heightForRows objectAtIndex:indexPath.section] floatValue];
}

- (JSSkeletonProxyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];
    JSSkeletonProxyTableViewCell *cell = [self.cacheCellMapTable objectForKey:key];
    return cell ? : JSSkeletonProxyTableViewCell.new;
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

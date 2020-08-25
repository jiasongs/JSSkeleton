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
#import "JSSkeletonLayoutView.h"
#import "UIView+JSSkeletonExtension.h"
#import "JSSkeletonDefines.h"

@interface JSSkeletonProxyTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, assign) CGFloat numberOfSection;
@property (nonatomic, strong) NSArray<__kindof UITableViewCell *> *targetCells;

@end

@implementation JSSkeletonProxyTableView

- (void)didInitialize {
    [super didInitialize];
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
    self.numberOfSection = cellClasss.count;
    NSMutableArray *targetCells = [NSMutableArray array];
    NSMutableArray *numberOfRows = [NSMutableArray arrayWithArray:self.numberOfRows ? : @[]];
    for (int section = 0; section < self.numberOfSection; section++) {
        if (self.numberOfRows.count == 0) {
#if TARGET_OS_MACCATALYST
            JSBeginIgnoreDeprecatedWarning
            CGFloat height = self.js_height ? : UIScreen.mainScreen.applicationFrame.size.height;
            JSEndIgnoreDeprecatedWarning
#else
            CGFloat height = self.js_height ? : UIScreen.mainScreen.bounds.size.height;
#endif
            [numberOfRows addObject:@(lrintf(height / [[self.heightForRows objectAtIndex:section] floatValue]))];
        }
        Class cellClass = [cellClasss objectAtIndex:section];
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        __kindof UITableViewCell *cell = nibPath ? [NSBundle.mainBundle loadNibNamed:NSStringFromClass(cellClass) owner:nil options:nil].firstObject : nil;
        if (!cell) {
            cell = [[cellClass alloc] initWithFrame:CGRectZero];
        }
        [targetCells addObject:cell];
    }
    self.numberOfRows = numberOfRows.copy;
    self.targetCells = targetCells.copy;
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
    __kindof UITableViewCell *targetCell = [self.targetCells objectAtIndex:indexPath.section];
    NSString *identifier = [NSString stringWithFormat:@"JSSkeletonProxyTableViewCell-%@", NSStringFromClass(targetCell.class)];
    JSSkeletonProxyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JSSkeletonProxyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier targetCell:targetCell];
        for (JSSkeletonLayoutView *layoutView in cell.producer.layoutViews) {
            [self.producer.layoutViews addPointer:(__bridge void *)(layoutView)];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(JSSkeletonProxyTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.registerView.js_skeletonDisplay) {
        for (JSSkeletonLayoutView *layoutView in self.producer.layoutViews) {
            if ([layoutView isKindOfClass:JSSkeletonLayoutView.class]) {
                [layoutView startAnimation];
            }
        }
    }
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

@end

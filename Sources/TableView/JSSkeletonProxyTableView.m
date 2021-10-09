//
//  JSSkeletonProxyTableView.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyTableView.h"
#import "JSSkeletonProxyTableViewCell.h"
#import "UIView+JSSkeleton.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonProxyProducer.h"
#import "JSSkeletonLayoutLayer.h"

NSString * const JSSkeletonProxyTableViewReuseIdentifier = @"JSSkeletonProxyTableViewReuseIdentifier_";

@interface JSSkeletonProxyTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation JSSkeletonProxyTableView

- (void)didInitialize {
    [super didInitialize];
    [self addSubview:self.tableView];
    if ([self.registerView isKindOfClass:UITableView.class]) {
        UITableView *registerTableView = self.registerView;
        self.tableView.contentInset = registerTableView.contentInset;
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
    [super registerCellClass:cellClasss];
    for (__kindof UITableViewCell *targetCell in self.targetCells) {
        NSString *identifier = [NSString stringWithFormat:@"%@%@", JSSkeletonProxyTableViewReuseIdentifier, NSStringFromClass(targetCell.class)];
        [self.tableView registerClass:JSSkeletonProxyTableViewCell.class forCellReuseIdentifier:identifier];
    }
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
    NSString *identifier = [NSString stringWithFormat:@"%@%@", JSSkeletonProxyTableViewReuseIdentifier, NSStringFromClass(targetCell.class)];
    JSSkeletonProxyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell.producer.layoutLayers.count == 0) {
        [cell produceLayoutLayerWithTargetCell:targetCell];
        /// 添加到self.producer
        [cell.producer enumerateLayoutLayersUsingBlock:^(JSSkeletonLayoutLayer *layoutLayer, NSUInteger idx) {
            [self.producer addLayoutLayer:layoutLayer];
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(JSSkeletonProxyTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.registerView.js_skeletonDisplay) {
        [self.producer enumerateLayoutLayersUsingBlock:^(JSSkeletonLayoutLayer *layoutLayer, NSUInteger idx) {
            [layoutLayer startAnimation];
        }];
    }
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = nil;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _tableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 15.0, *)) {
            _tableView.fillerRowHeight = 0;
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.alwaysBounceVertical = YES;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _tableView;
}

@end

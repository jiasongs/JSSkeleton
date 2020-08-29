//
//  JSTableViewController.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSTableViewController.h"
#import "JSTableViewCell.h"
#import "UITableView+JSSkeleton.h"
#import "UIView+JSSkeleton.h"
#import "JSNormalDetailView.h"
#import "ITForumNewNoImageSkeletonCell.h"

@interface JSTableViewController ()

@end

@implementation JSTableViewController

- (void)initSubviews {
    [super initSubviews];
    [[self.tableView js_registerSkeletonForCellClass:ITForumNewNoImageSkeletonCell.class heightForRow:[ITForumNewNoImageSkeletonCell skeletonHeight]] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView);
    }];
    [self.tableView js_startSkeleton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView js_endSkeleton];
    });
}

- (void)initTableView {
    [super initTableView];
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    CGFloat top = NavigationContentTop;
#if TARGET_OS_MACCATALYST
    top = top + 44;
#endif
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, SafeAreaInsetsConstantForDeviceWithNotch.bottom, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    return cell;
}

@end

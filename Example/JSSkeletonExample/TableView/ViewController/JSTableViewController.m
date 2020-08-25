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
//    UIView *skeletonView = [self.tableView js_registerSkeletonForCellClass:JSTableViewCell.class heightForRows:108];
//    UIView *skeletonView = [self.tableView js_registerSkeletonForCellClass:JSTableViewCell.class numberOfRow:4 heightForRow:108];
//    [skeletonView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(skeletonView.superview);
//    }];
//    [self.tableView js_registerSkeletonForTableViewHeaderClass:JSNormalDetailView.class heightForView:360];
//    [self.tableView js_registerSkeletonForTableViewFooterClass:JSNormalDetailView.class heightForView:360];
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
    self.tableView.contentInset = UIEdgeInsetsMake(NavigationContentTop, 0, SafeAreaInsetsConstantForDeviceWithNotch.bottom, 0);
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

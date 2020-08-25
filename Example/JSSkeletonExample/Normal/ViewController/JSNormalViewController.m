//
//  JSNormalViewController.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSNormalViewController.h"
#import "JSNormalDetailView.h"
#import "UIView+JSSkeleton.h"
#import "UIView+JSSkeletonProperty.h"
#import "ITNewsDetailSkeletonView.h"

@interface JSNormalViewController ()

@property (nonatomic, strong) JSNormalDetailView *detailView;

@end

@implementation JSNormalViewController

-(void)initSubviews {
    [super initSubviews];
    /// 视图
    self.detailView = [NSBundle.mainBundle loadNibNamed:NSStringFromClass(JSNormalDetailView.class) owner:nil options:nil].firstObject;
    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NavigationContentTop);
        make.left.right.bottom.equalTo(self.view);
    }];
    /// 例子1
    //    [self example1];
    /// 例子2
    [self example2];
}

- (void)example1 {
    UIView *skeletonView = [self.detailView js_registerSkeleton];
    [skeletonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailView);
    }];
    [self.detailView js_startSkeleton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            [self.detailView js_endSkeleton];
    });
}

- (void)example2 {
    UIView *skeletonView = [self.view js_registerSkeletonForViewClass:ITNewsDetailSkeletonView.class];
    [skeletonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view js_startSkeleton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.view js_endSkeleton];
    });
}

@end

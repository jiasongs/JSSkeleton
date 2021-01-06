//
//  UIView+JSSkeleton.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeleton.h"
#import "JSCoreKit.h"
#import "JSSkeletonProxyView.h"
#import "JSSkeletonProxyTableView.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonProxyCoordinator.h"

@interface UIView (__JSSkeleton)

@property (nonatomic, strong, readwrite) NSMutableArray<__kindof JSSkeletonProxyView *> *js_skeletonProxyViews;

@end

@implementation UIView (JSSkeleton)

JSSynthesizeBOOLProperty(js_skeletonDisplay, setJs_skeletonDisplay)

#pragma mark - 开始、结束

- (void)js_startSkeleton {
    for (__kindof JSSkeletonProxyView *proxyView in self.js_skeletonProxyViews) {
        [proxyView.coordinator start];
        if ([proxyView isKindOfClass:JSSkeletonProxyTableView.class]) {
            __kindof JSSkeletonProxyTableView *tableProxyView = (__kindof JSSkeletonProxyTableView *)proxyView;
            [tableProxyView.tableView.tableHeaderView js_startSkeleton];
            [tableProxyView.tableView.tableFooterView js_startSkeleton];
        }
    }
}

- (void)js_endSkeleton {
    for (__kindof JSSkeletonProxyView *proxyView in self.js_skeletonProxyViews) {
        [proxyView.coordinator end];
        if ([proxyView isKindOfClass:JSSkeletonProxyTableView.class]) {
            __kindof JSSkeletonProxyTableView *tableProxyView = (__kindof JSSkeletonProxyTableView *)proxyView;
            [tableProxyView.tableView.tableHeaderView js_endSkeleton];
            [tableProxyView.tableView.tableFooterView js_endSkeleton];
        }
    }
}

#pragma mark - 骨架屏View的集合

- (NSMutableArray<__kindof JSSkeletonProxyView *> *)js_skeletonProxyViews {
    NSMutableArray *skeletonProxyViews = objc_getAssociatedObject(self, _cmd);
    if (!skeletonProxyViews) {
        skeletonProxyViews = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, skeletonProxyViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return skeletonProxyViews;
}

@end

@implementation UIView (JSSkeletonForView)

#pragma mark - UIView

- (__kindof JSSkeletonProxyView *)js_registerSkeleton {
    return [self __js_produceSkeletonProxyViewWithTargetView:self];
}

- (__kindof JSSkeletonProxyView *)js_registerSkeletonForView:(__kindof UIView *)view {
    return [self __js_produceSkeletonProxyViewWithTargetView:view];
}

- (__kindof JSSkeletonProxyView *)js_registerSkeletonForViewClass:(Class)viewClass {
    NSString *nibPath = [[NSBundle bundleForClass:viewClass] pathForResource:NSStringFromClass(viewClass) ofType:@"nib"];
    UIView *skeletonView = nibPath ? [[NSBundle bundleForClass:viewClass] loadNibNamed:NSStringFromClass(viewClass) owner:nil options:nil].firstObject : nil;
    if (!skeletonView) {
        skeletonView = [[viewClass alloc] init];
    }
    skeletonView.hidden = true;
    JSSkeletonProxyView *proxyView = [self __js_produceSkeletonProxyViewWithTargetView:skeletonView];
    [proxyView addSubview:skeletonView];
    return proxyView;
}

#pragma mark - 生产ProxyView

- (__kindof JSSkeletonProxyView *)__js_produceSkeletonProxyViewWithTargetView:(UIView *)targetView {
    JSSkeletonProxyView *proxyView = [[JSSkeletonProxyView alloc] initWithRegisterView:self targetView:targetView];
    [self addSubview:proxyView];
    /// 添加到数组里
    [self.js_skeletonProxyViews addObject:proxyView];
    return proxyView;
}

@end

@implementation UIView (JSSkeletonForTableView)

#pragma mark - UITableViewCell

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableViewCellClass:(Class)cellClass heightForRow:(CGFloat)height {
    return [self js_registerSkeletonForTableViewCellClass:cellClass numberOfRow:0 heightForRow:height];
}

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableViewCellClass:(Class)cellClass
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
    __kindof UIView *tableHeaderFooterView = nil;
    if ([self isKindOfClass:UITableView.class]) {
        tableHeaderFooterView = isHeaderView ? [(UITableView *)self tableHeaderView] : [(UITableView *)self tableFooterView];
    }
    JSSkeletonProxyTableView *tableProxyView = [self __js_currentSkeletonProxyTableView];
    UIView *tableHeaderFooterProxyView = isHeaderView ? tableProxyView.tableView.tableHeaderView : tableProxyView.tableView.tableFooterView;
    if (targetViewClass) {
        [tableHeaderFooterProxyView js_registerSkeletonForViewClass:targetViewClass];
    } else if (tableHeaderFooterView) {
        [tableHeaderFooterProxyView js_registerSkeletonForView:tableHeaderFooterView];
    }
    tableHeaderFooterProxyView.js_skeletonFrameDidChange = ^(__kindof UIView *view, CGRect precedingFrame) {
        for (JSSkeletonProxyView *proxyView in view.js_skeletonProxyViews) {
            proxyView.frame = view.bounds;
        }
    };
    tableHeaderFooterProxyView.js_height = height ? : tableHeaderFooterView.js_height;
    return tableProxyView;
}

#pragma mark - 生产ProxyTableView

- (__kindof JSSkeletonProxyTableView *)__js_currentSkeletonProxyTableView {
    __block JSSkeletonProxyTableView *tableProxyView = nil;
    [self.js_skeletonProxyViews enumerateObjectsUsingBlock:^(JSSkeletonProxyTableView *proxyView, NSUInteger idx, BOOL *stop) {
        if (proxyView.registerView == self) {
            tableProxyView = proxyView;
            *stop = true;
        }
    }];
    if (!tableProxyView) {
        tableProxyView = [[JSSkeletonProxyTableView alloc] initWithRegisterView:self targetView:nil];
        if ([self isKindOfClass:UITableView.class] && self.superview) {
            [self.superview addSubview:tableProxyView];
        } else {
            [self addSubview:tableProxyView];
        }
        [self.js_skeletonProxyViews addObject:tableProxyView];
    }
    return tableProxyView;
}

@end

@implementation UIView (JSSkeletonForCollectionView)

@end

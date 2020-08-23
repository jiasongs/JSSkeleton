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

@interface UITableView (__JSSkeleton)

@property (nonatomic, strong, readwrite) NSMutableArray<__kindof JSSkeletonProxyView *> *js_skeletonProxyViews;

@end

@implementation UITableView (JSSkeleton)

#pragma mark - UITableViewCell

- (__kindof UIView *)js_registerSkeletonForCellClass:(Class)cellClass heightForRows:(CGFloat)height {
    JSSkeletonProxyTableView *proxyView = [self __js_produceSkeletonProxyTableView];
    proxyView.heightForRows = @[@(height)];
    /// 最后注册
    [proxyView registerCellClass:@[cellClass]];
    return proxyView;
}

- (__kindof UIView *)js_registerSkeletonForCellClass:(Class)cellClass
                                         numberOfRow:(NSUInteger)numberOfRow
                                       heightForRows:(CGFloat)height {
    JSSkeletonProxyTableView *proxyView = [self __js_produceSkeletonProxyTableView];
    proxyView.heightForRows = @[@(height)];
    proxyView.numberOfRows = @[@(numberOfRow)];
    /// 最后注册
    [proxyView registerCellClass:@[cellClass]];
    return proxyView;
}

#pragma mark - UITableViewSection

- (__kindof UIView *)js_registerSkeletonForSectionHeaderClass:(Class)cellClass heightForHeader:(CGFloat)height {
    return UIView.new;
}

- (__kindof UIView *)js_registerSkeletonForSectionFooterClass:(Class)cellClass heightForFooter:(CGFloat)height {
    return UIView.new;
}

#pragma mark - UITableViewHeader-Footer

- (__kindof UIView *)js_registerSkeletonForTableViewHeaderClass:(Class)cellClass heightForHeader:(CGFloat)height {
    return UIView.new;
}

- (__kindof UIView *)js_registerSkeletonForTableViewFooterClass:(Class)cellClass heightForFooter:(CGFloat)height {
    return UIView.new;
}

#pragma mark - 私有

- (__kindof JSSkeletonProxyView *)__js_produceSkeletonProxyTableView {
    JSSkeletonProxyTableView *proxyView = [[JSSkeletonProxyTableView alloc] initWithRegisterView:self targetView:nil];
    [self.superview addSubview:proxyView];
    [self.js_skeletonProxyViews addObject:proxyView];
    return proxyView;
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

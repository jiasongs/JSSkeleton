//
//  UITableView+JSSkeleton.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSkeletonProxyView;
@class JSSkeletonProxyTableView;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (JSSkeleton)

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForCellClass:(Class)cellClass heightForRow:(CGFloat)height;

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForCellClass:(Class)cellClass
                                                           numberOfRow:(NSUInteger)numberOfRow
                                                          heightForRow:(CGFloat)height;

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableHeaderView;
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableHeaderViewClass:(Class)viewClass heightForView:(CGFloat)height;
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableFooterView;
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableFooterViewClass:(Class)viewClass heightForView:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END

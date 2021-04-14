//
//  UIView+JSSkeleton.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSSkeletonProxyView;
@class JSSkeletonProxyTableView;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JSSkeleton)

@property (nonatomic, assign) BOOL js_skeletonDisplay;
@property (nonatomic, strong, readonly) NSArray<__kindof JSSkeletonProxyView *> *js_skeletonProxyViews;

- (void)js_startSkeleton;
- (void)js_endSkeleton;

@end

@interface UIView (JSSkeletonForView)

/// UIView
- (__kindof JSSkeletonProxyView *)js_registerSkeleton;
- (__kindof JSSkeletonProxyView *)js_registerSkeletonForView:(__kindof UIView *)view;
- (__kindof JSSkeletonProxyView *)js_registerSkeletonForViewClass:(Class)viewClass;

@end

@interface UIView (JSSkeletonForTableView)

/// UITableViewCell
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableViewCellClass:(Class)cellClass heightForRow:(CGFloat)height;

- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableViewCellClass:(Class)cellClass
                                                                    numberOfRow:(NSUInteger)numberOfRow
                                                                   heightForRow:(CGFloat)height;
/// UITableHeaderView-Footer
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableHeaderView;
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableHeaderViewClass:(Class)viewClass heightForView:(CGFloat)height;
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableFooterView;
- (__kindof JSSkeletonProxyTableView *)js_registerSkeletonForTableFooterViewClass:(Class)viewClass heightForView:(CGFloat)height;

@end

/// TODO: UICollectionView
@interface UIView (JSSkeletonForCollectionView)

@end

NS_ASSUME_NONNULL_END

//
//  UITableView+JSSkeleton.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (JSSkeleton)

- (__kindof UIView *)js_registerSkeletonForCellClass:(Class)cellClass heightForRows:(CGFloat)height;

- (__kindof UIView *)js_registerSkeletonForCellClass:(Class)cellClass
                                         numberOfRow:(NSUInteger)numberOfRow
                                       heightForRows:(CGFloat)height;

- (__kindof UIView *)js_registerSkeletonForSectionHeaderClass:(Class)viewClass heightForView:(CGFloat)height;
- (__kindof UIView *)js_registerSkeletonForSectionFooterClass:(Class)viewClass heightForView:(CGFloat)height;

- (__kindof UIView *)js_registerSkeletonForTableViewHeaderClass:(Class)viewClass heightForView:(CGFloat)height;
- (__kindof UIView *)js_registerSkeletonForTableViewFooterClass:(Class)viewClass heightForView:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END

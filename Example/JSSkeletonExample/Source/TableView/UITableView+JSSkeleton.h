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

- (__kindof UIView *)js_registerSkeletonForCellClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END

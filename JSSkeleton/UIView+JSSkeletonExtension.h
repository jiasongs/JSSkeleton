//
//  UIView+JSSkeletonExtension.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/24.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JSSkeletonExtension)

@property (nonatomic, copy, nullable) void (^js_frameDidChangeBlock)(__kindof UIView *view, CGRect precedingFrame);

/// 等价于 CGRectGetMinY(frame)
@property (nonatomic, assign) CGFloat js_top;

/// 等价于 CGRectGetMinX(frame)
@property (nonatomic, assign) CGFloat js_left;

/// 等价于 CGRectGetMaxY(frame)
@property (nonatomic, assign) CGFloat js_bottom;

/// 等价于 CGRectGetMaxX(frame)
@property (nonatomic, assign) CGFloat js_right;

/// 等价于 CGRectGetWidth(frame)
@property (nonatomic, assign) CGFloat js_width;

/// 等价于 CGRectGetHeight(frame)
@property (nonatomic, assign) CGFloat js_height;

@end

NS_ASSUME_NONNULL_END
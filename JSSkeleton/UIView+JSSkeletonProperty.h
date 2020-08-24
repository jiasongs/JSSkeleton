//
//  UIView+JSSkeletonProperty.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JSSkeletonAnimationProtocol;
@class JSSkeletonLayoutView;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JSSkeletonProperty)

@property (nonatomic, assign) BOOL js_skeletonDisplay;
@property (nonatomic, assign) BOOL js_skeletonInvalid;
@property (nonatomic, assign) CGFloat js_skeletonMarginTop;
@property (nonatomic, assign) CGFloat js_skeletonMarginLeft;
@property (nonatomic, assign) CGFloat js_skeletonWidth;
@property (nonatomic, assign) CGFloat js_skeletonHeight;
@property (nonatomic, assign) CGFloat js_skeletonHeightCoefficient;
@property (nonatomic, assign) CGFloat js_skeletonLineSpacing;
@property (nonatomic, assign) CGFloat js_skeletonCornerRadius;
@property (nonatomic, copy, nullable) UIColor *js_skeletonTintColor;
@property (nonatomic, strong, nullable) id<JSSkeletonAnimationProtocol> js_skeletonAnimation;
@property (nonatomic, weak, nullable) JSSkeletonLayoutView *js_skeletonLayoutView;

@end

NS_ASSUME_NONNULL_END

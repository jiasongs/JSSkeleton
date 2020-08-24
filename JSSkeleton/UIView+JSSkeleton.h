//
//  UIView+JSSkeleton.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSkeletonProxyView;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JSSkeleton)

@property (nonatomic, copy, readonly) NSArray<__kindof JSSkeletonProxyView *> *js_skeletonProxyViews;

- (__kindof JSSkeletonProxyView *)js_registerSkeleton;
- (__kindof JSSkeletonProxyView *)js_registerSkeletonForViewClass:(Class)viewClass;

- (void)js_startSkeleton;
- (void)js_endSkeleton;

@end

NS_ASSUME_NONNULL_END

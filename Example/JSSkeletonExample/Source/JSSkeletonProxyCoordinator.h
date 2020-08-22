//
//  JSSkeletonProxyCoordinator.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSkeletonLayoutView;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyCoordinator : NSObject

@property (nonatomic, weak) __kindof UIView *bindView;

- (BOOL)filterByRulesView:(__kindof UIView *)view;
- (void)enumerateLayoutViewUsingBlock:(void(NS_NOESCAPE ^)(JSSkeletonLayoutView *layoutView))block;
- (void)start;
- (void)end;

@end

NS_ASSUME_NONNULL_END

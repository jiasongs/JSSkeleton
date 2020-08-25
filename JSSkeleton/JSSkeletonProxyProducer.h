//
//  JSSkeletonProxyProducer.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/23.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSkeletonLayoutView;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyProducer : NSObject

@property (nonatomic, strong, readonly) NSPointerArray *layoutViews;

- (NSArray<__kindof JSSkeletonLayoutView *> *)produceLayoutViewWithViews:(NSArray<__kindof UIView *> *)views;
- (BOOL)filterByRulesView:(__kindof UIView *)view;

@end

NS_ASSUME_NONNULL_END

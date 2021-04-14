//
//  JSSkeletonProxyCoordinator.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSSkeletonProxyView;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyCoordinator : NSObject

@property (nonatomic, weak, readonly) __kindof JSSkeletonProxyView *proxyView;

- (instancetype)initWithProxyView:(__kindof JSSkeletonProxyView *)proxyView;

- (BOOL)start;
- (BOOL)end;

@end

NS_ASSUME_NONNULL_END

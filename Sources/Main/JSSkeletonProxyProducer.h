//
//  JSSkeletonProxyProducer.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/23.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSSkeletonLayoutLayer;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyProducer : NSObject

@property (nonatomic, readonly) NSArray<JSSkeletonLayoutLayer *> *layoutLayers;

- (NSArray<JSSkeletonLayoutLayer *> *)produceLayoutLayerWithViews:(NSArray<__kindof UIView *> *)views;

- (void)addLayoutLayer:(JSSkeletonLayoutLayer *)layoutLayer;

- (void)enumerateLayoutLayersUsingBlock:(void (NS_NOESCAPE ^)(JSSkeletonLayoutLayer *layoutLayer, NSUInteger idx))block;

@end

NS_ASSUME_NONNULL_END

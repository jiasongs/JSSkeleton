//
//  JSSkeletonProxyView.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSkeletonLayoutView;
@class JSSkeletonProxyProducer;
@class JSSkeletonProxyCoordinator;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyView : UIView

@property (nonatomic, weak, readonly) __kindof UIView *registerView;
@property (nonatomic, weak, readonly, nullable) __kindof UIView *targetView; /// 需要模仿的视图
@property (nonatomic, strong, readwrite) __kindof JSSkeletonProxyProducer *producer;
@property (nonatomic, strong, readwrite) __kindof JSSkeletonProxyCoordinator *coordinator;

- (instancetype)initWithRegisterView:(__kindof UIView *)registerView targetView:(nullable __kindof UIView *)targetView NS_REQUIRES_SUPER;
- (void)didInitialize NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END

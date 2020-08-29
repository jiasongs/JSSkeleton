//
//  JSSkeletonConfig.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JSSkeletonAnimationProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonConfig : NSObject

@property (nonatomic, assign) CGFloat skeletonHeightCoefficient;
@property (nonatomic, assign) CGFloat skeletonLineSpacing;
@property (nonatomic, copy, nullable) UIColor *skeletonTintColor;
@property (nonatomic, copy, nullable) UIColor *skeletonBackgroundColor;
@property (nonatomic, strong, nullable) id<JSSkeletonAnimationProtocol> skeletonAnimation;

+ (instancetype)sharedConfig;

@end

NS_ASSUME_NONNULL_END

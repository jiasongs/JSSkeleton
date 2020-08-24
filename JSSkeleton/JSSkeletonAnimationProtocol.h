//
//  JSSkeletonAnimationProtocol.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSkeletonLayoutView;

NS_ASSUME_NONNULL_BEGIN

@protocol JSSkeletonAnimationProtocol

@required
- (void)addAnimationWithLayoutView:(JSSkeletonLayoutView *)layoutView;
- (void)removeAnimationWithLayoutView:(JSSkeletonLayoutView *)layoutView;

@end

NS_ASSUME_NONNULL_END

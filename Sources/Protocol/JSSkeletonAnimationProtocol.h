//
//  JSSkeletonAnimationProtocol.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSkeletonLayoutLayer;

NS_ASSUME_NONNULL_BEGIN

@protocol JSSkeletonAnimationProtocol

@required
- (void)addAnimationWithLayoutLayer:(JSSkeletonLayoutLayer *)layoutLayer;
- (void)removeAnimationWithLayoutLayer:(JSSkeletonLayoutLayer *)layoutLayer;

@end

NS_ASSUME_NONNULL_END

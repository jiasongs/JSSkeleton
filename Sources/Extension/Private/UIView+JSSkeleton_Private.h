//
//  UIView+JSSkeleton_Private.h
//  JSSkeleton
//
//  Created by jiasong on 2021/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JSSkeleton_Private)

@property (nonatomic, copy, nullable) void(^js_skeletonLayoutSubviewsBlock)(__kindof UIView *view);

@end

NS_ASSUME_NONNULL_END

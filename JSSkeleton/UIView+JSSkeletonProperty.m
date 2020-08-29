//
//  UIView+JSSkeletonProperty.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonDefines.h"
#import "JSSkeletonLayoutView.h"

@interface UIView (__JSSkeletonProperty)

@property (nonatomic, strong) NSPointerArray *js_weakSkeletonLayoutViews;

@end

@implementation UIView (JSSkeletonProperty)

#pragma mark - 初始化属性

JSSynthesizeBOOLProperty(js_skeletonInvalid, setJs_skeletonInvalid)
JSSynthesizeBOOLProperty(js_skeletonDisplay, setJs_skeletonDisplay)
JSSynthesizeCGFloatProperty(js_skeletonMarginTop, setJs_skeletonMarginTop)
JSSynthesizeCGFloatProperty(js_skeletonMarginLeft, setJs_skeletonMarginLeft)
JSSynthesizeCGFloatProperty(js_skeletonWidth, setJs_skeletonWidth)
JSSynthesizeCGFloatProperty(js_skeletonHeight, setJs_skeletonHeight)
JSSynthesizeCGFloatProperty(js_skeletonHeightCoefficient, setJs_skeletonHeightCoefficient)
JSSynthesizeCGFloatProperty(js_skeletonLineSpacing, setJs_skeletonLineSpacing)
JSSynthesizeCGFloatProperty(js_skeletonCornerRadius, setJs_skeletonCornerRadius)
JSSynthesizeIdStrongProperty(js_skeletonAnimation, setJs_skeletonAnimation)
JSSynthesizeIdStrongProperty(js_weakSkeletonLayoutViews, setJs_weakSkeletonLayoutViews)

#pragma mark - TintColor

- (UIColor *)js_skeletonTintColor {
    return (UIColor *)objc_getAssociatedObject(self, _cmd);
}

- (void)setJs_skeletonTintColor:(UIColor *)js_skeletonTintColor {
    objc_setAssociatedObject(self, @selector(js_skeletonTintColor), js_skeletonTintColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    for (JSSkeletonLayoutView *layoutView in self.js_skeletonLayoutViews) {
        [layoutView setBackgroundColor:js_skeletonTintColor];
    }
}

#pragma mark - LayoutViews

- (NSArray<JSSkeletonLayoutView *> *)js_skeletonLayoutViews {
    NSMutableArray *result = [NSMutableArray array];
    for (JSSkeletonLayoutView *layoutView in self.js_weakSkeletonLayoutViews) {
        if (layoutView && [layoutView isKindOfClass:JSSkeletonLayoutView.class]) {
            [result addObject:layoutView];
        }
    }
    return result;
}

- (void)js_addSkeletonLayoutView:(JSSkeletonLayoutView *)layoutView {
    if (!self.js_weakSkeletonLayoutViews) {
        self.js_weakSkeletonLayoutViews = [NSPointerArray weakObjectsPointerArray];
    }
    [self.js_weakSkeletonLayoutViews addPointer:(__bridge void *)(layoutView)];
}

#pragma mark - Layout

- (void)js_skeletonLayoutIfNeeded {
    for (JSSkeletonLayoutView *layoutView in self.js_skeletonLayoutViews) {
        [layoutView updateLayoutIfNeeded];
    }
}

@end

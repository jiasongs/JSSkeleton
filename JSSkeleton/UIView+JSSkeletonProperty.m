//
//  UIView+JSSkeletonProperty.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonDefines.h"

@interface UIView (__JSSkeletonProperty)

@property (nonatomic, strong) NSPointerArray *js_weakSkeletonLayoutViews;

@end

@implementation UIView (JSSkeletonProperty)

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
JSSynthesizeIdCopyProperty(js_skeletonTintColor, setJs_skeletonTintColor)
JSSynthesizeIdStrongProperty(js_weakSkeletonLayoutViews, setJs_weakSkeletonLayoutViews)

- (NSArray<JSSkeletonLayoutView *> *)js_skeletonLayoutViews {
    return self.js_weakSkeletonLayoutViews.allObjects;
}

- (void)js_addSkeletonLayoutView:(JSSkeletonLayoutView *)layoutView {
    if (!self.js_weakSkeletonLayoutViews) {
        self.js_weakSkeletonLayoutViews = [NSPointerArray weakObjectsPointerArray];
    }
    [self.js_weakSkeletonLayoutViews addPointer:(__bridge void *)(layoutView)];
}

@end

//
//  UIView+JSSkeletonProperty.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonDefines.h"

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
JSSynthesizeIdWeakProperty(js_skeletonLayoutView, setJs_skeletonLayoutView)

@end

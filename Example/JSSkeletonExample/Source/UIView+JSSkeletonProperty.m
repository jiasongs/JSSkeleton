//
//  UIView+JSSkeletonProperty.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeletonProperty.h"

@implementation UIView (JSSkeletonProperty)

QMUISynthesizeBOOLProperty(js_skeletonInvalid, setJs_skeletonInvalid)
QMUISynthesizeBOOLProperty(js_skeletonDisplay, setJs_skeletonDisplay)
QMUISynthesizeCGFloatProperty(js_skeletonMarginTop, setJs_skeletonMarginTop)
QMUISynthesizeCGFloatProperty(js_skeletonMarginLeft, setJs_skeletonMarginLeft)
QMUISynthesizeCGFloatProperty(js_skeletonWidth, setJs_skeletonWidth)
QMUISynthesizeCGFloatProperty(js_skeletonHeight, setJs_skeletonHeight)
QMUISynthesizeCGFloatProperty(js_skeletonHeightCoefficient, setJs_skeletonHeightCoefficient)
QMUISynthesizeIdStrongProperty(js_skeletonAnimation, setJs_skeletonAnimation)
QMUISynthesizeIdCopyProperty(js_skeletonTintColor, setJs_skeletonTintColor)
QMUISynthesizeIdWeakProperty(js_skeletonLayoutView, setJs_skeletonLayoutView)

@end

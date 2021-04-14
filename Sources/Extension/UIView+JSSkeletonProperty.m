//
//  UIView+JSSkeletonProperty.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeletonProperty.h"
#import "UIView+JSSkeleton_Private.h"
#import "JSCoreKit.h"
#import "JSSkeletonLayoutLayer.h"

@interface UIView (__JSSkeletonProperty)

@property (nonatomic, strong) NSPointerArray *js_weakSkeletonLayoutLayers;

@end

@implementation UIView (JSSkeletonProperty)

#pragma mark - 初始化属性

JSSynthesizeBOOLProperty(js_skeletonInvalid, setJs_skeletonInvalid)
JSSynthesizeCGFloatProperty(js_skeletonMarginTop, setJs_skeletonMarginTop)
JSSynthesizeCGFloatProperty(js_skeletonMarginLeft, setJs_skeletonMarginLeft)
JSSynthesizeCGFloatProperty(js_skeletonWidth, setJs_skeletonWidth)
JSSynthesizeCGFloatProperty(js_skeletonHeight, setJs_skeletonHeight)
JSSynthesizeCGFloatProperty(js_skeletonHeightCoefficient, setJs_skeletonHeightCoefficient)
JSSynthesizeCGFloatProperty(js_skeletonLineSpacing, setJs_skeletonLineSpacing)
JSSynthesizeCGFloatProperty(js_skeletonCornerRadius, setJs_skeletonCornerRadius)
JSSynthesizeIdStrongProperty(js_skeletonAnimation, setJs_skeletonAnimation)
JSSynthesizeIdStrongProperty(js_weakSkeletonLayoutLayers, setJs_weakSkeletonLayoutLayers)

#pragma mark - LayoutSubviews

- (void (^)(__kindof UIView *, CGRect))js_skeletonLayoutSubviewsBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setJs_skeletonLayoutSubviewsBlock:(void (^)(__kindof UIView *))js_skeletonLayoutSubviewsBlock {
    [self js_skeletonHookLayoutSubviewsIfNeeded];
    objc_setAssociatedObject(self, @selector(js_skeletonLayoutSubviewsBlock), js_skeletonLayoutSubviewsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - TintColor

- (UIColor *)js_skeletonTintColor {
    return (UIColor *)objc_getAssociatedObject(self, _cmd);
}

- (void)setJs_skeletonTintColor:(UIColor *)js_skeletonTintColor {
    objc_setAssociatedObject(self, @selector(js_skeletonTintColor), js_skeletonTintColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    for (JSSkeletonLayoutLayer *layoutLayer in self.js_skeletonLayoutLayers) {
        layoutLayer.backgroundColor = js_skeletonTintColor.CGColor;
    }
}

#pragma mark - SkeletonClear

- (BOOL)js_skeletonClear {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setJs_skeletonClear:(BOOL)js_skeletonClear {
    objc_setAssociatedObject(self, @selector(js_skeletonClear), @(js_skeletonClear), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (js_skeletonClear) {
        for (JSSkeletonLayoutLayer *layoutLayer in self.js_skeletonLayoutLayers) {
            layoutLayer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor;
        }
    }
}

#pragma mark - LayoutLayers

- (NSArray<JSSkeletonLayoutLayer *> *)js_skeletonLayoutLayers {
    NSMutableArray *result = [NSMutableArray array];
    for (JSSkeletonLayoutLayer *layoutLayer in self.js_weakSkeletonLayoutLayers) {
        if (layoutLayer && [layoutLayer isKindOfClass:JSSkeletonLayoutLayer.class]) {
            [result addObject:layoutLayer];
        }
    }
    return result;
}

- (void)js_addSkeletonLayoutLayer:(JSSkeletonLayoutLayer *)layoutLayer {
    if (!self.js_weakSkeletonLayoutLayers) {
        self.js_weakSkeletonLayoutLayers = [NSPointerArray weakObjectsPointerArray];
    }
    [self.js_weakSkeletonLayoutLayers addPointer:(__bridge void *)(layoutLayer)];
}

#pragma mark - Layout

- (void)js_skeletonUpdateLayoutIfNeeded {
    for (JSSkeletonLayoutLayer *layoutLayer in self.js_skeletonLayoutLayers) {
        [layoutLayer updateLayoutIfNeeded];
    }
}

#pragma mark - Hook

- (void)js_skeletonHookLayoutSubviewsIfNeeded {
    Class viewClass = self.class;
    [JSCoreHelper executeOnceWithIdentifier:[NSString stringWithFormat:@"UIView %@-%@", NSStringFromClass(viewClass), @"JSSkeletonHook"] usingBlock:^{
        JSRuntimeOverrideImplementation(viewClass, @selector(layoutSubviews), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject) {
                // call super
                void (*originSelectorIMP)(id, SEL);
                originSelectorIMP = (void (*)(id, SEL))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD);
                
                if (selfObject.js_skeletonLayoutSubviewsBlock && [selfObject isMemberOfClass:viewClass]) {
                    selfObject.js_skeletonLayoutSubviewsBlock(selfObject);
                }
            };
        });
    }];
}

@end

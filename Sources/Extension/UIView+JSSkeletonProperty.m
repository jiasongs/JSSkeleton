//
//  UIView+JSSkeletonProperty.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeletonProperty.h"
#import "JSCoreKit.h"
#import "JSSkeletonLayoutView.h"

@interface UIView (__JSSkeletonProperty)

@property (nonatomic, strong) NSPointerArray *js_weakSkeletonLayoutViews;

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
JSSynthesizeIdStrongProperty(js_weakSkeletonLayoutViews, setJs_weakSkeletonLayoutViews)

#pragma mark - FrameDidChangeBlock

- (void (^)(__kindof UIView *, CGRect))js_skeletonFrameDidChange {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setJs_skeletonFrameDidChange:(void (^)(__kindof UIView *, CGRect))js_skeletonFrameDidChange {
    [self js_skeletonHookFrameIfNeeded];
    objc_setAssociatedObject(self, @selector(js_skeletonFrameDidChange), js_skeletonFrameDidChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

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

#pragma mark - SkeletonClear

- (BOOL)js_skeletonClear {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setJs_skeletonClear:(BOOL)js_skeletonClear {
    objc_setAssociatedObject(self, @selector(js_skeletonClear), @(js_skeletonClear), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (js_skeletonClear) {
        for (JSSkeletonLayoutView *layoutView in self.js_skeletonLayoutViews) {
            [layoutView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
        }
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

- (void)js_skeletonUpdateLayoutIfNeeded {
    for (JSSkeletonLayoutView *layoutView in self.js_skeletonLayoutViews) {
        [layoutView updateLayoutIfNeeded];
    }
}

#pragma mark - Hook

- (void)js_skeletonHookFrameIfNeeded {
    Class viewClass = self.class;
    [JSCoreHelper executeOnceWithIdentifier:[NSString stringWithFormat:@"UIView %@-%@", NSStringFromClass(viewClass), @"JSSkeletonHook"] usingBlock:^{
        JSRuntimeOverrideImplementation(viewClass, @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGRect frame) {
                
                CGRect precedingFrame = selfObject.frame;
                BOOL valueChange = !CGRectEqualToRect(frame, precedingFrame);
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGRect);
                originSelectorIMP = (void (*)(id, SEL, CGRect))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, frame);
                
                if (selfObject.js_skeletonFrameDidChange && valueChange) {
                    selfObject.js_skeletonFrameDidChange(selfObject, precedingFrame);
                }
            };
        });
        
        JSRuntimeOverrideImplementation(viewClass, @selector(setBounds:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGRect bounds) {
                
                CGRect precedingFrame = selfObject.frame;
                CGRect precedingBounds = selfObject.bounds;
                BOOL valueChange = !CGSizeEqualToSize(bounds.size, precedingBounds.size);// bounds 只有 size 发生变化才会影响 frame
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGRect);
                originSelectorIMP = (void (*)(id, SEL, CGRect))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, bounds);
                
                if (selfObject.js_skeletonFrameDidChange && valueChange) {
                    selfObject.js_skeletonFrameDidChange(selfObject, precedingFrame);
                }
            };
        });
        
        JSRuntimeOverrideImplementation(viewClass, @selector(setCenter:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGPoint center) {
                
                CGRect precedingFrame = selfObject.frame;
                CGPoint precedingCenter = selfObject.center;
                BOOL valueChange = !CGPointEqualToPoint(center, precedingCenter);
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGPoint);
                originSelectorIMP = (void (*)(id, SEL, CGPoint))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, center);
                
                if (selfObject.js_skeletonFrameDidChange && valueChange) {
                    selfObject.js_skeletonFrameDidChange(selfObject, precedingFrame);
                }
            };
        });
        
        JSRuntimeOverrideImplementation(viewClass, @selector(setTransform:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGAffineTransform transform) {
                
                CGRect precedingFrame = selfObject.frame;
                CGAffineTransform precedingTransform = selfObject.transform;
                BOOL valueChange = !CGAffineTransformEqualToTransform(transform, precedingTransform);
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGAffineTransform);
                originSelectorIMP = (void (*)(id, SEL, CGAffineTransform))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, transform);
                
                if (selfObject.js_skeletonFrameDidChange && valueChange) {
                    selfObject.js_skeletonFrameDidChange(selfObject, precedingFrame);
                }
            };
        });
    }];
}

@end

//
//  UIView+JSSkeletonExtension.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/24.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "UIView+JSSkeletonExtension.h"
#import "JSSkeletonDefines.h"

@implementation UIView (JSSkeletonExtension)

JSSynthesizeIdCopyProperty(js_frameDidChangeBlock, setJs_frameDidChangeBlock)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JSOverrideImplementation([UIView class], @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGRect frame) {
                
                CGRect precedingFrame = selfObject.frame;
                BOOL valueChange = !CGRectEqualToRect(frame, precedingFrame);
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGRect);
                originSelectorIMP = (void (*)(id, SEL, CGRect))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, frame);
                
                if (selfObject.js_frameDidChangeBlock && valueChange) {
                    selfObject.js_frameDidChangeBlock(selfObject, precedingFrame);
                }
            };
        });
        
        JSOverrideImplementation([UIView class], @selector(setBounds:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGRect bounds) {
                
                CGRect precedingFrame = selfObject.frame;
                CGRect precedingBounds = selfObject.bounds;
                BOOL valueChange = !CGSizeEqualToSize(bounds.size, precedingBounds.size);// bounds 只有 size 发生变化才会影响 frame
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGRect);
                originSelectorIMP = (void (*)(id, SEL, CGRect))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, bounds);
                
                if (selfObject.js_frameDidChangeBlock && valueChange) {
                    selfObject.js_frameDidChangeBlock(selfObject, precedingFrame);
                }
            };
        });
        
        JSOverrideImplementation([UIView class], @selector(setCenter:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGPoint center) {
                
                CGRect precedingFrame = selfObject.frame;
                CGPoint precedingCenter = selfObject.center;
                BOOL valueChange = !CGPointEqualToPoint(center, precedingCenter);
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGPoint);
                originSelectorIMP = (void (*)(id, SEL, CGPoint))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, center);
                
                if (selfObject.js_frameDidChangeBlock && valueChange) {
                    selfObject.js_frameDidChangeBlock(selfObject, precedingFrame);
                }
            };
        });
        
        JSOverrideImplementation([UIView class], @selector(setTransform:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CGAffineTransform transform) {
                
                CGRect precedingFrame = selfObject.frame;
                CGAffineTransform precedingTransform = selfObject.transform;
                BOOL valueChange = !CGAffineTransformEqualToTransform(transform, precedingTransform);
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGAffineTransform);
                originSelectorIMP = (void (*)(id, SEL, CGAffineTransform))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, transform);
                
                if (selfObject.js_frameDidChangeBlock && valueChange) {
                    selfObject.js_frameDidChangeBlock(selfObject, precedingFrame);
                }
            };
        });
    });
}

- (CGFloat)js_top {
    return CGRectGetMinY(self.frame);
}

- (void)setJs_top:(CGFloat)top {
    CGRect rect = self.frame;
    rect.origin.y = JSFlat(top);
    self.frame = rect;
}

- (CGFloat)js_left {
    return CGRectGetMinX(self.frame);
}

- (void)setJs_left:(CGFloat)left {
    CGRect rect = self.frame;
    rect.origin.x = JSFlat(left);
    self.frame = rect;
}

- (CGFloat)js_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setJs_bottom:(CGFloat)bottom {
    CGRect rect = self.frame;
    rect.origin.y = JSFlat(bottom - CGRectGetHeight(self.frame));
    self.frame = rect;
}

- (CGFloat)js_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setJs_right:(CGFloat)right {
    CGRect rect = self.frame;
    rect.origin.x = JSFlat(right - CGRectGetWidth(self.frame));
    self.frame = rect;
}

- (CGFloat)js_width {
    return CGRectGetWidth(self.frame);
}

- (void)setJs_width:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = JSFlat(width);
    self.frame = rect;
}

- (CGFloat)js_height {
    return CGRectGetHeight(self.frame);
}

- (void)setJs_height:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = JSFlat(height);
    self.frame = rect;
}

@end

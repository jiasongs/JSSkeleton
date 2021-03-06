//
//  JSSkeletonLayoutView.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonLayoutView.h"
#import "JSCoreKit.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonAppearance.h"
#import "JSSkeletonAnimationProtocol.h"

@interface JSSkeletonLayoutView ()

@property (nonatomic, assign) BOOL fromMultiLineLabel;
@property (nonatomic, assign, readonly) NSUInteger numberOfLinesForSimulateView;

@end

@implementation JSSkeletonLayoutView

- (instancetype)initWithSimulateView:(__kindof UIView *)simulateView {
    return [self initWithSimulateView:simulateView fromMultiLineLabel:false];
}

- (instancetype)initWithSimulateView:(__kindof UIView *)simulateView fromMultiLineLabel:(BOOL)fromMultiLineLabel {
    if (self = [super initWithFrame:CGRectZero]) {
        _simulateView = simulateView;
        _fromMultiLineLabel = fromMultiLineLabel;
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    if ([_simulateView isKindOfClass:UILabel.class]) {
        _simulateType = JSSkeletonLayoutSimulateLabel;
    } else {
        _simulateType = JSSkeletonLayoutSimulateView;
    }
    /// 圆角
    CGFloat cornerRadius = self.simulateView.js_skeletonCornerRadius ? : self.simulateView.layer.cornerRadius;
    if (cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
    }
    /// 多行Label
    if (self.numberOfLinesForSimulateView > 1) {
        for (int i = 0; i < self.numberOfLinesForSimulateView; i++) {
            [self addSubview:[[self.class alloc] initWithSimulateView:self.simulateView
                                                   fromMultiLineLabel:true]];
        }
    } else {
        self.backgroundColor = self.simulateView.js_skeletonTintColor ? : JSSkeletonAppearance.appearance.skeletonTintColor;
    }
    /// 更新一次布局
    [self updateLayoutIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    UIColor *tintColor = backgroundColor;
    if (self.simulateView.js_skeletonClear) {
        tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    }
    if (self.numberOfLinesForSimulateView > 1) {
        for (__kindof UIView *view in self.subviews) {
            if ([view isKindOfClass:self.class]) {
                [view setBackgroundColor:tintColor];
            }
        }
    } else {
        [super setBackgroundColor:tintColor];
    }
}

#pragma mark - 布局

- (void)updateLayoutIfNeeded {
    CGFloat heightCoefficient = self.js_skeletonHeightCoefficient ? : (self.simulateType == JSSkeletonLayoutSimulateLabel ? JSSkeletonAppearance.appearance.skeletonHeightCoefficient : 1);
    CGFloat x = self.simulateView.js_left + self.simulateView.js_skeletonMarginLeft;
    CGFloat y = self.simulateView.js_top + self.simulateView.js_skeletonMarginTop;
    CGFloat width = self.simulateView.js_skeletonWidth ? : self.simulateView.js_width;
    CGFloat height = self.simulateView.js_skeletonHeight ? : self.simulateView.js_height * heightCoefficient;
    if (height == 0 && self.simulateType == JSSkeletonLayoutSimulateLabel) {
        __kindof UILabel *label = self.simulateView;
        height = label.font.lineHeight * heightCoefficient;
    }
    if (self.numberOfLinesForSimulateView > 1) {
        CGFloat lineSpacing = self.simulateView.js_skeletonLineSpacing ? : JSSkeletonAppearance.appearance.skeletonLineSpacing;
        CGFloat averageWidth = width / self.numberOfLinesForSimulateView;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *view, NSUInteger idx, BOOL *stop) {
            if ([view isKindOfClass:self.class]) {
                view.frame = CGRectMake(0, idx * (height + lineSpacing), width - idx * averageWidth, height);
            }
        }];
        height = self.subviews.lastObject.js_bottom;
    }
    self.frame = CGRectMake(x, y, width, height);
}

#pragma mark - 开启动画

- (void)startAnimation {
    [self.simulateView.js_skeletonAnimation addAnimationWithLayoutView:self];
}

- (void)endAnimation {
    [self.simulateView.js_skeletonAnimation removeAnimationWithLayoutView:self];
}

#pragma mark - getter

- (NSUInteger)numberOfLinesForSimulateView {
    NSUInteger numberOfLines = 1;
    if (!self.fromMultiLineLabel && self.simulateType == JSSkeletonLayoutSimulateLabel) {
        __kindof UILabel *simulateLabel = self.simulateView;
        if (simulateLabel.numberOfLines != 1) {
            numberOfLines = simulateLabel.numberOfLines ? : 3;
        }
    }
    return numberOfLines;
}

@end

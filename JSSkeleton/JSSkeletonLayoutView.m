//
//  JSSkeletonLayoutView.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonLayoutView.h"
#import "UIView+JSSkeletonProperty.h"
#import "UIView+JSSkeletonExtension.h"
#import "JSSkeletonConfig.h"
#import "JSSkeletonAnimationProtocol.h"

@interface JSSkeletonLayoutView ()

@property (nonatomic, assign) BOOL forceSingleLine;
@property (nonatomic, assign, readonly) NSUInteger numberOfLinesForSimulateView;

@end

@implementation JSSkeletonLayoutView

- (instancetype)initWithSimulateView:(__kindof UIView *)simulateView {
    return [self initWithSimulateView:simulateView forceSingleLine:false];
}

- (instancetype)initWithSimulateView:(__kindof UIView *)simulateView forceSingleLine:(BOOL)forceSingleLine {
    if (self = [super initWithFrame:CGRectZero]) {
        _simulateView = simulateView;
        if ([_simulateView isKindOfClass:UILabel.class]) {
            _simulateType = JSSkeletonLayoutSimulateLabel;
        } else {
            _simulateType = JSSkeletonLayoutSimulateView;
        }
        _forceSingleLine = forceSingleLine;
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    CGFloat cornerRadius = self.simulateView.js_skeletonCornerRadius ? : self.simulateView.layer.cornerRadius;
    if (cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
    }
    if (self.numberOfLinesForSimulateView > 1) {
        for (int i = 0; i < self.numberOfLinesForSimulateView; i++) {
            [self addSubview:[[JSSkeletonLayoutView alloc] initWithSimulateView:self.simulateView forceSingleLine:true]];
        }
    } else {
        if (self.simulateView.js_skeletonTintColor) {
            self.backgroundColor = self.simulateView.js_skeletonTintColor;
        } else {
            self.backgroundColor = JSSkeletonConfig.sharedConfig.skeletonTintColor;
        }
    }
    /// 必须更新一次布局
    [self updateLayout];
}

#pragma mark - 布局

- (void)updateLayout {
    CGFloat heightCoefficient = self.js_skeletonHeightCoefficient ? : (self.simulateType == JSSkeletonLayoutSimulateLabel ? JSSkeletonConfig.sharedConfig.skeletonHeightCoefficient : 1);
    CGFloat x = self.simulateView.js_left + self.simulateView.js_skeletonMarginTop;
    CGFloat y = self.simulateView.js_top + self.simulateView.js_skeletonMarginLeft;
    CGFloat width = self.simulateView.js_skeletonWidth ? : self.simulateView.js_width;
    CGFloat height = self.simulateView.js_skeletonHeight ? : self.simulateView.js_height * heightCoefficient;
    if (height == 0 && self.simulateType == JSSkeletonLayoutSimulateLabel) {
        __kindof UILabel *label = self.simulateView;
        height = label.font.lineHeight * heightCoefficient;
    }
    if (self.numberOfLinesForSimulateView > 1) {
        CGFloat lineSpacing = self.simulateView.js_skeletonLineSpacing ? : JSSkeletonConfig.sharedConfig.skeletonLineSpacing;
        CGFloat averageWidth = width / self.numberOfLinesForSimulateView;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *view, NSUInteger idx, BOOL *stop) {
            if ([view isKindOfClass:JSSkeletonLayoutView.class]) {
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
    if (!self.forceSingleLine && self.simulateType == JSSkeletonLayoutSimulateLabel) {
        __kindof UILabel *simulateLabel = self.simulateView;
        if (simulateLabel.numberOfLines != 1) {
            numberOfLines = simulateLabel.numberOfLines ? : 3;
        }
    }
    return numberOfLines;
}

@end

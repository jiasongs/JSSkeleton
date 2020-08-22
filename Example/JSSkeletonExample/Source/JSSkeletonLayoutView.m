//
//  JSSkeletonLayoutView.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonLayoutView.h"
#import "UIView+JSSkeletonProperty.h"
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
    self.qmui_shouldShowDebugColor = false;
    if (self.simulateView.js_skeletonTintColor) {
        self.backgroundColor = self.simulateView.js_skeletonTintColor;
    } else {
        self.backgroundColor = UIColorMakeWithHex(@"#dbdbdb");
    }
    if (self.numberOfLinesForSimulateView > 1) {
        self.backgroundColor = nil;
        for (int i = 0; i < self.numberOfLinesForSimulateView; i++) {
            [self addSubview:[[JSSkeletonLayoutView alloc] initWithSimulateView:self.simulateView forceSingleLine:true]];
        }
    }
}

#pragma mark - 布局

- (void)updateLayout {
    CGFloat heightCoefficient = self.js_skeletonHeightCoefficient ? : (self.simulateType == JSSkeletonLayoutSimulateLabel ? 0.75 : 1);
    CGFloat x = CGRectGetMinX(self.simulateView.frame) + self.simulateView.js_skeletonMarginTop;
    CGFloat y = CGRectGetMinY(self.simulateView.frame) + self.simulateView.js_skeletonMarginLeft;
    CGFloat width = self.simulateView.js_skeletonWidth ? : CGRectGetWidth(self.simulateView.frame);
    CGFloat height = self.simulateView.js_skeletonHeight ? : CGRectGetHeight(self.simulateView.frame) * heightCoefficient;
    if (self.numberOfLinesForSimulateView > 1) {
        [self.subviews enumerateObjectsUsingBlock:^(JSSkeletonLayoutView *view, NSUInteger idx, BOOL *stop) {
            if ([view isKindOfClass:JSSkeletonLayoutView.class]) {
                CGFloat subY = idx * height;
                if (idx > 0) {
                    subY = subY + idx * height;
                }
                CGFloat zoom = [[NSString stringWithFormat:@"0.%@", @(self.numberOfLinesForSimulateView)] floatValue];
                view.frame = CGRectMake(0, subY, width * (1 - idx * zoom), height);
            }
        }];
        height = height * self.numberOfLinesForSimulateView * (self.numberOfLinesForSimulateView - 1) - height;
    }
    self.frame = CGRectMake(x, y, width, height);
}

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

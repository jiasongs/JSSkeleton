//
//  JSSkeletonProxyTableViewCell.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyTableViewCell.h"
#import "JSSkeletonLayoutView.h"
#import "JSSkeletonBreathingAnimation.h"
#import "UIView+JSSkeletonProperty.h"

@implementation JSSkeletonProxyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier targetCellClass:(Class)cellClass {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        __kindof UITableViewCell *cell = nibPath ? [NSBundle.mainBundle loadNibNamed:NSStringFromClass(cellClass) owner:nil options:nil].firstObject : nil;
        if (!cell) {
            cell = [[cellClass alloc] initWithFrame:CGRectZero];
        }
        cell.hidden = true;
        [self addSubview:cell];
        for (__kindof UIView *subview in cell.contentView.subviews) {
            if ([self filterByRulesView:subview]) {
                if (!subview.js_skeletonAnimation) {
                    subview.js_skeletonAnimation = JSSkeletonBreathingAnimation.new;
                }
                JSSkeletonLayoutView *layoutView = [[JSSkeletonLayoutView alloc] initWithSimulateView:subview];
                [self.contentView addSubview:layoutView];
                subview.js_skeletonLayoutView = layoutView;
                subview.qmui_frameDidChangeBlock = ^(__kindof UIView *view, CGRect precedingFrame) {
                    [view.js_skeletonLayoutView updateLayout];
                };
            }
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (__kindof UIView *subview in self.subviews) {
        if ([subview isKindOfClass:UITableViewCell.class]) {
            subview.frame = self.bounds;
            break;
        }
    }
}

- (BOOL)filterByRulesView:(__kindof UIView *)view {
    BOOL needRemove = false;
    if ([view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]] ||
        [view isKindOfClass:[NSClassFromString(@"_UITableViewHeaderFooterContentView") class]] ||
        [view isKindOfClass:[NSClassFromString(@"_UITableViewHeaderFooterViewBackground") class]] ||
        [view isKindOfClass:[NSClassFromString(@"UITableViewLabel") class]]) {
        needRemove = true;
    }
    if ((!self.isHidden || !self.js_skeletonInvalid) && !needRemove) {
        return true;
    }
    return false;
}

@end

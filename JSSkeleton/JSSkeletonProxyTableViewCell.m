//
//  JSSkeletonProxyTableViewCell.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyTableViewCell.h"
#import "JSSkeletonLayoutView.h"
#import "UIView+JSSkeletonProperty.h"
#import "UIView+JSSkeleton.h"
#import "JSSkeletonProxyProducer.h"

@implementation JSSkeletonProxyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self didInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0];
    self.producer = [[JSSkeletonProxyProducer alloc] init];
}

- (void)produceLayoutViewWithTargetCell:(__kindof UITableViewCell *)targetCell {
    /// 只添加一次, 保证只存在于一个cell中, 减少内存
    if (!targetCell.superview) {
        targetCell.hidden = true;
        [self addSubview:targetCell];
    }
    if (targetCell.contentView.subviews.count > 0) {
        NSArray *layoutViews = [self.producer produceLayoutViewWithViews:targetCell.contentView.subviews];
        for (JSSkeletonLayoutView *layoutView in layoutViews) {
            [self.contentView addSubview:layoutView];
        }
    }
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

@end

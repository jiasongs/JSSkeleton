//
//  JSSkeletonProxyCollectionViewCell.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/26.
//

#import "JSSkeletonProxyCollectionViewCell.h"
#import "JSSkeletonLayoutLayer.h"
#import "UIView+JSSkeletonProperty.h"
#import "UIView+JSSkeleton.h"
#import "JSSkeletonProxyProducer.h"

@implementation JSSkeletonProxyCollectionViewCell

- (void)didInitialize {
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0];
    self.producer = [[JSSkeletonProxyProducer alloc] init];
}

- (void)produceLayoutLayerWithTargetCell:(__kindof UICollectionViewCell *)targetCell {
    /// 只添加一次, 保证只存在于一个cell中, 减少内存
    if (!targetCell.superview) {
        targetCell.hidden = YES;
        [self addSubview:targetCell];
    }
    if (targetCell.contentView.subviews.count > 0) {
        NSArray *layoutLayers = [self.producer produceLayoutLayerWithViews:targetCell.contentView.subviews];
        for (JSSkeletonLayoutLayer *layoutLayer in layoutLayers) {
            [self.contentView.layer addSublayer:layoutLayer];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (__kindof UIView *subview in self.subviews) {
        if ([subview isKindOfClass:UICollectionViewCell.class]) {
            subview.frame = self.bounds;
            break;
        }
    }
}

@end

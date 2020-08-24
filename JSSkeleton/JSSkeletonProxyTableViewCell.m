//
//  JSSkeletonProxyTableViewCell.m
//  JSSkeletonExample
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

- (instancetype)initWithTargetCellClass:(Class)cellClass {
    if (self = [super initWithFrame:CGRectZero]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self didInitializeWithCellClass:cellClass];
    }
    return self;
}

- (void)didInitializeWithCellClass:(Class)cellClass {
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
    __kindof UITableViewCell *cell = nibPath ? [NSBundle.mainBundle loadNibNamed:NSStringFromClass(cellClass) owner:nil options:nil].firstObject : nil;
    if (!cell) {
        cell = [[cellClass alloc] initWithFrame:CGRectZero];
    }
    cell.hidden = true;
    [self addSubview:cell];
    self.producer = [[JSSkeletonProxyProducer alloc] init];
    NSArray *layoutViews = [self.producer produceLayoutViewWithViews:cell.contentView.subviews];
    for (JSSkeletonLayoutView *layoutView in layoutViews) {
        [self.producer.layoutViews addPointer:(__bridge void *)(layoutView)];
        [self.contentView addSubview:layoutView];
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

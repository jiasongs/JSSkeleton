//
//  ITNewsDetailSkeletonView.m
//  ITHomeClient
//
//  Created by ruanmei on 2020/8/18.
//  Copyright © 2020 ruanmei. All rights reserved.
//

#import "ITNewsDetailSkeletonView.h"

@implementation ITNewsDetailSkeletonView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageContainerView.js_skeletonTintColor = UIColorClear;
}

@end

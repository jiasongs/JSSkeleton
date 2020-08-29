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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.imageContainerView.js_skeletonTintColor = UIColorBlue;
        self.contentLabel.js_skeletonTintColor = UIColorRed;
    });
}

@end

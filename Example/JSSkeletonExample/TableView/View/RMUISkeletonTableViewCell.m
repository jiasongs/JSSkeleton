//
//  RMUISkeletonTableViewCell.m
//  ITHomeClient
//
//  Created by jiasong on 2020/8/19.
//  Copyright © 2020 ruanmei. All rights reserved.
//

#import "RMUISkeletonTableViewCell.h"

@implementation RMUISkeletonTableViewCell


+ (CGFloat)skeletonHeight {
    return 0;
}

- (void)dealloc {
    NSLog(@"%@ - dealloc", NSStringFromClass(self.class));
}

@end

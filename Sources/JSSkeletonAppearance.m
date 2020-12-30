//
//  JSSkeletonAppearance.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonAppearance.h"
#import "JSSkeletonBreathingAnimation.h"

@implementation JSSkeletonAppearance

+ (instancetype)appearance {
    static dispatch_once_t onceToken;
    static JSSkeletonAppearance *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self appearance];
}

- (instancetype)init {
    if (self = [super init]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.skeletonHeightCoefficient = 0.55;
    self.skeletonLineSpacing = 8;
    self.skeletonTintColor = [UIColor colorWithRed:219 / 255.0 green:219 / 255.0 blue:219 / 255.0 alpha:1];
    self.skeletonBackgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
    self.skeletonAnimation = [[JSSkeletonBreathingAnimation alloc] init];
}

@end

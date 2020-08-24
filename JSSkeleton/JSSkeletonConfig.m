//
//  JSSkeletonConfig.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonConfig.h"
#import "JSSkeletonBreathingAnimation.h"

@implementation JSSkeletonConfig

+ (instancetype)sharedConfig {
    static dispatch_once_t onceToken;
    static JSSkeletonConfig *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedConfig];
}

- (instancetype)init {
    if (self = [super init]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.skeletonHeightCoefficient = 0.56;
    self.skeletonTintColor = [UIColor colorWithRed:219 / 255.0 green:219 / 255.0 blue:219 / 255.0 alpha:1];
    self.skeletonBackgroundColor = UIColor.whiteColor;
    self.skeletonAnimation = [[JSSkeletonBreathingAnimation alloc] init];
}

@end

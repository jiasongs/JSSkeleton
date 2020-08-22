//
//  JSSkeletonConfig.m
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonConfig.h"

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

@end

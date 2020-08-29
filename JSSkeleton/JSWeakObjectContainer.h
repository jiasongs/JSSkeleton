//
//  JSWeakObjectContainer.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/24.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSWeakObjectContainer : NSProxy

- (instancetype)initWithObject:(id)object;
+ (instancetype)containerWithObject:(id)object;

@property (nullable, nonatomic, weak) id object;

@end

NS_ASSUME_NONNULL_END

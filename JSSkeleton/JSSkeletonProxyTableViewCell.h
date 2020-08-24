//
//  JSSkeletonProxyTableViewCell.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSkeletonProxyProducer;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyTableViewCell : UITableViewCell

@property (nonatomic, strong, readwrite) JSSkeletonProxyProducer *producer;

- (instancetype)initWithTargetCellClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END

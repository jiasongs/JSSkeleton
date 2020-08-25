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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier targetCell:(__kindof UITableViewCell *)targetCell;

@end

NS_ASSUME_NONNULL_END

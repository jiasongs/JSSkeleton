//
//  JSSkeletonProxyTableViewCell.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier targetCellClass:(Class)cellClass;

- (void)start;
- (void)end;

@end

NS_ASSUME_NONNULL_END

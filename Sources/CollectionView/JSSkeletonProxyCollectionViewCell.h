//
//  JSSkeletonProxyCollectionViewCell.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/26.
//

#import <UIKit/UIKit.h>
@class JSSkeletonProxyProducer;

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readwrite) JSSkeletonProxyProducer *producer;

- (void)produceLayoutViewWithTargetCell:(__kindof UICollectionViewCell *)targetCell;

@end

NS_ASSUME_NONNULL_END

//
//  JSSkeletonProxyCollectionView.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/26.
//

#import "JSSkeletonProxyFormView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyCollectionView : JSSkeletonProxyFormView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END

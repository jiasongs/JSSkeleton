//
//  JSSkeletonProxyFormView.h
//  JSSkeleton
//
//  Created by jiasong on 2020/8/26.
//

#import "JSSkeletonProxyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyFormView : JSSkeletonProxyView

@property (nonatomic, assign) CGFloat numberOfSection;
@property (nonatomic, copy) NSArray<NSNumber *> *numberOfRows;
@property (nonatomic, copy) NSArray<NSNumber *> *heightForRows;
@property (nonatomic, copy) NSArray<__kindof UIView *> *targetCells;

- (void)registerCellClass:(NSArray<Class> *)cellClasss NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END

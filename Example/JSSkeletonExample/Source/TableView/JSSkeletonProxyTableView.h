//
//  JSSkeletonProxyTableView.h
//  JSSkeletonExample
//
//  Created by jiasong on 2020/8/22.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "JSSkeletonProxyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSSkeletonProxyTableView : JSSkeletonProxyView

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, assign) CGFloat numberOfSection;
@property (nonatomic, copy) NSArray<NSNumber *> *heightForRows;
@property (nonatomic, copy) NSArray<NSNumber *> *numberOfRows;

- (void)registerCellClass:(NSArray<Class> *)cellClasss;

@end

NS_ASSUME_NONNULL_END

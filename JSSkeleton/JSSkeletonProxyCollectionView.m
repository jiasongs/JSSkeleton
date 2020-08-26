//
//  JSSkeletonProxyCollectionView.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/26.
//

#import "JSSkeletonProxyCollectionView.h"
#import "JSSkeletonProxyCollectionViewCell.h"
#import "UIView+JSSkeletonProperty.h"
#import "JSSkeletonProxyProducer.h"
#import "JSSkeletonLayoutView.h"

NSString * const JSSkeletonProxyCollectionViewReuseIdentifier = @"JSSkeletonProxyCollectionViewReuseIdentifier_";

@interface JSSkeletonProxyCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;

@end

@implementation JSSkeletonProxyCollectionView

- (void)didInitialize {
    [super didInitialize];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark - 注册

- (void)registerCellClass:(NSArray<Class> *)cellClasss {
    [super registerCellClass:cellClasss];
    for (__kindof UICollectionViewCell *targetCell in self.targetCells) {
        NSString *identifier = [NSString stringWithFormat:@"%@%@", JSSkeletonProxyCollectionViewReuseIdentifier, NSStringFromClass(targetCell.class)];
        [self.collectionView registerClass:JSSkeletonProxyCollectionViewCell.class forCellWithReuseIdentifier:identifier];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(0, 0);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.numberOfSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.numberOfRows objectAtIndex:section] integerValue];
}

- (JSSkeletonProxyCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = nil;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

@end


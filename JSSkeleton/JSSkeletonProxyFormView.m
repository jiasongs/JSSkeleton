//
//  JSSkeletonProxyFormView.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/26.
//

#import "JSSkeletonProxyFormView.h"
#import "JSCoreKit.h"

@implementation JSSkeletonProxyFormView

- (void)registerCellClass:(NSArray<Class> *)cellClasss {
    self.numberOfSection = cellClasss.count;
    NSMutableArray *targetCells = [NSMutableArray array];
    NSMutableArray *numberOfRows = [NSMutableArray arrayWithArray:self.numberOfRows ? : @[]];
    for (int section = 0; section < self.numberOfSection; section++) {
        if (self.numberOfRows.count == 0) {
            CGFloat height = self.js_height ? : JSCoreHelper.applicationSize.height;
            [numberOfRows addObject:@(lrintf(height / [[self.heightForRows objectAtIndex:section] floatValue]))];
        }
        Class cellClass = [cellClasss objectAtIndex:section];
        NSString *nibPath = [[NSBundle bundleForClass:cellClass] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        __kindof UIView *targetCell = nibPath ? [[NSBundle bundleForClass:cellClass] loadNibNamed:NSStringFromClass(cellClass) owner:nil options:nil].firstObject : nil;
        if (!targetCell) {
            targetCell = [[cellClass alloc] initWithFrame:CGRectZero];
        }
        [targetCells addObject:targetCell];
    }
    self.numberOfRows = numberOfRows.copy;
    self.targetCells = targetCells.copy;
}

@end

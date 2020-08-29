//
//  ITNewsDetailSkeletonView.h
//  ITHomeClient
//
//  Created by ruanmei on 2020/8/18.
//  Copyright © 2020 ruanmei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITNewsDetailSkeletonView : UIView

@property (weak, nonatomic) IBOutlet UIView *centerMoreView;
@property (weak, nonatomic) IBOutlet UIView *centerMoreSubView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;

@end

NS_ASSUME_NONNULL_END

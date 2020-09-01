//
//  ITOfficialAccountHomepageHeaderView.h
//  ITHomeClient
//
//  Created by jiasong on 2020/9/1.
//  Copyright © 2020 ruanmei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITOfficialAccountHomepageHeaderView : UIView

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UIButton *articleCountButton;
@property (nonatomic, strong) UIButton *fansCountButton;

@end

NS_ASSUME_NONNULL_END

//
//  ITOfficialAccountHomepageHeaderView.m
//  ITHomeClient
//
//  Created by jiasong on 2020/9/1.
//  Copyright © 2020 ruanmei. All rights reserved.
//

#import "ITOfficialAccountHomepageHeaderView.h"

@implementation ITOfficialAccountHomepageHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    [self addSubview:self.headerImageView];
    [self addSubview:self.nameLabel];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(10);
        make.size.equalTo(@(CGSizeMake(100, 100)));
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_top).offset(10);
        make.left.equalTo(self.headerImageView.mas_right).offset(15);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /// 骨架屏
    self.nameLabel.js_skeletonWidth = (self.qmui_width - self.headerImageView.qmui_right) * 0.7;
    [self.nameLabel js_skeletonLayoutIfNeeded];
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 3;
    }
    return _nameLabel;
}

@end

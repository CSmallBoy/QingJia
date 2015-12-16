//
//  HCMoreCollectionViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCMoreCollectionViewCell.h"
#import "HCMoreInfo.h"

@interface HCMoreCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HCMoreCollectionViewCell

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(10, 0, WIDTH(self)-20, WIDTH(self)-20);
    self.titleLabel.frame = CGRectMake(0, MaxY(self.imgView)+5, WIDTH(self), 20);
}

#pragma mark - setter or getter

- (void)setInfo:(HCMoreInfo *)info
{
    _info = info;
    
    if (_info.isShow)
    {
        self.imgView.image = OrigIMG(info.imageName);
        self.titleLabel.text = info.title;
    }
}

- (UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


@end

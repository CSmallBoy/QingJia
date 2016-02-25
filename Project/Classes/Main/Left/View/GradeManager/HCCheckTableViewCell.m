//
//  HCCheckTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 16/2/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCheckTableViewCell.h"
#import "HCCheckInfo.h"

@interface HCCheckTableViewCell()

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *agreeBtn;

@end

@implementation HCCheckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.agreeBtn];
    }
    return self;
}

- (void)handleAgreeButton
{
    if ([self.delegate respondsToSelector:@selector(HCCheckTableViewCellSelectedModel:)])
    {
        [self.delegate HCCheckTableViewCellSelectedModel:_info];
    }
}

- (void)setInfo:(HCCheckInfo *)info
{
    self.headImgView.image = OrigIMG(info.imageName);
    self.titleLabel.text = info.nickName;
    self.detailLabel.text = info.detail;
}

- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 50, 50)];
        ViewRadius(_headImgView, 25);
    }
    return _headImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.headImgView)+10, 10, SCREEN_WIDTH-100, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DarkGrayColor;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.headImgView)+10, MaxY(self.titleLabel)+5, WIDTH(self.titleLabel), 20)];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = [UIColor grayColor];
    }
    return _detailLabel;
}

- (UIButton *)agreeBtn
{
    if (!_agreeBtn)
    {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(SCREEN_WIDTH-65, 15, 55, 30);
        [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        _agreeBtn.backgroundColor = kHCNavBarColor;
        [_agreeBtn addTarget:self action:@selector(handleAgreeButton) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_agreeBtn, 4);
    }
    return _agreeBtn;
}

@end

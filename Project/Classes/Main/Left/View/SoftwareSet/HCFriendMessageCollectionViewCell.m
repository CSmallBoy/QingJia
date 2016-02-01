//
//  HCFriendMessageCollectionViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFriendMessageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HCFriendMessageInfo.h"

@interface HCFriendMessageCollectionViewCell()

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *nickName;

@end

@implementation HCFriendMessageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.headImgView];
        [self addSubview:self.nickName];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.headImgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    ViewRadius(self.headImgView, self.frame.size.width*0.5);
    self.nickName.frame = CGRectMake(0, MaxY(self.headImgView)+5, self.frame.size.width, 20);
}
#pragma mark - setter or getter

- (void)setInfo:(HCFriendMessageInfo *)info
{
    _info = info;
    self.nickName.text = info.name;
    if ([info.uid integerValue])
    {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:info.imageName] placeholderImage:OrigIMG(@"2Dbarcode_message_HeadPortraits")];
    }else
    {
        self.headImgView.image = OrigIMG(info.imageName);
    }
}

- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [[UIImageView alloc] init];
    }
    return _headImgView;
}

- (UILabel *)nickName
{
    if (!_nickName)
    {
        _nickName = [[UILabel alloc] init];
        _nickName.textAlignment = NSTextAlignmentCenter;
        _nickName.font = [UIFont systemFontOfSize:15];
        _nickName.textColor = DarkGrayColor;
    }
    return _nickName;
}


@end

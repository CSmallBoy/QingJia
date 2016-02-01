//
//  HCAddFriendlistTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAddFriendlistTableViewCell.h"

@interface HCAddFriendlistTableViewCell ()

@property (nonatomic,strong) UIImageView *headerImgV;
@property (nonatomic,strong) UILabel *userLab;
@property (nonatomic,strong) UIButton *agreeBtn;

@end

@implementation HCAddFriendlistTableViewCell

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    
    [self.contentView addSubview:self.headerImgV];
    [self.contentView addSubview:self.userLab];
    [self.contentView addSubview:self.agreeBtn];
}

-(void)clickAgree
{
    [self.agreeBtn setTitle:@"不同意" forState:UIControlStateNormal];

    if ([self.delegate respondsToSelector:@selector(cliclAgreeBtn)])
    {
        [self.delegate cliclAgreeBtn];
    }
}

-(UIImageView *)headerImgV
{
    if (!_headerImgV)
    {
        _headerImgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 50, 50)];
        ViewRadius(_headerImgV, 25);
        _headerImgV.image = OrigIMG(@"chatListCellHead.png");
    }
    return _headerImgV;
}

-(UILabel *)userLab
{
    if (!_userLab)
    {
        _userLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, WIDTH(self.contentView)-160, 40)];
        _userLab.textAlignment = NSTextAlignmentLeft;
        _userLab.font = [UIFont systemFontOfSize:14];
        _userLab.text =@"名字";
    }
    return _userLab;
}

-(UIButton *)agreeBtn
{
    if (!_agreeBtn)
    {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(WIDTH(self.contentView)-80,20, 70, 30);
        _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_agreeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        ViewBorderRadius(_agreeBtn, 2, 1, LightGraryColor);
        [_agreeBtn addTarget:self action:@selector(clickAgree) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}
@end

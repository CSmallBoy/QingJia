//
//  HCGradeManagerTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGradeManagerTableViewCell.h"
#import "HCFriendMessageInfo.h"

#import "HCCreateGradeInfo.h"

@interface HCGradeManagerTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *codeImgView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation HCGradeManagerTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - private methods

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(HCGradeManagerTableViewCellSelectedTag:)])
    {
        [self.delegate HCGradeManagerTableViewCellSelectedTag:button.tag];
    }
}
//这个地方需要进行修改
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    if (indexPath.section == 0)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
        self.textField.enabled = NO;
        if (indexPath.row == 0)
        {
            self.titleLabel.text = @"名片";
            
            self.textField.placeholder = @"家庭二维码";
            [self.contentView addSubview:self.codeImgView];
        }else if (indexPath.row == 1)
        {
            self.titleLabel.text = @"祖籍";
            self.textField.text = _info.ancestralHome;
            self.textField.placeholder = @"请输入祖籍";
        }else if (indexPath.row == 2)
        {
            self.titleLabel.text = @"地址";
            self.textField.text = _info.contactAddr;
            self.textField.placeholder = @"请输入家庭地址";
        }
    }else
    {
        if (indexPath.row == 0)
        {
            self.titleLabel.text = [NSString stringWithFormat:@"家庭成员（%d）",_array.count];
            self.titleLabel.frame = CGRectMake(15, 10, 100, 24);
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.statusLabel];
        }else
        {
            [self.contentView removeAllSubviews];
            for (NSInteger i = 0; i < _array.count; i++)
            {
                HCFriendMessageInfo *info = _array[i];
                CGFloat width = SCREEN_WIDTH*0.17;
                CGFloat buttonX = i%4 *width + ((i%4+1)*20);
                CGFloat buttonY = i/4 *(width+20) + ((i/4+1)*10);
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(buttonX, buttonY, width, width);
                //[button setImage:_image forState:UIControlStateNormal];
                UIImageView *ima = [[UIImageView alloc]init];
                [ima sd_setImageWithURL:[readUserInfo url:info.imageName :kkUser]];
                [button setImage:ima.image forState:UIControlStateNormal];
                button.tag = i;
                [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
                ViewRadius(button, width/2);
                [self.contentView addSubview:button];
                
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, MaxY(button), button.frame.size.width, 20)];
                title.text = info.nickName;
                title.textAlignment = NSTextAlignmentCenter;
                title.font = [UIFont systemFontOfSize:13];
                [self.contentView addSubview:title];
            }
        }
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 40, 24)];
        _titleLabel.textColor = DarkGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(self.titleLabel), 0, SCREEN_WIDTH-100, 44)];
    }
    return _textField;
}

- (UIImageView *)codeImgView
{
    if (!_codeImgView)
    {
        _codeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 7, 30, 30)];
        _codeImgView.image = OrigIMG(@"person-message_2D-barcode");
    }
    return _codeImgView;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 10, 40, 24)];
        _statusLabel.textColor = kHCNavBarColor;
        _statusLabel.font = [UIFont systemFontOfSize:15];
        _statusLabel.text = @"审核";
    }
    return _statusLabel;
}

@end

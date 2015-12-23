//
//  HCCustomTagUserInfoCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomTagUserInfoCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
@interface HCCustomTagUserInfoCell ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderTitleArr;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *headerIMGBtn;

@end

@implementation HCCustomTagUserInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.textLabel.textColor = RGB(46, 46, 46);
        self.textLabel.font = DefaultFontSize;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1)
    {
        _tagUserInfo.userName = textField.text;
    }else if (textField.tag == 2)
    {
        _tagUserInfo.userGender = textField.text;
    }else if (textField.tag == 3)
    {
        _tagUserInfo.userBirthday = textField.text;
    }else if (textField.tag == 4)
    {
        _tagUserInfo.userAddress = textField.text;
    }else if (textField.tag == 5)
    {
        _tagUserInfo.userSchool = textField.text;
    }else if (textField.tag == 6)
    {
        _tagUserInfo.userPhoneNum = textField.text;
    }else if (textField.tag == 7)
    {
        _tagUserInfo.userIDCard = textField.text;
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    self.titleLabel.text = self.titleArr[indexPath.row];

        if (indexPath.row == 0)
        {
            [self.contentView addSubview: self.headerIMGBtn];
        }else if (indexPath.row != 0)
        {
            NSAttributedString *attriString = [[NSAttributedString alloc] initWithString:self.placeholderTitleArr[indexPath.row - 1] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
            self.textField.attributedPlaceholder = attriString;
        }
        
        if (indexPath.row == 1)
        {
            self.textField.text = _tagUserInfo.userName;
        }else if (indexPath.row == 2)
        {
            self.textField.text = _tagUserInfo.userGender;
        }else if (indexPath.row == 3)
        {
            self.textField.text = _tagUserInfo.userBirthday;
        }else if (indexPath.row == 4)
        {
            self.textField.text = _tagUserInfo.userAddress;
        }else if (indexPath.row == 5)
        {
            self.textField.text = _tagUserInfo.userSchool;
        }else if (indexPath.row == 6)
        {
            self.textField.text = _tagUserInfo.userPhoneNum;
        }else if (indexPath.row == 7)
        {
            self.textField.text = _tagUserInfo.userIDCard;
        }
        
        if (indexPath.row == 0 || indexPath.row == 3)
        {
            self.textField.enabled = NO;
        }
        self.textField.delegate = self;
        self.textField.tag = indexPath.row;
    
}

#pragma mark --- privous Method

-(void)handleheaderIMG
{
//    [self ]
    if ([self.delegate respondsToSelector:@selector(addUserHeaderIMG)])
    {
     NSLog(@"1111");
        [self.delegate addUserHeaderIMG];
        
    }
   
}

#pragma mark --  Setter Or Getter
-(UIButton *)headerIMGBtn
{
    if (!_headerIMGBtn) {
        _headerIMGBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 2, 80, 80)];
        [_headerIMGBtn setBackgroundImage:OrigIMG(@"Head-Portraits") forState:UIControlStateNormal];
//        [self.headerIMGBtn sd_setBackgroundImageWithURL:self.tagUserInfo.userImageUrlStr forState:UIControlEventTouchUpInside completed:nil];
        [_headerIMGBtn addTarget:self action:@selector(handleheaderIMG) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerIMGBtn;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 2, 180, 40)];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = RGB(120, 120, 120);
    }
    return _textField;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = RGB(46, 46, 46);
    }
    return _titleLabel;
}

- (NSArray *)placeholderTitleArr
{
    if (!_placeholderTitleArr)
    {
        _placeholderTitleArr = @[@"请输入姓名", @"请选择性别", @"请输入生日", @"请输入住址",@"请输入学校名称", @"请输入手机号", @"请输入身份证号"];
    }
    return _placeholderTitleArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"头像",@"姓名", @"性别", @"生日", @"住址", @"学校", @"电话", @"身份证"];
    }
    return _titleArr;
}

@end

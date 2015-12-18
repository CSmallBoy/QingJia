//
//  HCCustomTagContactTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomTagContactTableViewCell.h"


@interface HCCustomTagContactTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderTitleArr;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HCCustomTagContactTableViewCell

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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0)
    {
        _tagUserInfo.contactPersonInfo.contactName = textField.text;
    }else if (textField.tag == 1)
    {
        _tagUserInfo.contactPersonInfo.contactRelationShip = textField.text;
    }else if (textField.tag == 2)
    {
        _tagUserInfo.contactPersonInfo.contactPhoneNum= textField.text;
    }else if (textField.tag == 3)
    {
        _tagUserInfo.contactPersonInfo.contactIDCard = textField.text;
    }
}


#pragma mark---Setter Or Getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{
       self.titleLabel.text = self.titleArr[indexPath.row];
    
    NSAttributedString *attriString = [[NSAttributedString alloc] initWithString:self.placeholderTitleArr[indexPath.row] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    self.textField.attributedPlaceholder = attriString;
    
    if (indexPath.row == 0)
    {
        self.textField.text = _tagUserInfo.contactPersonInfo.contactName;
    }else if (indexPath.row == 1)
    {
        self.textField.text = _tagUserInfo.contactPersonInfo.contactRelationShip;
    }else if (indexPath.row == 2)
    {
        self.textField.text = _tagUserInfo.contactPersonInfo.contactPhoneNum;
    }else 
    {
        self.textField.text = _tagUserInfo.contactPersonInfo.contactIDCard;
    }
    
    self.textField.delegate = self;
    self.textField.tag = indexPath.row;
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
        _placeholderTitleArr = @[@"请输入姓名", @"请选择与标签使用者的关系", @"请输入手机号", @"请输入身份证号"];
    }
    return _placeholderTitleArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"姓名",@"关系", @"电话", @"身份证"];
    }
    return _titleArr;
}

@end

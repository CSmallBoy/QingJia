//
//  HCCustomTagUserMedicalCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomTagUserMedicalCell.h"

@interface HCCustomTagUserMedicalCell ()<UITextFieldDelegate>


@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderTitleArr;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HCCustomTagUserMedicalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.textLabel.textColor = RGB(46, 46, 46);
        self.textLabel.font = DefaultFontSize;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0)
    {
        _tagUserInfo.userBloodType = textField.text;
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
          [self.contentView addSubview:self.textField];
    }
    self.textField.delegate = self;
    self.textField.tag = indexPath.row;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 2, 180, 40)];
        _textField.textAlignment = NSTextAlignmentLeft;
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
        _placeholderTitleArr = @[@"请输入标签使用者的血型",@""];
    }
    return _placeholderTitleArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"血型",@"过敏史"];
    }
    return _titleArr;
}

@end

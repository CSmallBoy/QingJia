//
//  HCCustomTagContactTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPromisedContactTableViewCell.h"

#import "HCPromisedContractPersonInfo.h"

@interface HCPromisedContactTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderTitleArr;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic,strong) HCPromisedContractPersonInfo *info;

@end

@implementation HCPromisedContactTableViewCell

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

#pragma mark---UITextfieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(dismissDatePicker0)])
    {
        [self.delegate dismissDatePicker0];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//     _info.OrderIndex = _indexPath.section;
    if (textField.tag == 0)
    {
        _info.ObjectXName = textField.text;
    }
    else if (textField.tag == 1)
    {
        _info.ObjectXRelative = textField.text;
    }
    else if (textField.tag == 2)
    {
        if (textField.text.length != 11) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
        _info.PhoneNo = textField.text;
    }
    else if (textField.tag == 3)
    {
        if (textField.text.length != 18) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的身份证号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }

        _info.IDNo = textField.text;
    }
}

#pragma mark---Setter Or Getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    self.titleLabel.text = self.titleArr[indexPath.row];
    NSAttributedString *attriString = [[NSAttributedString alloc] initWithString:self.placeholderTitleArr[indexPath.row] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    self.textField.attributedPlaceholder = attriString;
    self.textField.delegate = self;
    self.textField.tag = indexPath.row;
    self.textField.enabled = _isEdit;
    _info = _contactArr[_indexPath.section-1];
   
   

    if (indexPath.row == 0)
    {
        self.textField.text = _info.ObjectXName;
    }
    else if (indexPath.row == 1)
    {
        self.textField.text = _info.ObjectXRelative ;
    }
    else if (indexPath.row  == 2)
    {
        self.textField.text = _info.PhoneNo;
    }
    else if (indexPath.row == 3)
    {
       self.textField.text =  _info.IDNo;
    }
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 2, SCREEN_WIDTH - 100, 40)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = [UIColor blackColor];
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

//
//  HCCustomTagContactTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomTagContactTableViewCell.h"
#import "HCContactPersonInfo.h"

@interface HCCustomTagContactTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderTitleArr;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) HCContactPersonInfo *info;

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
        _info.PhoneNo = textField.text;
    }
    else if (textField.tag == 3)
    {
        _info.IDNo = textField.text;
    }
}


#pragma mark---Setter Or Getter

-(void)setInfo:(HCContactPersonInfo *)info
{
    _info = info;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    self.titleLabel.text = self.titleArr[indexPath.row];
    NSAttributedString *attriString = [[NSAttributedString alloc] initWithString:self.placeholderTitleArr[indexPath.row] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    self.textField.attributedPlaceholder = attriString;
    self.textField.delegate = self;
    self.textField.tag = indexPath.row;
}

-(void)setContactArr:(NSMutableArray *)contactArr
{
    _contactArr = contactArr;
    if (_indexPath.section == 1 || _indexPath.section == 2)
    {
        _info = contactArr[_indexPath.section-1];
    }
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 2, SCREEN_WIDTH - 100, 40)];
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

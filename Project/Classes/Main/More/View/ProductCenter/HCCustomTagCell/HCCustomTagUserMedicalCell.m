//
//  HCCustomTagUserMedicalCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomTagUserMedicalCell.h"
#import "HCFeedbackTextView.h"
#import "HCTagUserInfo.h"

@interface HCCustomTagUserMedicalCell ()<UITextFieldDelegate,HCFeedbackTextViewDelegate>

@property (nonatomic,strong) NSArray *placeholderTitleArr;
@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic,strong) HCFeedbackTextView *textView;

@end

@implementation HCCustomTagUserMedicalCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark---UITextfieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(dismissDatePicker2)])
    {
        [self.delegate dismissDatePicker2];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _tagUserInfo.BloodType = _textField.text;
}

#pragma mark ----HCFeedbackTextViewDelegate

-(void)feedbackTextViewdidBeginEditing
{
    if ([self.delegate respondsToSelector:@selector(dismissDatePicker2)])
    {
        [self.delegate dismissDatePicker2];
    }
}

-(void)feedbackTextViewdidEndEditing
{
    _tagUserInfo.Allergic = self.textView.textView.text;
}

#pragma mark---Setter Or Getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    _titleLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row == 0)
    {
        self.textField.placeholder = self.placeholderTitleArr[indexPath.row];
        self.textField.text = _tagUserInfo.BloodType;
        self.textField.delegate = self;
        [self.contentView addSubview:self.textField];
    }
    else if (indexPath.row == 1)
    {
        self.textView.placeholder = self.placeholderTitleArr[indexPath.row];
        if (_tagUserInfo.Allergic)
        {
            self.textView.textView.text = _tagUserInfo.Allergic;
        }
        [self.contentView addSubview:self.textView];
    }
}

-(HCFeedbackTextView *)textView
{
    if (!_textView)
    {
        _textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(85, 0, SCREEN_WIDTH-100, 88)];
        _textView.maxTextLength = SCREEN_WIDTH-100;
        self.textView.delegate = self;
    }
    return _textView;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 4, SCREEN_WIDTH-100, 40)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = SYSTEMFONT(15);
    }
    return _textField;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 4, 60, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = RGB(46, 46, 46);
    }
    return _titleLabel;
}

- (NSArray *)placeholderTitleArr
{
    if (!_placeholderTitleArr)
    {
        _placeholderTitleArr = @[@"点击输入标签使用者的血型",@"如果标签使用者有药物过敏史，点击输入过敏药物名称"];
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

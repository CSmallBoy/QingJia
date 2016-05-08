//
//  HCPromisedMedicalCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedMedicalCell.h"
#import "HCFeedbackTextView.h"
#import "HCPromisedDetailInfo.h"

@interface HCPromisedMedicalCell ()<UITextFieldDelegate,HCFeedbackTextViewDelegate>

@property (nonatomic,strong) NSArray *placeholderTitleArr;
@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic,strong) HCFeedbackTextView *textView;

@end

@implementation HCPromisedMedicalCell


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
    switch (textField.tag-100) {
        case 0:
            _detailInfo.Height = _textField.text;
            break;
        case 1:
            _detailInfo.Weight = _textField.text;
            break;
        case 2:
            _detailInfo.BloodType = _textField.text;
            break;
        case 4:
            _detailInfo.Medical = _textField.text;
            break;
        default:
            break;
    }
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
    
    if (self.textView.tag == 103) {
        
         _detailInfo.Allergic = self.textView.textView.text;
    }
    else if (self.textView.tag == 105)
    {
        _detailInfo.Medicalnote = self.textView.textView.text;
    }

}

#pragma mark---Setter Or Getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    _titleLabel.text = self.titleArr[indexPath.row];
    
    self.textField.text = nil;
    switch (indexPath.row) {
        case 0:
            self.textField.text = _detailInfo.Height;
            self.textField.placeholder = self.placeholderTitleArr[indexPath.row];
            self.textField.tag = 100 +indexPath.row;
            self.textField.delegate = self;
            [self.contentView addSubview:self.textField];
            break;
        case 1:
            self.textField.text = _detailInfo.Weight;
            self.textField.placeholder = self.placeholderTitleArr[indexPath.row];
            self.textField.tag = 100 +indexPath.row;
            self.textField.delegate = self;
            [self.contentView addSubview:self.textField];
            break;
        case 2:
            self.textField.text = _detailInfo.BloodType;
            self.textField.placeholder = self.placeholderTitleArr[indexPath.row];
            self.textField.tag = 100 +indexPath.row;
            self.textField.delegate = self;
            [self.contentView addSubview:self.textField];
            break;
            break;
        case 3:
            self.textView.placeholder = self.placeholderTitleArr[indexPath.row];
            if (_detailInfo.Allergic)
            {
                self.textView.textView.text = _detailInfo.Allergic;
                self.textView.textView.textColor = [UIColor blackColor];
            }
            self.textView.tag = 100 +indexPath.row;
            self.textField.delegate = self;
            self.textView.delegate = self;
            [self.contentView addSubview:self.textView];
            break;
        case 4:
            self.textField.text = _detailInfo.Medical;
            self.textField.placeholder = self.placeholderTitleArr[indexPath.row];
            self.textField.tag = 100 +indexPath.row;
            self.textField.delegate = self;
            [self.contentView addSubview:self.textField];
            break;
            break;
        case 5:
            self.textView.placeholder = self.placeholderTitleArr[indexPath.row];
            if (_detailInfo.Medicalnote)
            {
                self.textView.textView.text = _detailInfo.Medicalnote;
                self.textView.textView.textColor = [UIColor blackColor];
            }
            self.textView.tag = 100 +indexPath.row;
            self.textField.delegate = self;
            self.textView.delegate = self;
            [self.contentView addSubview:self.textView];
            break;
        default:
            break;
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
        _placeholderTitleArr = @[@"点击输入试用标签者的身高",
                                 @"点击输入标签者的体重",
                                 @"点击输入标签者的血型",
                                 @"如果走失者有药物过敏历史点击输入过敏药物名称",
                                 @"请输入标签使用者的医疗状况",
                                 @"请输入标签使用者的医疗状况"];
    }
    return _placeholderTitleArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[
                      @"身高",
                      @"体重",
                      @"血型",
                      @"过敏史",
                      @"医疗状况",
                      @"医疗笔记"];
    }
    return _titleArr;
}

@end

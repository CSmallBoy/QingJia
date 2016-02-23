//
//  HCBaseUserInfoCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//
#import "HCBaseUserInfoCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "HCPromisedDetailInfo.h"

@interface HCBaseUserInfoCell ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderTitleArr;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *headerIMGBtn;

@property (nonatomic,strong) UISwitch  *swi;

@end

@implementation HCBaseUserInfoCell

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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(dismissDatePicker)])
    {
        [self.delegate dismissDatePicker];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0)
    {
        _detailInfo.ObjectXName = textField.text;
    }else if (textField.tag == 1)
    {
        _detailInfo.ObjectSex = textField.text;
  
    }else if (textField.tag == 2)
    {
        _detailInfo.ObjectBirthDay = textField.text;
    }else if (textField.tag == 3)
    {
        _detailInfo.ObjectHomeAddress = textField.text;
    }else if (textField.tag == 4)
    {
        _detailInfo.ObjectSchool = textField.text;
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.row ==4) {
        self.titleLabel.text = self.titleArr[indexPath.row];
    }
    else
    {
        NSMutableAttributedString  *attStr = [[NSMutableAttributedString alloc]initWithString:self.titleArr[indexPath.row]];
        [attStr addAttributes: @{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(2, 1)];
        self.titleLabel.attributedText = attStr;
    }

    NSAttributedString *attriString = [[NSAttributedString alloc] initWithString:self.placeholderTitleArr[indexPath.row ] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    self.textField.attributedPlaceholder = attriString;
    if (indexPath.row == 0)
    {
        self.textField.text = _detailInfo.ObjectXName;
    }else if (indexPath.row == 1)
    {
        self.textField.text = _detailInfo.ObjectSex;
    }else if (indexPath.row == 2)
    {
        self.textField.text = _detailInfo.ObjectBirthDay;
    }else if (indexPath.row == 3)
    {
        self.textField.text = _detailInfo.ObjectHomeAddress;
        [self.contentView addSubview:self.swi];
    }else if (indexPath.row == 4)
    {
        self.textField.text = _detailInfo.ObjectSchool;
    }
    
    if (indexPath.row == 2)
    {
        self.textField.enabled = NO;
    }
    self.textField.delegate = self;
    self.textField.tag = indexPath.row;
    
}

#pragma mark --- privous Method

-(void)handleheaderIMG:(UIButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(addUserHeaderIMG:)])
    {
        [self.delegate addUserHeaderIMG:button];
    }
}

#pragma mark --  Setter Or Getter

- (UISwitch *)swi
{
    if(!_swi){
        _swi = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 5, 50, 30)];
        _swi.on = YES;
    }
    return _swi;
}

-(UIButton *)headerIMGBtn
{
    if (!_headerIMGBtn)
    {
        _headerIMGBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 2, 80, 80)];
        if (self.image == nil) {
            [_headerIMGBtn setBackgroundImage:OrigIMG(@"Head-Portraits") forState:UIControlStateNormal];
        }
        else
        {
            [_headerIMGBtn setBackgroundImage:self.image forState:UIControlStateNormal];
        }
        
        [_headerIMGBtn addTarget:self action:@selector(handleheaderIMG:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_headerIMGBtn, 40);
    }
    return _headerIMGBtn;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 2, SCREEN_WIDTH-100, 40)];
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
        _placeholderTitleArr = @[@"请输入姓名",
                                 @"请选择性别",
                                 @"请输入生日",
                                 @"请输入住址",
                                 @"请输入学校名称"
                                 ];
    }
    return _placeholderTitleArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[
                      @"姓名*",
                      @"性别*",
                      @"生日*",
                      @"住址*",
                      @"学校"
                      ];
    }
    return _titleArr;
}

@end
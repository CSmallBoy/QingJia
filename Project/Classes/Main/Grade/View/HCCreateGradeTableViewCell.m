//
//  HCCreateGradeTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCreateGradeTableViewCell.h"
#import "HCCreateGradeInfo.h"

@interface HCCreateGradeTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *redMark;
@property (nonatomic, strong) UIImageView *selectedImgView;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderArr;


@end

@implementation HCCreateGradeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.redMark];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_indexPath.row != 5)
    {
        self.title.textColor = DarkGrayColor;
        self.title.frame = CGRectMake(10, 0, 80, 50);
        self.textField.frame = CGRectMake(MaxX(self.title), 0, SCREEN_WIDTH-100, 50);
    }else
    {
        self.title.frame = CGRectMake(0, 0, WIDTH(self), 20);
        self.title.textColor = RGB(200, 200, 200);
        self.title.center = self.contentView.center;
        _selectedImgView.frame = CGRectMake(0, 0, 160, 120);
        _selectedImgView.center = self.contentView.center;
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0)
    {
        _info.FamilyName = textField.text;
    }else if (textField.tag == 1)
    {
        _info.FamilyNickName = textField.text;
    }else if (textField.tag == 2)
    {
        _info.ContactAddr = textField.text;
    }else if (textField.tag == 3)
    {
        _info.VisitPassWord = textField.text;
    }else if (textField.tag == 4)
    {
        _info.repassword = textField.text;
    }
}

#pragma mark - setter or getter

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.textField.tag = indexPath.row;
    if (indexPath.row != 5)
    {
        self.textField.enabled = YES;
        self.redMark.hidden = NO;
        self.title.hidden = NO;
        self.title.text = self.titleArr[indexPath.row];
        self.textField.placeholder = self.placeholderArr[indexPath.row];
    }else
    {
        self.textField.enabled = NO;
        self.redMark.hidden = YES;
    }
    if (indexPath.row == 5)
    {
        self.title.text = @"请点击上传您的班级照片";
        [self.contentView addSubview:self.selectedImgView];
        if (!IsEmpty(_info.uploadImage))
        {
            self.title.hidden = YES;
            self.selectedImgView.image = _info.uploadImage;
        }
    }
}

- (UILabel *)title
{
    if (!_title)
    {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = DarkGrayColor;
        _title.font = [UIFont systemFontOfSize:16];
    }
    return _title;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.delegate = self;
    }
    return _textField;
}

- (UILabel *)redMark
{
    if (!_redMark)
    {
        _redMark = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 0, 10, 50)];
        _redMark.textColor = [UIColor redColor];
        _redMark.text = @"*";
    }
    return _redMark;
}

- (UIImageView *)selectedImgView
{
    if (!_selectedImgView)
    {
        _selectedImgView = [[UIImageView alloc] initWithImage:OrigIMG(@"Createclass_Picture")];
    }
    return _selectedImgView;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"班级名字", @"班级签名", @"学校地址", @"班级密码", @"班级密码"];
    }
    return _titleArr;
}

- (NSArray *)placeholderArr
{
    if (!_placeholderArr)
    {
        _placeholderArr = @[@"请给您的班级取个名字", @"请点击输入一句班级签名",@"请点击输入您的学校地址",
                            @"请点击设置班级密码", @"请再次点击输入班级密码进行校验"];
    }
    return _placeholderArr;
}


@end

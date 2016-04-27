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
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_indexPath.row != 4)
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
        _info.familyNickName = textField.text;
    }else if (textField.tag == 1)
    {
        _info.familyDescription = textField.text;
    }else if (textField.tag == 2)
    {
        _info.contactAddr = textField.text;
    }
    else if (textField.tag == 3)
    {
        _info.ancestralHome = textField.text;
    }
}

#pragma mark - setter or getter

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.textField.tag = indexPath.row;
    if (indexPath.row != 4)
    {
        self.textField.enabled = YES;
        self.title.hidden = NO;
        self.title.text = self.titleArr[indexPath.row];
        self.textField.placeholder = self.placeholderArr[indexPath.row];
    }else
    {
        self.textField.enabled = NO;
        self.redMark.hidden = YES;
    }
    if (indexPath.row == 4)
    {
        self.title.text = @"请点击上传您的家庭照片";
        [self.contentView addSubview:self.selectedImgView];
        if (!IsEmpty(_info.uploadImage))
        {
            self.title.hidden = YES;
             UIImageView *imageView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 150)];
            imageView.image = _info.uploadImage;
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
        }
    }
    
    if (indexPath.row == 1)
    {
        [self.contentView addSubview:self.redMark];
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
        _titleArr = @[@"家庭昵称",@"家庭签名", @"家庭住址", @"祖籍"];
    }
    return _titleArr;
}

- (NSArray *)placeholderArr
{
    if (!_placeholderArr)
    {
        _placeholderArr = @[@"点击输入家庭昵称",@"点击输入一句家庭签名", @"点击输入您的家庭住址",@"请点击输入您的祖籍"];
    }
    return _placeholderArr;
}


@end

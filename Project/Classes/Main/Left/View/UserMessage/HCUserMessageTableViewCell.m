//
//  HCUserMessageTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUserMessageTableViewCell.h"

@interface HCUserMessageTableViewCell()

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeArr;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *codeImgView;

@end

@implementation HCUserMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.codeImgView];
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    self.title.text = self.titleArr[indexPath.row];
    self.accessoryType = UITableViewCellAccessoryNone;
    
    NSMutableAttributedString *placeholder = nil;
    if (indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7)
    {
        placeholder = [[NSMutableAttributedString alloc] initWithString:self.placeArr[indexPath.row]];
        [placeholder setAttributes:@{NSForegroundColorAttributeName: LightGraryColor, NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, placeholder.length)];
        self.textField.enabled = YES;
    }else{
        placeholder = [[NSMutableAttributedString alloc] initWithString:self.placeArr[indexPath.row]];
        [placeholder setAttributes:@{NSForegroundColorAttributeName: DarkGrayColor, NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, placeholder.length)];
        self.textField.enabled = NO;
    }
    self.textField.attributedPlaceholder = placeholder;
    
    if (indexPath.row == 8)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 1)
    {
        self.codeImgView.hidden = NO;
    }else
    {
        self.codeImgView.hidden = YES;
    }
}

#pragma mark - setter or getter

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(self.title)+10, 0, SCREEN_WIDTH-50, 50)];
    }
    return _textField;
}

- (UILabel *)title
{
    if (!_title)
    {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 35, 50)];
        _title.textColor = DarkGrayColor;
    }
    return _title;
}

- (UIImageView *)codeImgView
{
    if (!_codeImgView)
    {
        _codeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 10, 30, 30)];
        _codeImgView.image = OrigIMG(@"person-message_2D-barcode");
    }
    return _codeImgView;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"姓名", @"名片", @"性别", @"年龄",
                      @"生日", @"住址", @"公司", @"职业", @"健康"];
    }
    return _titleArr;
}

- (NSArray *)placeArr
{
    if (!_placeArr)
    {
        _placeArr = @[@"点击输入您的真实姓名", @"我的二维码", @"请选择性别", @"请填写年龄",@"请选择生日",
                      @"点击输入您的公司名字", @"点击输入您的职业", @"点击输入您的职业", @"我的医疗急救卡"];
    }
    return _placeArr;
}



@end

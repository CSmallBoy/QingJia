//
//  HCAddNewAddressTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCAddNewAddressTableViewCell.h"
#import "HCFeedbackTextView.h"

@interface HCAddNewAddressTableViewCell ()

@property (nonatomic,strong) NSArray *placeholderTitleArr;
@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) HCFeedbackTextView *textView;
@end

@implementation HCAddNewAddressTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
        _titleLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row !=4) {
        NSAttributedString *attriString = [[NSAttributedString alloc] initWithString: self.placeholderTitleArr[indexPath.row] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        self.textField.attributedPlaceholder = attriString;
        [self.contentView addSubview:self.textField];
    }
    else
    {
        [self.contentView addSubview:self.textView];
    }
}


-(HCFeedbackTextView *)textView
{
    if (!_textView) {
        _textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100, 88)];
        _textView.placeholder = @"请输入收货人的详细收货地址(街道、门牌号)";
        _textView.maxTextLength = SCREEN_WIDTH-100;
        
    }
    return _textView;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 4, SCREEN_WIDTH-100, 40)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = RGB(120, 120, 120);
        _textField.font = FONT(15);
      
    }
    return _textField;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 4, 80, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = RGB(46, 46, 46);
    }
    return _titleLabel;
}

- (NSArray *)placeholderTitleArr
{
    if (!_placeholderTitleArr)
    {
        _placeholderTitleArr = @[@"请输入收货人姓名", @"请输入收货人手机号码",@"请输入收货地址的邮政编码",@"请输入省市区"];
    }
    return _placeholderTitleArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"收货人姓名",@"手机号码", @"邮政编码",@"收货地址",@"收货街道"];
    }
    return _titleArr;
}

@end

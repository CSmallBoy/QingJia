//
//  HCPromisedNormalCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedNormalCell.h"
#import "HCLightGrayLineView.h"

@interface HCPromisedNormalCell ()<UITextFieldDelegate>
{
    UILabel      * _lable;
    UITextField  * _textField;
    UILabel      * _blackLabel;
    NSString     * _str;
    
}
@end

@implementation HCPromisedNormalCell

+(instancetype)CustomCellWithTableView:(UITableView *)tableView
{
   static  NSString *NCellID = @"NormalCellID";

   HCPromisedNormalCell *cell = [[HCPromisedNormalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NCellID];
   [cell addSubviews];
    
    return cell;
}
#pragma mark ---textFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textFieldBlock(textField.text,self.indexPath);
    _isEdited = YES;
    _str = textField.text;
}

#pragma mark --- private method

-(void)addSubviews
{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 60, 40)];
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.textColor = [UIColor blackColor];
    [self addSubview:_lable];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 2, SCREEN_WIDTH-70, 40)];
    _textField.delegate =self;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.font = [UIFont systemFontOfSize:14];
      _textField.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_textField];
    
    HCLightGrayLineView *lineView = [[HCLightGrayLineView alloc]initWithFrame:CGRectMake(60, 43, SCREEN_WIDTH-70, 1)];
    [self addSubview:lineView];
    
  
   
}

#pragma mark --- Setter Or Getter

-(void)setTitle:(NSString *)title
{
    _title = title;
    _lable.text = nil;
    _lable.text = title;
    if (_isBlack)
    {
        [_blackLabel removeFromSuperview];
        _blackLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 2, SCREEN_WIDTH-70, 40)];
        _blackLabel.userInteractionEnabled = YES;

        _blackLabel.textColor = [UIColor blackColor];
        _blackLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_blackLabel];
    }
    
}

-(void)setDetail:(NSString *)detail
{
    _detail = detail;
    if (_isBlack)
    {
        _blackLabel.text = nil;
        _blackLabel.text = detail;
    }else
    {
            _textField.placeholder = nil;
            _textField.placeholder = detail;
  
     }
}


-(void)setText:(NSString *)text
{
    _text = text;
    _textField.text = text;
}


@end

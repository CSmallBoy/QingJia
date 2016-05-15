//
//  HCChangeBounleTelNumberCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCChangeBounleTelNumberCell.h"



@interface HCChangeBounleTelNumberCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) NSArray     *titleArr;
@property (nonatomic,strong) NSArray     *placeHodelArr;
@property (nonatomic,strong) NSString    *phoneNum;
@end

@implementation HCChangeBounleTelNumberCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
     NSString  *ID = @"changeBounleTelCellID";
    HCChangeBounleTelNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[HCChangeBounleTelNumberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    return cell;
}


-(void)addSubviews
{
    for (UIView * view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];


}

#pragma mark --- UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.indexPath == 0)
    {
        self.phoneNum = textField.text;
        
    }
    else
    {
        self.codeNum = textField.text;
        
    }
}



#pragma mark ---- getter Or Getter


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.titleLabel.text = self.titleArr[indexPath.row];
    self.textField.placeholder = self.placeHodelArr[indexPath.row];
    self.textField.tag = 100+ indexPath.row;
    
    if (indexPath.row ==0 && _isSure == NO)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH-90, 10, 80, 30);
        button.backgroundColor = COLOR(222, 35, 46, 1);
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(getCodeNumber:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(button, 5);
        [self.contentView addSubview:button];
    }
}

- (void)getCodeNumber:(UIButton *)button
{
    UIView *view = button.superview;
    //这个是手机号
    UITextField *textField = (UITextField *)[view viewWithTag:100];
    NSDictionary *dic = @{@"phoneNum" : textField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getCodeNumber" object:nil userInfo:dic];
}

- (NSArray *)titleArr
{
    if(!_titleArr){
        _titleArr =@[@"手机号码",@"验证码"];
    }
    return _titleArr;
}



- (NSArray *)placeHodelArr
{
    if(!_placeHodelArr){
        
        if (_isSure)
        {
            _placeHodelArr = @[@"请点击输入的新的绑定手机号",@"请点击再次输入新的绑定手机号验证"];
        }else
        {
        _placeHodelArr = @[@"请输入原来的手机号",@""];
        }
        
        
    }
    return _placeHodelArr;
}


- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,15 , 60, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        
    }
    return _titleLabel;
}


- (UITextField *)textField
{
    if(!_textField){
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(70, 15,300, 20)];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = [UIColor blackColor];
        _textField.delegate = self;
    }
    return _textField;
}






@end

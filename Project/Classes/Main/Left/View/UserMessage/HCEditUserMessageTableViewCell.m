//
//  HCEditUserMessageTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCEditUserMessageTableViewCell.h"


@interface HCEditUserMessageTableViewCell ()
@property (nonatomic,strong) UILabel      *titleLabel;
@property (nonatomic,strong) UITextField  *textField;
@property (nonatomic,strong) NSArray      *titleArr;
@property (nonatomic,strong) NSArray      *textFieldArr;
@end

@implementation HCEditUserMessageTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString  *ID = @"EditUserMessageCell";
    HCEditUserMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[HCEditUserMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       
        
    }
     [cell addSubviews];
    return cell;

}

-(void)addSubviews
{
  
    for (UIView  *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
}


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    if (indexPath.section == 1)
    {
        self.titleLabel.frame = CGRectMake(12, 10, 120, 20);
         self.textField.frame = CGRectMake(120, 10, SCREEN_WIDTH-100, 20);
    }
    
    if (indexPath.section==0 && indexPath.row == 0)
    {
        self.textField.placeholder = @"上传头像";
        self.textField.enabled = NO;
        self.textField.frame = CGRectMake(52 + 10, 10, SCREEN_WIDTH-100, 20);
        UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
        [button setBackgroundImage:IMG(@"2Dbarcode_message_HeadPortraits") forState:UIControlStateNormal];
        [self.contentView addSubview:button];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
          self.textField.placeholder = @"点击输入您的昵称";
    }
    
    if (indexPath.section == 0 && indexPath.row == 10)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 6, 15, 30)];
        imageView.image = IMG(@"icon_drop_down");
        [self.contentView addSubview:imageView];
    }
    
    if (indexPath.section == 1) {
        UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(SCREEN_WIDTH-50, 12, 40, 20);
        [button setTitle:@"修改" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toChangeNumber:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
    }
    
    self.titleLabel.text = self.titleArr[indexPath.section][indexPath.row];
    self.textField.text = self.textFieldArr[indexPath.section][indexPath.row];
   
}

#pragma mark --- private mothods
// 跳转修改绑定手机号界面
-(void)toChangeNumber:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toChangeNumber" object:nil];
    
}

#pragma mark --- gerter Or setter

- (NSArray *)titleArr
{
    if(!_titleArr){
        _titleArr = @[@[@"头像",@"昵称",@"姓名",@"性别",@"年龄",@"生日",@"属相",@"住址",@"公司",@"职业",@"健康"],
                      @[@"绑定手机号"]];
    }
    return _titleArr;
}

-(NSArray *)textFieldArr
{
    if (!_textFieldArr) {
        _textFieldArr = @[@[@"",@"",@"XXX",@"X",@"XX",@"XXXX-XX-XX",@"X",@"XXXXXXXXXXX",@"XXXXX",@"XXX",@"我的医疗急救卡"],
                          @[@"181109722222"]];
    }
    return _textFieldArr;
}



- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 40, 20)];
        _titleLabel.textColor = [UIColor blackColor];
        
    }
    return _titleLabel;
}


- (UITextField *)textField
{
    if(!_textField){
      
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10, 10, SCREEN_WIDTH-100, 20)];
        _textField.textColor = [UIColor blackColor];
    }
    return _textField;
}



@end

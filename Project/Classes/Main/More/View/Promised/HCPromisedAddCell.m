//
//  HCPromisedAddCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedAddCell.h"


@interface HCPromisedAddCell ()
{
        
    UIButton  *  _button;
        
}
@end



@implementation HCPromisedAddCell

+(instancetype)customCellWithTable:(UITableView *)tableView
{
    static  NSString *SmallID = @"smallID";
    
    HCPromisedAddCell   *cell = [tableView dequeueReusableCellWithIdentifier:SmallID];
    
    if (!cell) {
        cell = [[HCPromisedAddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SmallID];
        
        [cell addSubviews];
    }
    
    
    return cell;
}


-(void)addSubviews
{
    
    for (UIView  *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(0,5, SCREEN_WIDTH-130, 40);
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    //button  添加点击事件
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _button = button;
    [self addSubview:_button];
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    [_button setTitle:title forState:UIControlStateNormal];
    
    
    [_button setTitleColor:[UIColor colorWithRed:242/256.0 green:63/256.0 blue:68/256.0 alpha:1] forState:UIControlStateNormal];
    
}

-(void)buttonClick:(UIButton *)button
{
    
    
    
    
    _button.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    
    self.block(button.titleLabel.text);
    
    _button.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HCPromisedHeaderIVCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedHeaderIVCell.h"

@interface HCPromisedHeaderIVCell ()
{
    UILabel      *  _label;
    UITextField  *  _textfield;
    
    UIButton     *  _button;
}
@end


static NSString  *HeaderIVCellID = @"HeaderIVCell";
@implementation HCPromisedHeaderIVCell


+(instancetype)CustomCellWithTableView:(UITableView *)tableView
{
    HCPromisedHeaderIVCell  *cell = [tableView dequeueReusableCellWithIdentifier:HeaderIVCellID];
    
    if (!cell) {
        cell =[[HCPromisedHeaderIVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderIVCellID];
        [cell addSubviews];
    }
    

    return cell;

}

-(void)addSubviews
{
    UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 50,40)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    _label = label;
    [self addSubview:_label];
    
    _textfield = [[UITextField alloc]initWithFrame:CGRectMake(60, 50, 240, 40)];
    _textfield.borderStyle = UITextBorderStyleNone;
    _textfield.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textfield];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(SCREEN_WIDTH-90, 4, 80, 80);
    [_button setBackgroundImage:[UIImage imageNamed:@"label_Head-Portraits"] forState:UIControlStateNormal];
    [self addSubview:_button];

}


- (void)setTitle:(NSString *)title
{

    _title = title;
    _label.text = title;
    
}

-(void)setDetail:(NSString *)detail
{
    _detail = detail;
    _textfield.placeholder = detail;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

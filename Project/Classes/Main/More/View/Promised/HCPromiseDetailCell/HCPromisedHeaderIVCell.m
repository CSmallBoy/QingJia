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
    UILabel      *  _blackLabel;
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
    UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 60,40)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    _label = label;
    [self addSubview:_label];
    
    _textfield = [[UITextField alloc]initWithFrame:CGRectMake(60, 50, 240, 40)];
    _textfield.borderStyle = UITextBorderStyleNone;
    _textfield.font = [UIFont systemFontOfSize:15];
    _textfield.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_textfield];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(SCREEN_WIDTH-90, 4, 80, 80);
    [_button setBackgroundImage:[UIImage imageNamed:@"label_Head-Portraits"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(selectedImage :) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    HCLightGrayLineView *lineView = [[HCLightGrayLineView alloc]initWithFrame:CGRectMake(60, 87, SCREEN_WIDTH-70, 1)];
    [self addSubview:lineView];
    
//    if (self.isBlack) {
//        
//        
//        _blackLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 50, 240, 40)];
//        _blackLabel.textColor = [UIColor blackColor];
//        _blackLabel.font = [UIFont systemFontOfSize:15];
//        [self addSubview:_blackLabel];
//    }
//    

}

-(void)selectedImage : (UIButton  *)button
{
    _selectImageblock();
    
}


- (void)setTitle:(NSString *)title
{

    _title = title;
    _label.text = title;
    
    if (self.isBlack) {
        
        [_blackLabel removeFromSuperview];
        _blackLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 50, 240, 40)];
        _blackLabel.textColor = [UIColor blackColor];
        _blackLabel.font = [UIFont systemFontOfSize:15];
        
        
        [self addSubview:_blackLabel];
    }
    
    
}

-(void)setDetail:(NSString *)detail
{
    _detail = detail;
    if (_isBlack) {
        
        _blackLabel.text = detail;
    }
    else
    {
        _textfield.placeholder = detail;

    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

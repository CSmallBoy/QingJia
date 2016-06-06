//
//  HCPromisedAddCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedAddCell.h"
#import "HCNewTagInfo.h"

@interface HCPromisedAddCell ()
@property(nonatomic,strong) UIButton  *button;
@property(nonatomic,strong) UIImageView  *smallIV;
@end

@implementation HCPromisedAddCell

+(instancetype)customCellWithTable:(UITableView *)tableView
{
    static  NSString *SmallID = @"smallID";
    
    HCPromisedAddCell   *cell = [tableView dequeueReusableCellWithIdentifier:SmallID];
    
    if (!cell)
    {
        cell = [[HCPromisedAddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SmallID];
        [cell addSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImage:) name:@"changeImage" object:nil];
    }
    return cell;
}

#pragma mark --- privote method

-(void)addSubviews
{
    for (UIView  *view in self.subviews) {
        [view removeFromSuperview];
    }


    [self addSubview:self.button];

}

-(void)changeImage:(NSNotification *)info
{
    UIImage *image = info.userInfo[@"image"];
    [_button setBackgroundImage:image forState:UIControlStateNormal];
    
}

#pragma mark --- Setter Or Getter



- (UIButton *)button
{
    if(!_button){
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor whiteColor];
        ViewRadius(_button, 5);
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}




- (UIImageView *)smallIV
{
    if(!_smallIV){
        _smallIV = [[UIImageView alloc]initWithFrame:CGRectMake(_button.frame.size.width-40, (_button.frame.size.height/2)-15, 30, 30)];
        _smallIV.image = IMG(@"yihubaiying_icon_m-talk logo_dis.png");
    }
    return _smallIV;
}


-(void)setInfo:(HCNewTagInfo *)info
{
    _info = info;
     [_button setTitle:info.trueName forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithRed:242/256.0 green:63/256.0 blue:68/256.0 alpha:1] forState:UIControlStateNormal];
    if (info.isBlack)
    {
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor grayColor];
        _button.userInteractionEnabled = NO;
    }
    else
    {
        _button.backgroundColor = [UIColor whiteColor];
        _button.userInteractionEnabled = YES;
    }
    
//    if (info.isSend)
//    {
//        [self addSubview:self.smallIV];
//        self.button.selected = NO;
//    }

}

-(void)setTitle:(NSString *)title
{
    _title = title;
    [_button setTitle:title forState:UIControlStateNormal];
    
    
    [_button setTitleColor:[UIColor colorWithRed:242/256.0 green:63/256.0 blue:68/256.0 alpha:1] forState:UIControlStateNormal];
}

-(void)setButtonH:(CGFloat)buttonH
{
    _buttonH = buttonH;
    _button.frame = CGRectMake(0,0, _buttonW, _buttonH);
}

-(void)buttonClick:(UIButton *)button
{
    self.block(button.titleLabel.text,self.info);
}

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end

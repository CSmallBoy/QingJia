//
//  HCTagManagerTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagManagerTableViewCell.h"
#import "HCTagManagerInfo.h"
@interface HCTagManagerTableViewCell ()


@property (nonatomic, strong) UIButton *button0;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@property (nonatomic,strong) UILabel *label0;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;


@end

@implementation HCTagManagerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor lightTextColor];
        [self.contentView addSubview:self.button0];
        [self.contentView addSubview:self.button1];
        [self.contentView addSubview:self.button2];
        [self.contentView addSubview:self.label0];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = (SCREEN_WIDTH - 60)/3;
    self.button0.frame = CGRectMake(10, 10, buttonW, buttonW);
    self.button1.frame = CGRectMake(MaxX(self.button0)+20, 10, buttonW, buttonW);
    self.button2.frame = CGRectMake(MaxX(self.button1)+20, 10, buttonW, buttonW);
    
    self.label0.frame = CGRectMake(0, MaxY(self.button0), buttonW+20, 50);
    self.label1.frame = CGRectMake(MaxX(self.label0), MaxY(self.button1), buttonW+20, 50);
    self.label2.frame = CGRectMake(MaxX(self.label1), MaxY(self.button2), buttonW+20, 50);
}

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(HCTagManagerTableViewCell:tag:)])
    {
        [self.delegate HCTagManagerTableViewCell:_indexPath tag:button.tag];
    }
}


- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    NSInteger group = self.info.imgArr.count%3;
    NSInteger row = self.info.imgArr.count/3;
    NSInteger count = indexPath.row*3;
    if (!group || row != indexPath.row)
    {
        [self.button0 setBackgroundImage:OrigIMG(self.info.imgArr[count]) forState:UIControlStateNormal];
        self.label0.text = self.info.tagNameArr[count];
        [self.button1 setBackgroundImage:OrigIMG(self.info.imgArr[count+1]) forState:UIControlStateNormal];
        self.label1.text = self.info.tagNameArr[count+1];
        [self.button2 setBackgroundImage:OrigIMG(self.info.imgArr[count+2]) forState:UIControlStateNormal];
        self.label2.text = self.info.tagNameArr[count+2];
    }else if (group == 1 && row == indexPath.row)
    {
        [self.button0 setBackgroundImage:OrigIMG(self.info.imgArr[count]) forState:
         UIControlStateNormal];
        self.label0.text = self.info.tagNameArr[count];
    }else if (group == 2 && row == indexPath.row)
    {
        
        [self.button0 setBackgroundImage:OrigIMG(self.info.imgArr[count]) forState:UIControlStateNormal];
        [self.button1 setBackgroundImage:OrigIMG(self.info.imgArr[count+1]) forState:UIControlStateNormal];
        self.label0.text = self.info.tagNameArr[count];
        self.label1.text = self.info.tagNameArr[count+1];
    }
    
    
    if (group == 1 && row == indexPath.row)
    {
        self.button1.hidden = YES;
        self.button2.hidden = YES;
        self.label1.hidden = YES;
        self.label2.hidden = YES;
    }else if (group == 2 && row == indexPath.row)
    {
        self.button2.hidden = YES;
         self.label2.hidden = YES;
    }else
    {
        self.button1.hidden = NO;
        self.button2.hidden = NO;
        self.label1.hidden = NO;
        self.label2.hidden = NO;
    }
}


-(void)setInfo:(HCTagManagerInfo *)info
{
    _info = info;
 }


#pragma mark---Setter And Getter

- (UIButton *)button0
{
    if (!_button0)
    {
        _button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button0 addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _button0.backgroundColor = [UIColor whiteColor];
        _button0.tag = 0;
    }
    return _button0;
}

- (UIButton *)button1
{
    if (!_button1)
    {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _button1.backgroundColor = [UIColor whiteColor];
        _button1.tag = 1;
    }
    return _button1;
}

- (UIButton *)button2
{
    if (!_button2)
    {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _button2.backgroundColor = [UIColor whiteColor];
        _button2.tag = 2;
    }
    return _button2;
}

-(UILabel *)label0
{
    if (!_label0)
    {
        _label0 = [[UILabel alloc]init];
        _label0.backgroundColor = [UIColor whiteColor];
        _label0.textAlignment = NSTextAlignmentCenter;
        _label0.textColor = [UIColor blackColor];
        _label0.font = [UIFont systemFontOfSize:12];
    }
    return _label0;
}

-(UILabel *)label1
{
    if (!_label1)
    {
        _label1 = [[UILabel alloc]init];
        _label1.backgroundColor = [UIColor whiteColor];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.textColor = [UIColor blackColor];
        _label1.font = [UIFont systemFontOfSize:12];
    }
    return _label1;
}

-(UILabel *)label2
{
    if (!_label2)
    {
        _label2 = [[UILabel alloc]init];
        _label2.backgroundColor = [UIColor whiteColor];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.textColor = [UIColor blackColor];
        _label2.font = [UIFont systemFontOfSize:12];
    }
    return _label2;
}

@end

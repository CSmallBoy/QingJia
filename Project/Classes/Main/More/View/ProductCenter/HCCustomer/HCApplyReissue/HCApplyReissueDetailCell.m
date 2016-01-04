//
//  HCApplyReissueDetailCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReissueDetailCell.h"
#import "HCApplyReissueResonInfo.h"

@interface HCApplyReissueDetailCell ()

@property (nonatomic,strong) UILabel *replaceContentLab;
@property (nonatomic,strong) UIView *lineView;
/**补发数量*/
@property (nonatomic,strong) UILabel *titleNumLab;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UILabel *numLab;
@property (nonatomic,strong) UIButton *addBtn;

@property(nonatomic,assign)int number;
@end

@implementation HCApplyReissueDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _number = 1;
        [self.contentView addSubview:self.replaceContentLab];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.titleNumLab];
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.numLab];
        [self.contentView addSubview:self.addBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.replaceContentLab.frame = CGRectMake(10, 0, SCREEN_WIDTH-10, 44);
    self.lineView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 0.5);
    self.titleNumLab.frame = CGRectMake(10, 44, 70, 44);
    self.deleteBtn.frame = CGRectMake(90, 51, 30, 30);
    self.numLab.frame = CGRectMake(120, 44, 50, 44);
    self.addBtn.frame = CGRectMake(170, 51, 30, 30);
}


#pragma mark---private methods

-(void)clickDeleteBtn
{
    if (self.number >1)
    {
        self.number -= 1;
        _numLab.text = [NSString stringWithFormat:@"%d",self.number];
    }
   
}

-(void)clickAddBtn
{
    self.number += 1;
     _numLab.text = [NSString stringWithFormat:@"%d",self.number];
}

#pragma mark----Setter OR Getter

-(void)setInfo:(HCApplyReissueResonInfo *)info
{
    _replaceContentLab.text = @"退货内容：M-Talk二维码标签";
    _titleNumLab.text = @"补发数量";
    _numLab.text = [NSString stringWithFormat:@"%d",self.number];
}


-(UILabel *)replaceContentLab
{
    if (!_replaceContentLab)
    {
        _replaceContentLab = [[UILabel alloc]init];
        _replaceContentLab.textAlignment = NSTextAlignmentLeft;
        _replaceContentLab.font = [UIFont systemFontOfSize:15];
        
    }
    return _replaceContentLab;
}

-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = LightGraryColor;
    }
    return _lineView;
}

-(UILabel *)titleNumLab
{
    if (!_titleNumLab)
    {
        _titleNumLab = [[UILabel alloc]init];
        _titleNumLab.textAlignment = NSTextAlignmentLeft;
        _titleNumLab.font  = [UIFont systemFontOfSize:15];
    }
    return _titleNumLab;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn)
    {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:OrigIMG(@"Products_but_minus") forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

-(UILabel *)numLab
{
    if (!_numLab)
    {
        _numLab = [[UILabel alloc]init];
        _numLab.textAlignment = NSTextAlignmentCenter;
        _numLab.font = [UIFont systemFontOfSize:15];
    }
    return _numLab;
}

-(UIButton *)addBtn
{
    if (!_addBtn)
    {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:OrigIMG(@"Products_but_Plus") forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
@end

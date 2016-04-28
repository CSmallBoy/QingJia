//
//  HCAddFriendTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAddFriendTableViewCell.h"

@interface HCAddFriendTableViewCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *textLab;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *textArr;

@end

@implementation HCAddFriendTableViewCell

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70,70)];
        imageView.image =  [UIImage imageNamed:@"chatListCellHead.png"];
        
        ViewRadius(imageView, 35);
        [self.contentView addSubview:imageView];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, WIDTH(self.contentView)-100, 40)];
        nameLab.textAlignment = NSTextAlignmentLeft;
        nameLab.text = self.nameStr;
        [self.contentView addSubview:nameLab];
    }
    else
    {
            self.titleLab.text = self.titleArr[indexPath.row];
            self.textLab.text = self.textArr[indexPath.row];
            [self.contentView addSubview:self.titleLab];
            [self.contentView addSubview:self.textLab];
    }
}

-(UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5,0, 60,HEIGHT(self.contentView))];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = SYSTEMFONT(14);
    }
    return _titleLab;
}

-(UILabel *)textLab
{
    if (!_textLab)
    {
        _textLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, WIDTH(self.contentView)-70, HEIGHT(self.contentView))];
        _textLab.textAlignment = NSTextAlignmentLeft;
        _textLab.font = SYSTEMFONT(14);
    }
    return _textLab;
}

-(NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"住址",@"个性签名"];
    }
    return _titleArr;
}

-(NSArray *)textArr
{
    if (!_textArr)
    {
        _textArr = @[@"上海市闵行区集心路168号",@"To make each day happy!"];
    }
    return _textArr;
}
@end

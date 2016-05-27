//
//  HCMissTagTableViewCell.m
//  钦家
//
//  Created by Tony on 16/5/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMissTagTableViewCell.h"

@implementation HCMissTagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)customCellWithTable:(UITableView *)tableView
{
    static NSString *identifier = @"missTag";
    HCMissTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[HCMissTagTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell addSubviews];
    }
    return cell;
}

- (void)addSubviews
{
    [self removeAllSubviews];
    [self addSubview:self.selectedButton];
    [self addSubview:self.clothingImage];
    [self addSubview:self.titleLabel];
    [self addSubview:self.idLabel];
    [self addSubview:self.remarkLabel];
}

- (UIButton *)selectedButton
{
    if (_selectedButton == nil)
    {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedButton.frame = CGRectMake(10/375.0*SCREEN_WIDTH, 30/668.0*SCREEN_HEIGHT, 20/375.0*SCREEN_WIDTH, 20/375.0*SCREEN_WIDTH);
        [_selectedButton setBackgroundImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
        [_selectedButton setBackgroundImage:IMG(@"buttonSelected") forState:UIControlStateSelected];
    }
    return _selectedButton;
}

- (UIImageView *)clothingImage
{
    if (_clothingImage == nil)
    {
        _clothingImage = [[UIImageView alloc] initWithFrame:CGRectMake(MaxX(_selectedButton)+15/375.0*SCREEN_WIDTH, 10/668.0*SCREEN_HEIGHT, 60/375.0*SCREEN_WIDTH, 60/375.0*SCREEN_WIDTH)];
        _clothingImage.backgroundColor = [UIColor redColor];
    }
    return _clothingImage;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.clothingImage)+15/375.0*SCREEN_WIDTH, 10/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-MaxX(self.clothingImage)-15/375.0*SCREEN_WIDTH, 15/668.0*SCREEN_HEIGHT)];
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
}

- (UILabel *)idLabel
{
    if (_idLabel == nil)
    {
        _idLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.clothingImage)+15/375.0*SCREEN_WIDTH, MaxY(_titleLabel)+7.5/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-MaxX(self.clothingImage)-15/375.0*SCREEN_WIDTH, 15/668.0*SCREEN_HEIGHT)];
    }
    return _idLabel;
}

- (UILabel *)remarkLabel
{
    if (_remarkLabel == nil)
    {
        _remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.clothingImage)+15/375.0*SCREEN_WIDTH, MaxY(_idLabel)+7.5/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-MaxX(self.clothingImage)-15/375.0*SCREEN_WIDTH, 15/668.0*SCREEN_HEIGHT)];
    }
    return _remarkLabel;
}


@end

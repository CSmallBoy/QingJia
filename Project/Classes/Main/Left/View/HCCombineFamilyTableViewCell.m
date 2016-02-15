//
//  HCCombineFamilyTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCombineFamilyTableViewCell.h"

@implementation HCCombineFamilyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _button_select = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button_select setFrame:CGRectMake(10, 19, 26, 26)];
    [self addSubview:_button_select];
    _family_image = [[UIImageView alloc]initWithFrame:CGRectMake(20+26, 4, 56, 56)];
    _family_image.image = [UIImage imageNamed:@"image.jpg"];
    ViewBorderRadius(_family_image, 28, 0, CLEARCOLOR);
    [self addSubview:_family_image];
    _family_name = [[UILabel alloc]initWithFrame:CGRectMake(20+56+26+20, 22, 80, 26)];
    _family_name.text = @"家庭名字";
    [self addSubview:_family_name];
}
@end

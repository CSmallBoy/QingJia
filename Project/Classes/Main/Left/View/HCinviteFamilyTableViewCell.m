//
//  HCinviteFamilyTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCinviteFamilyTableViewCell.h"

@implementation HCinviteFamilyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    //button
    _button_invite = [UIButton buttonWithType:UIButtonTypeCustom];
    _button_invite.frame = CGRectMake(SCREEN_WIDTH*0.845, 6, SCREEN_WIDTH*0.15, 25);
    [_button_invite setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    ViewBorderRadius(_button_invite, 4, 1, [UIColor grayColor]);
    [self addSubview:_button_invite];
    
    //image
    _image_head = [[UIImageView alloc]initWithFrame:CGRectMake(5, 3, 40, 40)];
    ViewBorderRadius(_image_head, 20, 0, CLEARCOLOR);
    [self addSubview:_image_head];
    
    //label
    _label_head = [[UILabel alloc]initWithFrame:CGRectMake(45+5, 3, SCREEN_WIDTH*0.5, 39)];
    [self addSubview:_label_head];
}
@end

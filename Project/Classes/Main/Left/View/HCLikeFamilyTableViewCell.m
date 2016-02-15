//
//  HCLikeFamilyTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCLikeFamilyTableViewCell.h"

@implementation HCLikeFamilyTableViewCell

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
-(void)makeUI{
    _image =[[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 40, 40)];
    _image.image = [UIImage imageNamed:@"image_hea.jpg"];
    [self addSubview:_image];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(55, 3,SCREEN_WIDTH*0.2, 39)];
    [self addSubview:_label];
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.8-10, 3,SCREEN_WIDTH*0.2, 39)];
    [self addSubview:_label2];
}
@end

//
//  HCTagDetailTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagDetailTableViewCell.h"
#import "HCNewTagInfo.h"

@interface HCTagDetailTableViewCell ()

/**信息名称*/
@property (nonatomic,strong) UILabel *titleLabel;
/**具体信息*/
@property (nonatomic,strong) UILabel *detailInfoLab;

@property (nonatomic,strong) NSArray *titleArr;
@end

@implementation HCTagDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor lightTextColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailInfoLab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 0, 40, 50);
    self.detailInfoLab.frame = CGRectMake(70, 0, SCREEN_WIDTH-70,50);
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    self.titleLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row == 1)
    {
        self.detailInfoLab.text = self.info.trueName;
    }
    else if (indexPath.row == 2)
    {
        //self.detailInfoLab.text = self.info.cardName;
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 5, 35, 35)];
//        imageView.image = OrigIMG(@"person-message_2D-barcode");
//        [self.contentView addSubview:imageView];
        
        self.detailInfoLab.text = self.info.sex;
    }
    else if (indexPath.row == 3)
    {self.detailInfoLab.text = self.info.birthDay;
        //self.detailInfoLab.text = self.info.userGender;
        //self.detailInfoLab.text = self.info.userBrithday;
    }
    else if (indexPath.row == 4)
    {   //self.detailInfoLab.text = self.info.userBrithday;
        
        //self.detailInfoLab.text = self.info.userAge;
        self.detailInfoLab.text = self.info.homeAddress;
    }
    else if (indexPath.row == 5)
    {
        self.detailInfoLab.text = self.info.school;
        //self.detailInfoLab.text = self.info.userBrithday;
    }
    else if (indexPath.row == 6)
    {
        self.detailInfoLab.text = @"我的医疗急救卡";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //self.detailInfoLab.text = self.info.userAddress;
    }
//    else if (indexPath.row == 6)
//    {
//        self.detailInfoLab.text = self.info.userSchool;
//    }
//    else if (indexPath.row == 7)
//    {
//        self.detailInfoLab.text = self.info.userJob;
//    }
//    else if (indexPath.row == 8)
//    {
//        self.detailInfoLab.text = self.info.userHealth;
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
}


-(void)setInfo:(HCNewTagInfo *)info
{
    _info = info;
}



-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(UILabel *)detailInfoLab
{
    if (!_detailInfoLab)
    {
        _detailInfoLab = [[UILabel alloc]init];
        _detailInfoLab.backgroundColor = [UIColor whiteColor];
        _detailInfoLab.textAlignment = NSTextAlignmentLeft;
        _detailInfoLab.textColor = [UIColor blackColor];
        _detailInfoLab.font = [UIFont systemFontOfSize:15];
    }
    return _detailInfoLab;
}

-(NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"",@"姓名",@"性别",@"生日",@"住址",
                      @"学校",@"健康"];
    }
    return _titleArr;
}
@end

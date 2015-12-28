//
//  HCTagDetailTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagDetailTableViewCell.h"
#import "HCTagManagerInfo.h"

@interface HCTagDetailTableViewCell ()
/**标签图*/
@property (nonatomic,strong) UIImageView *tagIMGView;
/**标签名*/
@property (nonatomic,strong) UILabel *tagNameLab;
/**标签ID*/
@property (nonatomic,strong) UILabel *tagIDLab;
/**联系人1图片*/
@property (nonatomic,strong) UIImageView *firstContactIMGView;
/**联系人1姓名*/
@property (nonatomic,strong) UILabel *firstContactNameLab;
/**联系人1电话*/
@property (nonatomic,strong) UILabel *firstContactPhoneLab;
/**联系人2图片*/
@property (nonatomic,strong) UIImageView *secondContactIMGView;
/**联系人2姓名*/
@property (nonatomic,strong) UILabel *secondContactNameLab;
/**联系人2电话*/
@property (nonatomic,strong) UILabel *secondContactPhoneLab;
/**具体信息*/
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation HCTagDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor lightTextColor];
        [self.contentView addSubview:self.tagIMGView];
        [self.contentView addSubview:self.tagNameLab];
        [self.contentView addSubview:self.tagIDLab];
        [self.contentView addSubview:self.firstContactIMGView];
        [self.contentView addSubview:self.firstContactNameLab];
        [self.contentView addSubview:self.firstContactPhoneLab];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tagIMGView.frame = CGRectMake(10, 10, 100, 100);
    self.tagNameLab.frame = CGRectMake(120, 10, SCREEN_WIDTH-130, 60);
    self.tagIDLab.frame = CGRectMake(120, 70, SCREEN_WIDTH-130, 30);
    
    self.firstContactIMGView.frame = CGRectMake(10, 120, 80, 80);
    self.firstContactNameLab.frame = CGRectMake(100, 120, SCREEN_WIDTH/2-100, 40);
    self.firstContactPhoneLab.frame = CGRectMake(100, 160, SCREEN_WIDTH/2-100,40);
    
    self.secondContactIMGView.frame = CGRectMake(SCREEN_WIDTH/2+10, 120, 80, 80);
    self.secondContactNameLab.frame = CGRectMake(SCREEN_WIDTH/2+100, 120, SCREEN_WIDTH/2-100, 40);
    self.secondContactPhoneLab.frame = CGRectMake(SCREEN_WIDTH/2+100, 160, SCREEN_WIDTH/2-100, 40);
    
    self.titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.row == 0)
    {
        self.tagIMGView.image = OrigIMG(_info.imgArr[_tagNumb]);
        self.tagNameLab.text = _info.tagNameArr[_tagNumb];
        self.tagIDLab.text = _info.tagIDArr[_tagNumb];
        
        self.firstContactIMGView.image = OrigIMG(_info.contactImgArr[0]);
        self.firstContactNameLab.text = [NSString stringWithFormat:@"%@（紧急联系人）",_info.contactNameArr[0]];
        self.firstContactPhoneLab.text = [NSString stringWithFormat:@"电话：%@",_info.contactPhoneArr[0]];
        
        self.secondContactIMGView.image = OrigIMG(_info.contactImgArr[1]);
        self.secondContactNameLab.text = [NSString stringWithFormat:@"%@（紧急联系人）",_info.contactNameArr[1]];
        self.secondContactPhoneLab.text = [NSString stringWithFormat:@"电话：%@",_info.contactPhoneArr[1]];
        
       
    }
}

-(void)setTagNumb:(NSInteger)tagNumb
{
    _tagNumb = tagNumb;
}
-(void)setInfo:(HCTagManagerInfo *)info
{
    _info = info;
}

-(UIImageView *)tagIMGView
{
    if (!_tagIMGView)
    {
        _tagIMGView = [[UIImageView alloc]init];//WithFrame:CGRectMake(10, 10, 100, 100)];
    }
    return _tagIMGView;
}

-(UILabel *)tagNameLab
{
    if (!_tagNameLab) {
        _tagNameLab = [[UILabel alloc]init];
        _tagNameLab.backgroundColor = [UIColor whiteColor];
        _tagNameLab.textAlignment = NSTextAlignmentLeft;
        _tagNameLab.textColor = [UIColor blackColor];
        _tagNameLab.font = [UIFont systemFontOfSize:18];
    }
    return _tagNameLab;
}

-(UILabel *)tagIDLab
{
    if (!_tagIDLab)
    {
        _tagIDLab = [[UILabel alloc]init];
        _tagIDLab.backgroundColor = [UIColor whiteColor];
        _tagIDLab.textAlignment = NSTextAlignmentLeft;
        _tagIDLab.textColor = [UIColor blackColor];
        _tagIDLab.font = [UIFont systemFontOfSize:15];
    }
    return _tagIDLab;
}

-(UIImageView *)firstContactIMGView
{
    if (!_firstContactIMGView) {
        _firstContactIMGView = [[UIImageView alloc]init];
    }
    return _firstContactIMGView;
}

-(UILabel *)firstContactNameLab
{
    if (!_firstContactNameLab)
    {
        _firstContactNameLab = [[UILabel alloc]init];
        _firstContactNameLab.backgroundColor = [UIColor whiteColor];
        _firstContactNameLab.textAlignment = NSTextAlignmentLeft;
        _firstContactNameLab.textColor = [UIColor blackColor];
        _firstContactNameLab.font = [UIFont systemFontOfSize:15];
    }
    return _firstContactNameLab;
}

-(UILabel *)firstContactPhoneLab
{
    if (!_firstContactPhoneLab)
    {
        _firstContactPhoneLab = [[UILabel alloc]init];
        _firstContactPhoneLab.backgroundColor = [UIColor whiteColor];
        _firstContactPhoneLab.textAlignment = NSTextAlignmentLeft;
        _firstContactPhoneLab.textColor = [UIColor blackColor];
        _firstContactPhoneLab.font = [UIFont systemFontOfSize:12];
    }
    return _firstContactPhoneLab;
}

-(UIImageView *)secondContactIMGView
{
    if (!_secondContactIMGView) {
        _secondContactIMGView = [[UIImageView alloc]init];
    }
    return _secondContactIMGView;
}

-(UILabel *)secondContactNameLab
{
    if (!_secondContactNameLab)
    {
        _secondContactNameLab = [[UILabel alloc]init];
        _secondContactNameLab.backgroundColor = [UIColor whiteColor];
        _secondContactNameLab.textAlignment = NSTextAlignmentLeft;
        _secondContactNameLab.textColor = [UIColor blackColor];
        _secondContactNameLab.font = [UIFont systemFontOfSize:15];
    }
    return _secondContactNameLab;
}

-(UILabel *)secondContactPhoneLab
{
    if (!_secondContactPhoneLab)
    {
        _secondContactPhoneLab = [[UILabel alloc]init];
        _secondContactPhoneLab.backgroundColor = [UIColor whiteColor];
        _secondContactPhoneLab.textAlignment = NSTextAlignmentLeft;
        _secondContactPhoneLab.textColor = [UIColor blackColor];
        _secondContactPhoneLab.font = [UIFont systemFontOfSize:12];
    }
    return _secondContactPhoneLab;
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
@end

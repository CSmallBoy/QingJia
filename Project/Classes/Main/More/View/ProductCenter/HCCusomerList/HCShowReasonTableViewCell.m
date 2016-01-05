//
//  HCShowReasonTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/31.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCShowReasonTableViewCell.h"
#import "HCCustomerInfo.h"
#import "UILabel+HCLabelContentSize.h"
@interface HCShowReasonTableViewCell ()

@property (nonatomic,strong) UILabel *reasonLab;
@property (nonatomic,strong) UIView *IMGView;

@end

@implementation HCShowReasonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.reasonLab];
        [self.contentView addSubview:self.IMGView];
    }
    return self;
}

-(void)setInfo:(HCCustomerInfo *)info
{
    _info = info;
    _reasonLab.text = [NSString stringWithFormat:@"  原因描述:%@",self.info.detailReason];
    for (int i = 0; i< self.info.imgArr.count; i++)
    {
        UIImageView *image = [[UIImageView alloc]initWithImage:OrigIMG(self.info.imgArr[i])];
        image.frame = CGRectMake((SCREEN_WIDTH-40)/3*i+(i+1)*10,5,(SCREEN_WIDTH-40)/3 , (SCREEN_WIDTH-40)/3);
        [_IMGView addSubview:image];
    }
    
    
    [_reasonLab setFrame:CGRectMake(0, 10, SCREEN_WIDTH, [_reasonLab contentSize].height)];
    _IMGView.frame = CGRectMake(0, _reasonLab.frame.size.height+20, SCREEN_WIDTH, SCREEN_WIDTH/3);
    if ([self.delegate respondsToSelector:@selector(passcellHight:)])
    {
        [self.delegate passcellHight:(_reasonLab.frame.size.height+20+SCREEN_WIDTH/3)];
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(UIView *)IMGView
{
    if (!_IMGView)
    {
        _IMGView = [[UIView alloc]init];
    }
    return _IMGView;
}

-(UILabel *)reasonLab
{
    if (!_reasonLab)
    {
        _reasonLab = [[UILabel alloc]init];
        _reasonLab.textAlignment = NSTextAlignmentLeft;
        _reasonLab.font = [UIFont systemFontOfSize:15];
        _reasonLab.numberOfLines = 0;
        _reasonLab.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _reasonLab;
}
@end

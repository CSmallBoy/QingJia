//
//  HCShowReasonTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/31.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCShowReasonTableViewCell.h"
#import "HCCustomerInfo.h"

@interface HCShowReasonTableViewCell ()

@property (nonatomic,strong) UITextView *reasonTextview;
@property (nonatomic,strong) UIView *IMGView;

@end

@implementation HCShowReasonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.reasonTextview];
        [self.contentView addSubview:self.IMGView];
    }
    return self;
}

-(void)setInfo:(HCCustomerInfo *)info
{
    _info = info;
    _reasonTextview.text = [NSString stringWithFormat:@"原因描述:%@",self.info.detailReason];
    for (int i = 0; i< self.info.imgArr.count; i++)
    {
        UIImageView *image = [[UIImageView alloc]initWithImage:OrigIMG(self.info.imgArr[i])];
        image.frame = CGRectMake(SCREEN_WIDTH/3*i,0,SCREEN_WIDTH/3 , SCREEN_WIDTH/3);
        [_IMGView addSubview:image];
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _reasonTextview.frame = CGRectMake(0, 0, SCREEN_WIDTH,100);
    _IMGView.frame = CGRectMake(0, 110, SCREEN_WIDTH, SCREEN_WIDTH/3);
}

-(UIView *)IMGView
{
    if (!_IMGView)
    {
        _IMGView = [[UIView alloc]init];
        _IMGView.backgroundColor = [UIColor yellowColor];
    }
    return _IMGView;
}

-(UITextView *)reasonTextview
{
    if (!_reasonTextview)
    {
        _reasonTextview = [[UITextView alloc]init];
        _reasonTextview.textAlignment = NSTextAlignmentLeft;
        _reasonTextview.font = [UIFont systemFontOfSize:15];
        _reasonTextview.editable = NO;
    }
    return _reasonTextview;
}
@end

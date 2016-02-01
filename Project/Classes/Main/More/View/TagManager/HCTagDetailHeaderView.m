//
//  HCTagDetailHeaderView.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagDetailHeaderView.h"

@implementation HCTagDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self addSubview:self.tagIMGView];
        [self addSubview:self.tagNameLab];
        [self addSubview:self.tagIDLab];
    }
    return self;
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


@end

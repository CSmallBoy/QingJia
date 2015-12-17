//
//  HCHomeTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HCFunctionTagView.h"
#import "HCHomeInfo.h"
#import "HCHomeMoreImgView.h"
#import "HCHomeMoreImgView.h"

@interface HCHomeTableViewCell()<HCHomeMoreImgViewDelegate, HCFunctionTagViewDelegate>

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *deveceModel;
@property (nonatomic, strong) UILabel *times;
@property (nonatomic, strong) UILabel *contents;

@property (nonatomic, strong) UIImageView *addressImgView;
@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) HCFunctionTagView *functionTagView;
@property (nonatomic, strong) HCHomeMoreImgView *moreImgView;

@end

@implementation HCHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.nickName];
        [self.contentView addSubview:self.deveceModel];
        [self.contentView addSubview:self.times];
        [self.contentView addSubview:self.contents];
        [self.contentView addSubview:self.addressImgView];
        [self.contentView addSubview:self.address];
        [self.contentView addSubview:self.functionTagView];
        [self.contentView addSubview:self.moreImgView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImgView.frame = CGRectMake(10, 10, WIDTH(self)*0.15, WIDTH(self)*0.15);
    ViewRadius(self.headImgView, WIDTH(self.headImgView)*0.5);
    
    self.nickName.frame = CGRectMake(MaxX(self.headImgView)+10, HEIGHT(self.headImgView)*0.3, 100, 20);
    self.deveceModel.frame = CGRectMake(MaxX(self.headImgView)+10, MaxY(self.nickName), 100, 20);
    
    self.times.frame = CGRectMake(WIDTH(self)-120, MinY(self.nickName), 110, 20);
    
    CGFloat contentsHeight = [Utils detailTextHeight:_info.contents lineSpage:4 width:WIDTH(self)-20 font:14];
    self.contents.frame = CGRectMake(10, MaxY(self.headImgView)+5, WIDTH(self)-20, contentsHeight);
    
    // 图片
    if (!IsEmpty(_info.imgArr))
    {
        CGFloat height = (WIDTH(self)-30) / 3;
        self.moreImgView.frame = CGRectMake(0, MaxY(self.contents)+10, WIDTH(self), height);
    }
    // 地址
    if (!IsEmpty(_info.imgArr))
    {
        if (!IsEmpty(_info.address))
        {
            self.addressImgView.frame = CGRectMake(10, MaxY(self.moreImgView)+5, 15, 20);
            self.address.frame = CGRectMake(MaxX(self.addressImgView)+5, MaxY(self.moreImgView)+5, WIDTH(self)-40, 20);
        }
    }else
    {
        self.addressImgView.frame = CGRectMake(10, MaxY(self.contents)+10, 15, 20);
        self.address.frame = CGRectMake(MaxX(self.addressImgView)+10, MaxY(self.contents)+10, WIDTH(self)-40, 20);
    }
    
    self.functionTagView.frame = CGRectMake(0, self.contentView.frame.size.height-30, WIDTH(self), 30);
}

#pragma mark - HCHomeMoreImgViewDelegate

- (void)hchomeMoreImgView:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(hcHomeTableViewCell:indexPath:moreImgView:)])
    {
        [self.delegate hcHomeTableViewCell:self indexPath:_indexPath moreImgView:index];
    }
}

#pragma mark - HCFunctionTagViewDelegate

- (void)hcfunctionTagViewButtonIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(hcHomeTableViewCell:indexPath:functionIndex:)])
    {
        [self.delegate hcHomeTableViewCell:self indexPath:_indexPath functionIndex:index];
    }
}

- (void)setInfo:(HCHomeInfo *)info
{
    _info = info;
    
    if (!IsEmpty(info.imgName))
    {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:info.imgName] placeholderImage:OrigIMG(@"Head-Portraits")];
    }
    
    self.nickName.text = info.nickName;
    self.times.text = [Utils transformServerDate:[info.inputtime integerValue]];
    self.deveceModel.text = [NSString stringWithFormat:@"来至:%@", info.deviceModel];
    
    // 内容设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:info.contents];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, info.contents.length)];
    self.contents.attributedText = attributedString;
    
    // 图片
    if (!IsEmpty(info.imgArr))
    {
        self.moreImgView.hidden = NO;
        [self.moreImgView hchomeMoreImgViewWithUrlStringArray:info.imgArr];
    }else
    {
        self.moreImgView.hidden = YES;
    }
    
    // 地址
    if (!IsEmpty(info.address))
    {
        self.address.hidden = NO;
        self.addressImgView.hidden = NO;
        self.address.text = info.address;
    }else
    {
        self.address.hidden = YES;
        self.addressImgView.hidden = YES;
    }
    
    NSString *zanNum = ([info.zan integerValue]) ? info.zan : @"点赞";
    NSString *commentNum = ([info.comments integerValue]) ? info.comments : @"评论";
    
    NSArray *functionArr = @[@[@"Like_nor", zanNum],
                             @[@"label_nor", @"标记"],
                             @[@"Share_nor", @"分享"],
                             @[@"Bubble_nor", commentNum]];
    [self.functionTagView functionTagWithArrary:functionArr];
}

#pragma mark - setter or getter 

- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [[UIImageView alloc] init];
    }
    return _headImgView;
}

- (UILabel *)nickName
{
    if (!_nickName)
    {
        _nickName = [[UILabel alloc] init];
        _nickName.font = [UIFont systemFontOfSize:16];
        _nickName.textColor = DarkGrayColor;
    }
    return _nickName;
}

- (UILabel *)deveceModel
{
    if (!_deveceModel)
    {
        _deveceModel = [[UILabel alloc] init];
        _deveceModel.textColor = LightGraryColor;
        _deveceModel.font = [UIFont systemFontOfSize:12];
    }
    return _deveceModel;
}

- (UILabel *)times
{
    if (!_times)
    {
        _times = [[UILabel alloc] init];
        _times.textColor = LightGraryColor;
        _times.textAlignment = NSTextAlignmentRight;
        _times.font = [UIFont systemFontOfSize:13];
    }
    return _times;
}

- (UILabel *)contents
{
    if (!_contents)
    {
        _contents = [[UILabel alloc] init];
        _contents.textColor = DarkGrayColor;
        _contents.lineBreakMode = NSLineBreakByCharWrapping;
        _contents.font = [UIFont systemFontOfSize:14];
        _contents.numberOfLines = 0;
    }
    return _contents;
}

- (UIImageView *)addressImgView
{
    if (!_addressImgView)
    {
        _addressImgView = [[UIImageView alloc] init];
        _addressImgView.image = OrigIMG(@"time_Pointer_dis");
    }
    return _addressImgView;
}

- (UILabel *)address
{
    if (!_address)
    {
        _address = [[UILabel alloc] init];
        _address.textColor = DarkGrayColor;
        _address.font = [UIFont systemFontOfSize:15];
    }
    return _address;
}

- (HCFunctionTagView *)functionTagView
{
    if (!_functionTagView)
    {
        _functionTagView = [[HCFunctionTagView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _functionTagView.delegate = self;
    }
    return _functionTagView;
}

- (HCHomeMoreImgView *)moreImgView
{
    if (!_moreImgView)
    {
        CGFloat width = (SCREEN_WIDTH - 40) / 3;
        _moreImgView = [[HCHomeMoreImgView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _moreImgView.delegate = self;
    }
    return _moreImgView;
}



@end

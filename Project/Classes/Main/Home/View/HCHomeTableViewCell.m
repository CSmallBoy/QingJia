//
//  HCHomeTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "HCFunctionTagView.h"
#import "HCHomeInfo.h"
//#import "HCHomeMoreImgView.h"
#import "HCShowMoreImage.h"

@interface HCHomeTableViewCell()<HCFunctionTagViewDelegate, HCHomeMoreImgViewDelegate>

@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *deveceModel;
@property (nonatomic, strong) UILabel *times;
@property (nonatomic, strong) UILabel *contents;

@property (nonatomic, strong) UIImageView *addressImgView;
@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) HCFunctionTagView *functionTagView;
//@property (nonatomic, strong) HCHomeMoreImgView *moreImgView;
@property (nonatomic, strong) HCShowMoreImage *moreImgView;

@end

@implementation HCHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.headButton];
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
    
    self.headButton.frame = CGRectMake(10, 10, WIDTH(self)*0.15, WIDTH(self)*0.15);
    ViewRadius(self.headButton, WIDTH(self.headButton)*0.5);
    
    self.nickName.frame = CGRectMake(MaxX(self.headButton)+10, HEIGHT(self.headButton)*0.3, 100, 20);
    self.deveceModel.frame = CGRectMake(MaxX(self.headButton)+10, MaxY(self.nickName), 200, 20);
    
    self.times.frame = CGRectMake(WIDTH(self)-120, MinY(self.nickName), 115, 20);
    
    CGFloat contentsHeight = [Utils detailTextHeight:_info.FTContent lineSpage:4 width:WIDTH(self)-20 font:14];
    self.contents.frame = CGRectMake(10, MaxY(self.headButton)+5, WIDTH(self)-20, contentsHeight);
    
    // 图片
    if (!IsEmpty(_info.FTImages))
    {
        CGFloat height = 0;
        if (_info.FTImages.count < 5)
        {
            NSInteger row = ((int)_info.FTImages.count/3) +1;
            height = WIDTH(self) * 0.33 * row;
        }else
        {
            NSInteger row = ((int)MIN(_info.FTImages.count, 9)/3.5) + 1;
            height = WIDTH(self) * 0.33 * row;
        }
        self.moreImgView.frame = CGRectMake(0, MaxY(self.contents), WIDTH(self), height);
    }
    // 地址
    if (!IsEmpty(_info.FTImages))
    {
        if (!IsEmpty(_info.CreateAddrSmall))
        {
            self.addressImgView.frame = CGRectMake(10, MaxY(self.moreImgView)+10, 15, 20);
            self.address.frame = CGRectMake(MaxX(self.addressImgView)+10, MaxY(self.moreImgView)+10, WIDTH(self)-40, 20);
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

#pragma mark - private methods

- (void)handleHeadButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcHomeTableViewCell:indexPath:seleteHead:)])
    {
        [self.delegate hcHomeTableViewCell:self indexPath:_indexPath seleteHead:button];
    }
}

#pragma mark - setter or getter

- (void)setInfo:(HCHomeInfo *)info
{
    _info = info;
    
    if (!IsEmpty(info.HeadImg))
    {
        //头像的url
        
        [self.headButton sd_setImageWithURL:[readUserInfo url:info.HeadImg :kkUser] forState:UIControlStateNormal placeholderImage:OrigIMG(@"Head-Portraits")];
        
    }else
    {
        [self.headButton setImage:OrigIMG(@"Head-Portraits") forState:UIControlStateNormal];
    }
    //时光头像设置
    //[self.headButton setImage:OrigIMG(@"1.png") forState:UIControlStateNormal];
    self.nickName.text = info.NickName;
    NSDate *date = [Utils getDateWithString:info.CreateTime format:@"yyyy-MM-dd HH:mm:ss"];
    self.times.text = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd HH:mm"];
    // 手机来源
    //    self.deveceModel.text = [NSString stringWithFormat:@"来至:%@", info.deviceModel];
    self.deveceModel.text = [NSString stringWithFormat:@"来至:%@",info.fromFamily];
    
    // 内容设置行间距
    if (!IsEmpty(info.FTContent))
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:info.FTContent];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, info.FTContent.length)];
        self.contents.attributedText = attributedString;
    }
    
    // 图片
    if (!IsEmpty(info.FTImages))
    {
        //图片在这里赋值
        self.moreImgView.hidden = NO;
        self.moreImgView.imageUrlArr = info.FTImages;
        //        [self.moreImgView hchomeMoreImgViewWithUrlStringArray:info.FTImages];
    }else
    {
        self.moreImgView.hidden = YES;
    }
    // 地址
    if (!IsEmpty(info.CreateAddrSmall))
    {
        self.address.hidden = NO;
        self.addressImgView.hidden = NO;
        self.address.text = info.CreateAddrSmall;
    }else
    {
        self.address.hidden = YES;
        self.addressImgView.hidden = YES;
    }
    NSString *zanNum = ([info.likeCount integerValue]) ? info.likeCount : @"点赞";
    //有评论显示 数字
    NSString *commentNum = ([info.FTReplyCount integerValue]) ? info.FTReplyCount : @"评论";
    NSArray *functionArr;
    if ([info.isLike isEqualToString:@"0"]){
        if ([commentNum isEqualToString:@"评论"]) {
            functionArr = @[@[@"like_1", zanNum],
                            @[@"share_1", @"分享"],
                            @[@"comment_1", commentNum]];
        }else{
            functionArr = @[@[@"like_1", zanNum],
                            @[@"share_1", @"分享"],
                            @[@"comment_2", commentNum]];
        }
    }else{
        
        if ([commentNum isEqualToString:@"评论"]) {
            functionArr = @[@[@"like_2", zanNum],
                            @[@"share_2", @"分享"],
                            @[@"comment_1", commentNum]];
        }else{
            functionArr = @[@[@"like_2", zanNum],
                            @[@"share_2", @"分享"],
                            @[@"comment_2", commentNum]];
        }
        
    }
    [self.functionTagView functionTagWithArrary:functionArr];
}

#pragma mark - setter or getter

- (UIButton *)headButton
{
    if (!_headButton)
    {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headButton setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
        [_headButton addTarget:self action:@selector(handleHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headButton;
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

//- (HCHomeMoreImgView *)moreImgView
//{
//    if (!_moreImgView)
//    {
//        CGFloat width = (SCREEN_WIDTH - 40) / 3;
//        _moreImgView = [[HCHomeMoreImgView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
//        _moreImgView.delegates = self;
//    }
//    return _moreImgView;
//}

- (HCShowMoreImage *)moreImgView
{
    if (!_moreImgView)
    {
        _moreImgView = [[HCShowMoreImage alloc] init];
        _moreImgView.delegate = self;
    }
    return _moreImgView;
}


@end

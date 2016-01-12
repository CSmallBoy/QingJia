//
//  HCHomeDetailCommentTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeDetailCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "HCHomeInfo.h"
#import "MLEmojiLabel.h"

@interface HCHomeDetailCommentTableViewCell()<MLEmojiLabelDelegate>

@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *times;
@property (nonatomic, strong) MLEmojiLabel *commentLable;

@end

@implementation HCHomeDetailCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.headButton];
        [self.contentView addSubview:self.nickName];
        [self.contentView addSubview:self.times];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.commentLable];
    }
    return self;
}

#pragma mark - MLEmojiLabelDelegate

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
}

#pragma mark - Private methods

- (void)handleCommentButton
{
    if ([self.delegate respondsToSelector:@selector(hchomeDetailCommentTableViewCellCommentButton)])
    {
        [self.delegate hchomeDetailCommentTableViewCellCommentButton];
    }
}

#pragma mark - setter or getter

- (void)setInfo:(HCHomeInfo *)info
{
    _info = info;
    
    if (!IsEmpty(info.HeadImg))
    {
        [self.headButton sd_setImageWithURL:[NSURL URLWithString:info.HeadImg] forState:UIControlStateNormal placeholderImage:OrigIMG(@"Head-Portraits")];
    }else
    {
        [self.headButton setImage:OrigIMG(@"Head-Portraits") forState:UIControlStateNormal];
    }
    
    self.nickName.text = info.NickName;
    self.times.text = info.CreateTime;
    self.commentLable.text = info.FTContent;
    
    self.headButton.frame = CGRectMake(10, 10, 40, 40);
    ViewRadius(self.headButton, 20);
    
    self.nickName.frame = CGRectMake(MaxX(self.headButton)+10, 12, 150, 20);
    self.times.frame = CGRectMake(MaxX(self.headButton)+10, MaxY(self.nickName), 140, 20);
    self.commentBtn.frame = CGRectMake(SCREEN_WIDTH-80, 15, 70, 30);
    
    CGSize size = [self.commentLable preferredSizeWithMaxWidth:SCREEN_WIDTH-70];
    self.commentLable.frame = CGRectMake(MaxX(self.headButton)+10, MaxY(self.times), SCREEN_WIDTH-70, size.height);
    if ([self.delegate respondsToSelector:@selector(hchomeDetailCommentTableViewCellCommentHeight:)])
    {
        [self.delegate hchomeDetailCommentTableViewCellCommentHeight:size.height];
    }
}

- (UIButton *)headButton
{
    if (!_headButton)
    {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
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

- (UILabel *)times
{
    if (!_times)
    {
        _times = [[UILabel alloc] init];
        _times.textColor = LightGraryColor;
        _times.font = [UIFont systemFontOfSize:13];
    }
    return _times;
}

- (MLEmojiLabel *)commentLable
{
    if (!_commentLable)
    {
        _commentLable = [MLEmojiLabel new];
        _commentLable.numberOfLines = 0;
        _commentLable.font = [UIFont systemFontOfSize:14.0f];
        _commentLable.delegate = self;
        _commentLable.textAlignment = NSTextAlignmentLeft;
        _commentLable.backgroundColor = [UIColor clearColor];
        _commentLable.isNeedAtAndPoundSign = YES;
    }
    return _commentLable;
}

- (UIButton *)commentBtn
{
    if (!_commentBtn)
    {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn addTarget:self action:@selector(handleCommentButton) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:OrigIMG(@"Comment_but_Bubbles")];
        imgView.frame = CGRectMake(0, 0, 20, 20);
        [_commentBtn addSubview:imgView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 40, 20)];
        label.text = @"回复";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [_commentBtn addSubview:label];
    }
    return _commentBtn;
}

@end

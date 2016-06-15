//
//  HCTimePushListCell.m
//  钦家
//
//  Created by Tony on 16/6/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTimePushListCell.h"

#import "UIButton+WebCache.h"

@interface HCTimePushListCell ()

@property (nonatomic, strong) UIButton *headButton;//头像
@property (nonatomic, strong) UILabel *nickNameLabel;//昵称
@property (nonatomic, strong) UIImageView *commentImage;//点赞图片
@property (nonatomic, strong) UILabel *contectLabel;//评论内容
@property (nonatomic, strong) UILabel *timeLabel;//评论时间
@property (nonatomic, strong) UILabel *timesContectLabel;//被评论的时光内容
@property (nonatomic, strong) UIImageView *imageComment;//被评论的图片

@end


@implementation HCTimePushListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    [self removeAllSubviews];
    [self addSubview:self.headButton];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.commentImage];
    [self addSubview:self.contectLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.timesContectLabel];
    [self addSubview:self.imageComment];
}

- (void)setInfo:(HCTimePushListInfo *)info
{
    _info = info;
    NSURL *url = [readUserInfo originUrl:info.imageName :kkUser];
    [self.headButton sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:IMG(@"")];
    self.nickNameLabel.text = info.nickName;
    self.timeLabel.text = info.createTime;
    if ([info.type isEqualToString:@"0"])//时光评论
    {
        self.commentImage.hidden = YES;
        self.imageComment.hidden = YES;
        self.contectLabel.text = info.cText;
        self.timesContectLabel.text = info.contentText;
    }
    else if ([info.type isEqualToString:@"1"])//单图评论
    {
        self.commentImage.hidden = YES;
        self.timesContectLabel.hidden = YES;
        self.contectLabel.text = info.cText;
        NSURL *imageurl = [readUserInfo originUrl:info.contentImageName :kkTimes];
        [self.imageComment sd_setImageWithURL:imageurl placeholderImage:IMG(@"")];
    }
    else//点赞
    {
        self.contectLabel.hidden = YES;
        self.imageComment.hidden = YES;
        self.timesContectLabel.text = info.contentText;
    }
}

- (UIButton *)headButton
{
    if (_headButton == nil)
    {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.frame = CGRectMake(10, 10, 60, 60);
        _headButton.userInteractionEnabled = NO;
        _headButton.backgroundColor = [UIColor blackColor];
    }
    return _headButton;
}

- (UILabel *)nickNameLabel
{
    if (_nickNameLabel == nil)
    {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.headButton) + 10, MinY(self.headButton), SCREEN_WIDTH - 90 - MaxX(self.headButton), 15)];
    }
    return _nickNameLabel;
}

- (UIImageView *)commentImage
{
    if (_commentImage == nil)
    {
        _commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(MinX(self.nickNameLabel), MaxY(self.nickNameLabel)+7.5, 15, 15)];
        _commentImage.image = IMG(@"like_2");
    }
    return _commentImage;
}

- (UILabel *)contectLabel
{
    if (_contectLabel == nil)
    {
        _contectLabel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.nickNameLabel), MaxY(self.nickNameLabel)+7.5, WIDTH(self.nickNameLabel), 15)];
        _contectLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contectLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.nickNameLabel), MaxY(self.contectLabel)+7.5, WIDTH(self.nickNameLabel), 15)];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UILabel *)timesContectLabel
{
    if (_timesContectLabel == nil)
    {
        _timesContectLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.nickNameLabel)+5, 5, 70, 70)];
        _timesContectLabel.numberOfLines = 0;
        _timesContectLabel.font = [UIFont systemFontOfSize:15];
    }
    return _timesContectLabel;
}

- (UIImageView *)imageComment
{
    if (_imageComment == nil)
    {
        _imageComment = [[UIImageView alloc] initWithFrame:CGRectMake(MaxX(self.nickNameLabel)+5, 5, 70, 70)];
        _imageComment.backgroundColor = [UIColor redColor];
    }
    return _imageComment;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end

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
#import "HCEditCommentViewController.h"
//时光评论详情的cell
@interface HCHomeDetailCommentTableViewCell()<MLEmojiLabelDelegate>

@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *times;
@property (nonatomic, strong) UIView *CommentView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UILabel *huifu;
@property (nonatomic, strong) UILabel *label;
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
        //[self.delegate hchomeDetailCommentTableViewCellCommentButton];
        [self commentTime];
    }else{
        NSLog(@"触发了");
        //这个地方触发   弹出回复评论
        [self commentSingle];
    }

}
-(void)commentTime{
    //评论界面
    HCEditCommentViewController *editComment = [[HCEditCommentViewController alloc] init];
    //editComment.data = @{@"data": _info,@"index":self.data[@"index"]};
    UIViewController *rootController = self.superview.window.rootViewController;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        editComment.modalPresentationStyle=
        UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
    }else
    {
        rootController.modalPresentationStyle=
        UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
    }
    editComment.all_coment_to = @"评论时光的回复";
    NSString *str  = [NSString stringWithFormat:@"%ld",self.indexpath.row];
    editComment.num_P = str;
    editComment.image_name = _image_name;
    //editComment.infomodel = _info;
    editComment.time_id = _timeID;
    editComment.commentId = self.info.commentId;
    editComment.touser = _toUSer;
    //需要传过来的数据啊
    [rootController presentViewController:editComment animated:YES completion:nil];
}
//数据没写  等会再验证
-(void)commentSingle{                                                                                                      
    //评论界面
    HCEditCommentViewController *editComment = [[HCEditCommentViewController alloc] init];
    //editComment.data = @{@"data": _info,@"index":self.data[@"index"]};
    UIViewController *rootController = self.superview.window.rootViewController;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        editComment.modalPresentationStyle=
        UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
    }else
    {
        rootController.modalPresentationStyle=
        UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
    }
    editComment.single = @"评论单图的回复";
    NSString *str  = [NSString stringWithFormat:@"%ld",self.indexpath.row];
    editComment.num_P = str;
    editComment.image_name = _image_name;
    //editComment.infomodel = _info;
    editComment.time_id = _timeID;
    editComment.commentId = self.info.commentId;
    editComment.touser = self.info.TOUSER;
    //需要传过来的数据啊
    [rootController presentViewController:editComment animated:YES completion:nil];

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
    self.times.text = [info.CreateTime substringToIndex:16];
    self.commentLable.text = info.FTContent;

    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
  
    //默认的注释
    //[_headButton setImage:IMG(@"1.png") forState:UIControlStateNormal];
    [_headButton sd_setImageWithURL:[readUserInfo url:_info.fromImageName :kkUser] forState:UIControlStateNormal];
    self.headButton.frame = CGRectMake(10, 10, 40, 40);
    ViewRadius(self.headButton, 20);
    
    self.nickName.frame = CGRectMake(MaxX(self.headButton)+10, 12, 150, 20);
    self.times.frame = CGRectMake(MaxX(self.headButton)+10, MaxY(self.nickName), 140, 20);
    self.commentBtn.frame = CGRectMake(SCREEN_WIDTH-80, 15, 70, 30);
    
    CGSize size = [self.commentLable preferredSizeWithMaxWidth:SCREEN_WIDTH-70];
    self.commentLable.frame = CGRectMake(MaxX(self.headButton)+10, MaxY(self.times), SCREEN_WIDTH-70, size.height);
    int  sum = 0;
    for (int i = 0 ; i < _info.subRows.count; i++) {
        //_label  =[[UILabel alloc]initWithFrame:CGRectMake(0,size.height + 2 + i * (20+3), SCREEN_WIDTH, 20)];
        _label  =[[UILabel alloc]initWithFrame:CGRectMake(0,size.height + 2 + sum, SCREEN_WIDTH, 20)];
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:_info.subRows[i][@"from"] forState:UIControlStateNormal];
        CGSize size_bu1 = [readUserInfo sizeWithString:_info.subRows[i][@"from"] :_button1];
        [_button1 setFrame:CGRectMake(0, 0, size_bu1.width, 18)];
        [_button1 setTitleColor:[UIColor colorWithRed:100/255.0 green:179/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:14];
        

        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:_info.TOUSER  forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor colorWithRed:100/255.0 green:179/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        //[_button2 setFrame:CGRectMake(65, 0, 40, 18)];
        CGSize size_bu2 = [readUserInfo sizeWithString:_info.TOUSER  :_button2];
        [_button2 setFrame:CGRectMake(size_bu1.width + 2 +30, 0, size_bu2.width, 18)];
        _button2.titleLabel.font = [UIFont systemFontOfSize:14];
        _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
     
        _huifu  = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, 18, 18)];
        _huifu.frame = CGRectMake(size_bu1.width + 1, 0, 30, 18);
        _huifu.font = [UIFont systemFontOfSize:14];
        _huifu.text = @"回复";
        _huifu.textAlignment = NSTextAlignmentCenter;
        //要自适应
        UILabel *Sonlabel = [[UILabel alloc]init];
        Sonlabel.text = _info.subRows[i][@"content"];
        Sonlabel.font = [UIFont systemFontOfSize:14];
        Sonlabel.numberOfLines = 0;
        CGSize size = CGSizeMake(_label.bounds.size.width-120, MAXFLOAT);
        CGSize labelsize = [_info.subRows[i][@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
        Sonlabel.frame = CGRectMake(_button2.frame.size.width + _button1.bounds.size.width + 30 + 4, 0, _label.bounds.size.width - _button2.frame.size.width - _button1.bounds.size.width - 30 - 4 -20-45, labelsize.height);
        NSString *str = [NSString stringWithFormat:@"%f",labelsize.height];
        int b = [str intValue];
        sum += b;
        [_label addSubview:Sonlabel];
        [_label addSubview:self.huifu];
        [_label addSubview:self.button1];
        [_label addSubview:self.button2];
        [_commentLable addSubview:self.label];
        
    }
    if ([self.delegate respondsToSelector:@selector(hchomeDetailCommentTableViewCellCommentHeight:)])
    {
        //这个地方修改高度
//        [self.delegate hchomeDetailCommentTableViewCellCommentHeight:size.height + 23 *_info.subRows.count];
        [self.delegate hchomeDetailCommentTableViewCellCommentHeight:size.height + sum];
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

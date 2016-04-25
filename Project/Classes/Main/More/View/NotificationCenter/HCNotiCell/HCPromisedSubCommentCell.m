//
//  HCPromisedCommentCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedSubCommentCell.h"
#import "HCPromisedCommentFrameInfo.h"
#import "HCPromisedCommentInfo.h"

// -------------------------------------留言子评论cell----------------------------------------

@interface HCPromisedSubCommentCell ()
{
     CGRect  commentRect;
}
@property (nonatomic,strong) UIButton  *headBtn;
@property (nonatomic,strong) UILabel   *nickLabel;
@property (nonatomic,strong) UILabel   *commentLabel;
@property (nonatomic,strong) UILabel   *backLabel;
@property (nonatomic,strong) UILabel   *timeLabel;
@property (nonatomic,strong) UIButton  *button1;
@property (nonatomic,strong) UIButton  *button2;
@property (nonatomic,strong) UIButton  *button3;
@property (nonatomic,strong) UITextField  *redTextField;
@end


@implementation HCPromisedSubCommentCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
   static  NSString  * ID = @"SubcommentCell";
    HCPromisedSubCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HCPromisedSubCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
   
    return cell;

}

#pragma mark --- private mothods

// 添加子控件
-(void)addSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self addSubview: self.headBtn];
    [self addSubview:self.nickLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.backLabel];
    [self addSubview:self.commentLabel];
    [self addSubview:self.button1];
    [self addSubview:self.button2];
    [self addSubview:self.button3];

}
//点击了头像
-(void)headBtnClick:(UIButton *)button
{
   

}

//点击了图片
-(void)imageBtnClick:(UIButton *)button

{
      self.block (button);
}

#pragma mark --- getter Or setter

-(void)setCommnetFrameInfo:(HCPromisedCommentFrameInfo *)commnetFrameInfo
{
    _commnetFrameInfo = commnetFrameInfo;

    self.headBtn.frame = commnetFrameInfo.headBtnFrame;
    
    self.nickLabel.frame = commnetFrameInfo.nickLabelFrame;
    self.nickLabel.text = commnetFrameInfo.commentInfo.nickName;
    
    self.timeLabel.frame = commnetFrameInfo.timeLabelFrame;
    self.timeLabel.text = commnetFrameInfo.commentInfo.createTime;
    
    self.backLabel.frame = commnetFrameInfo.backLabelFrame;
    
    self.commentLabel.frame = commnetFrameInfo.commentLabelFrame;
    NSString *str = [NSString stringWithFormat:@"%@回复%@:%@",commnetFrameInfo.commentInfo.nickName,commnetFrameInfo.commentInfo.toNickName,commnetFrameInfo.commentInfo.content];
    self.commentLabel.text = str;
    
    self.button1.frame = commnetFrameInfo.button1Frame;

    
    self.button2.frame = commnetFrameInfo.button2Frame;

    
    self.button3.frame = commnetFrameInfo.button3Frame;



}

- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_headBtn setBackgroundImage:IMG(@"1.png") forState:UIControlStateNormal];
        ViewRadius(_headBtn, 25);
        [_headBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}


- (UILabel *)nickLabel
{
    if(!_nickLabel){
        _nickLabel = [[UILabel alloc]init];
        _nickLabel.font = [UIFont systemFontOfSize:14];
        _nickLabel.textColor = [UIColor grayColor];
    }
    return _nickLabel;
}


- (UILabel *)commentLabel
{
    if(!_commentLabel){
        
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}


- (UILabel *)backLabel
{
    if(!_backLabel){
        _backLabel = [[UILabel alloc]init];
        _backLabel.font = [UIFont systemFontOfSize:15];
        _backLabel.textColor = [UIColor grayColor];
        _backLabel.text = @"回复";
    }
    return _backLabel;
}



- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor blackColor];
    }
    return _timeLabel;
}


- (UIButton *)button1
{
    if(!_button1){
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setBackgroundImage:IMG(@"1.png") forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2
{
    if(!_button2){
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setBackgroundImage:IMG(@"1.png") forState:UIControlStateNormal];
        [_button2 addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}
- (UIButton *)button3
{
    if(!_button3){
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setBackgroundImage:IMG(@"1.png") forState:UIControlStateNormal];
        [_button3 addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}



- (UITextField *)redTextField
{
    if(!_redTextField){
        _redTextField = [[UITextField alloc]init];
        _redTextField.layer.borderWidth = 1;
        _redTextField.layer.borderColor = kHCNavBarColor.CGColor;
        _redTextField.placeholder = @"评论";
    }
    return _redTextField;
}


@end

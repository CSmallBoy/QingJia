//
//  HCPromisedCommentCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedCommentCell.h"
#import "HCPromisedCommentFrameInfo.h"
#import "HCPromisedCommentInfo.h"

// -------------------------------------留言评论cell----------------------------------------

@interface HCPromisedCommentCell ()<UITextFieldDelegate>
{
     CGRect  commentRect;
}
@property (nonatomic,strong) UIButton  *headBtn;
@property (nonatomic,strong) UILabel   *nickLabel;
@property (nonatomic,strong) UILabel   *commentLabel;
@property (nonatomic,strong) UILabel   *timeLabel;
@property (nonatomic,strong) UIButton  *button1;
@property (nonatomic,strong) UIButton  *button2;
@property (nonatomic,strong) UIButton  *button3;
@property (nonatomic,strong) UIButton  *redTextField;

@property (nonatomic,strong) NSArray   *btnArr;

@end


@implementation HCPromisedCommentCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
   static  NSString  * ID = @"commentCell";
    HCPromisedCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HCPromisedCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    [self addSubview:self.commentLabel];
    
    self.btnArr = @[self.button1,self.button2,self.button3];
    
    [self addSubview:self.redTextField];

}
//点击了头像
-(void)headBtnClick:(UIButton *)button
{
   

}

//点击了图片
-(void)imageBtnClick:(UIButton *)button;

{
    
    self.block (button);
}


-(void)backComment:(UIButton *)button
{
    self.subBlock(self.indexPath);
}



#pragma mark --- getter Or setter

-(void)setCommnetFrameInfo:(HCPromisedCommentFrameInfo *)commnetFrameInfo
{
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self addSubview: self.headBtn];
    [self addSubview:self.nickLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.commentLabel];
    
    self.btnArr = @[self.button1,self.button2,self.button3];
    [self addSubview:self.redTextField];
    
    _commnetFrameInfo = commnetFrameInfo;

    self.headBtn.frame = commnetFrameInfo.headBtnFrame;
    
    UIImageView *HeadIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.headBtn.frame.size.width, self.headBtn.frame.size.height)];
    NSURL *url = [readUserInfo originUrl:commnetFrameInfo.commentInfo.imageName :kkUser];
    [HeadIV sd_setImageWithURL:url placeholderImage:IMG(@"Head-Portraits")];
    [self.headBtn addSubview:HeadIV];
    
    
    self.nickLabel.frame = commnetFrameInfo.nickLabelFrame;
    self.nickLabel.text = commnetFrameInfo.commentInfo.nickName;
    
    self.timeLabel.frame = commnetFrameInfo.backLabelFrame;
    self.timeLabel.text = [commnetFrameInfo.commentInfo.createTime substringToIndex:10];
    
    self.commentLabel.frame = commnetFrameInfo.commentLabelFrame;
    self.commentLabel.text = commnetFrameInfo.commentInfo.content;
    
    
    NSArray *arr = [commnetFrameInfo.commentInfo.imageNames componentsSeparatedByString:@","];
    
    
    for (int i = 0; i<arr.count; i++) {
        
        
        UIImageView *button =self.btnArr[i];
        switch (i) {
            case 0:
                button.frame = commnetFrameInfo.button1Frame;
                break;
            case 1:
                button.frame = commnetFrameInfo.button2Frame;
                break;
            case 2:
                button.frame = commnetFrameInfo.button3Frame;
                break;
            default:
                break;
        }
        
        NSURL *url = [readUserInfo originUrl:arr[i] :kkUser];
        UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
        [imageView sd_setImageWithURL:url placeholderImage:IMG(@"Head-Portraits")];
        imageView.tag ==100;
        [button addSubview:imageView];
        
        [self addSubview:button];

    }
    self.redTextField.frame = commnetFrameInfo.readTextFildFrame;


}

- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_headBtn setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
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
        _commentLabel.font = [UIFont systemFontOfSize:15];
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}


- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}


- (UIButton *)button1
{
    if(!_button1){
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2
{
    if(!_button2){
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
        [_button2 addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}
- (UIButton *)button3
{
    if(!_button3){
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
        [_button3 addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}



- (UIButton *)redTextField
{
    if(!_redTextField){
        _redTextField = [UIButton buttonWithType:UIButtonTypeCustom];
        _redTextField.layer.borderWidth = 1;
        _redTextField.layer.borderColor = kHCNavBarColor.CGColor;
        [_redTextField addTarget:self action:@selector(backComment:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        label.text = @"评论";
        label.textColor = [UIColor lightGrayColor];
        [_redTextField addSubview:label];
    }
    return _redTextField;
}


@end

//
//  HCFeedbackView.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFeedbackView.h"
#import "HCFeedbackTextView.h"

@interface HCFeedbackView()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *titleContent;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) HCFeedbackTextView *content;

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *cancleButton;

@end

@implementation HCFeedbackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGBA(0, 0, 0, 0.6);
        [self addSubview:self.contentView];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.titleContent];
        [self.contentView addSubview:self.content];
        [self.contentView addSubview:self.sendButton];
        [self.contentView addSubview:self.cancleButton];
    }
    return self;
}


#pragma mark - setter or getter

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.2, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.6)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 20)];
        _titleLabel.textColor = DarkGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"反馈主题：";
    }
    return _titleLabel;
}

- (UITextField *)titleContent
{
    if (!_titleContent)
    {
        _titleContent = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(self.titleLabel), 5, WIDTH(self.contentView)-WIDTH(self.titleLabel), 40)];
        _titleContent.placeholder = @"点击输入反馈建议的主题";
        _titleContent.font = [UIFont systemFontOfSize:15];
    }
    return _titleContent;
}

- (UIView *)line
{
    if (!_line)
    {
        _line = [[UIView alloc] initWithFrame:CGRectMake(10, MaxY(self.titleLabel)+5, WIDTH(self.contentView)-10, 1)];
        _line.backgroundColor = RGB(220, 220, 220);
    }
    return _line;
}

- (HCFeedbackTextView *)content
{
    if (!_content)
    {
        _content = [[HCFeedbackTextView alloc] initWithFrame:CGRectMake(10, MaxY(self.line)+10, WIDTH(self.contentView)-20, HEIGHT(self.contentView)-80)];
        _content.placeholder = @"点击输入反馈建议的内容";
    }
    return _content;
}


@end

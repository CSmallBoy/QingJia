//
//  HCEditCommentView.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCEditCommentView.h"
#import "HCFeedbackTextView.h"

@interface HCEditCommentView()<HCFeedbackTextViewDelegate>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *contentTitle;

@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation HCEditCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.lineView];
        [self.lineView addSubview:self.contentText];
        [self.lineView addSubview:self.imageScrollView];
        [self addSubview:self.contentTitle];
        [self addSubview:self.saveBtn];
        [self addSubview:self.cancelBtn];
    }
    return self;
}

#pragma mark - HCFeedbackTextViewDelegate

- (void)feedbackTextViewdidBeginEditing
{
    if ([self.delegate respondsToSelector:@selector(hceditCommentViewFeedbackTextViewdidBeginEditing)])
    {
        [self.delegate hceditCommentViewFeedbackTextViewdidBeginEditing];
    }
}

- (void)feedbackTextViewdidEndEditing

{
    if ([self.delegate respondsToSelector:@selector(hceditCommentViewFeedbackTextViewdidEndEditing)])
    {
        [self.delegate hceditCommentViewFeedbackTextViewdidEndEditing];
    }
}

#pragma mark - private methods

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hceditCommentViewWithButtonIndex:)])
    {
        [self.delegate hceditCommentViewWithButtonIndex:button.tag];
    }
}

- (void)handleDeleteButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hceditCommentViewWithDeleteImageButton:)])
    {
        [self.delegate hceditCommentViewWithDeleteImageButton:button.tag];
    }
}

- (void)handleImageButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hceditCommentViewWithimageButton:)])
    {
        [self.delegate hceditCommentViewWithimageButton:button.tag];
    }
}

#pragma mark - setter or getter

- (void)setImageArr:(NSMutableArray *)imageArr
{
    [self.imageScrollView removeAllSubviews];
    
    CGFloat buttonW = HEIGHT(self.imageScrollView);
    for (NSInteger i = 0; i < imageArr.count; i++)
    {
        if (i < 5)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:imageArr[i] forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(handleImageButton:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat buttonX = i * buttonW + (i+1)*5;
            button.frame = CGRectMake(buttonX, 0, buttonW, buttonW);
            [self.imageScrollView addSubview:button];
            
            if (i != imageArr.count-1)
            {
                UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteBtn.tag = i;
                deleteBtn.frame = CGRectMake(WIDTH(button)-50, 0, 50, 40);
                deleteBtn.backgroundColor = [UIColor redColor];
                [deleteBtn addTarget:self action:@selector(handleDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
                [button addSubview:deleteBtn];
            }
        }
    }
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, WIDTH(self)-20, HEIGHT(self)-80)];
        ViewBorderRadius(_lineView, 3, 1, RGB(230, 230, 230));
    }
    return _lineView;
}

- (HCFeedbackTextView *)contentText
{
    if (!_contentText)
    {
        _contentText = [[HCFeedbackTextView alloc] initWithFrame:CGRectMake(5, 0, WIDTH(self.lineView)-10, 60)];
        _contentText.delegate = self;
        _contentText.placeholder = @"请输入评论...";
        _contentText.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentText;
}

- (UILabel *)contentTitle
{
    if (!_contentTitle)
    {
        _contentTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width-30, 30)];
        _contentTitle.text = @"写下评论吧";
        _contentTitle.textColor = DarkGrayColor;
    }
    return _contentTitle;
}

- (UIScrollView *)imageScrollView
{
    if (!_imageScrollView)
    {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHT(self.lineView)-70, WIDTH(self), 60)];
    }
    return _imageScrollView;
}

- (UIButton *)saveBtn
{
    if (!_saveBtn)
    {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.frame = CGRectMake(10, MaxY(self.lineView)+5, (WIDTH(self)-40)*0.5, 35);
        [_saveBtn setTitle:@"回复" forState:UIControlStateNormal];
        _saveBtn.backgroundColor = kHCNavBarColor;
        ViewRadius(_saveBtn, 4);
    }
    return _saveBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.tag = 1;
        _cancelBtn.frame = CGRectMake(MaxX(self.saveBtn)+20, MaxY(self.lineView)+5, (WIDTH(self)-40)*0.5, 35);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = kHCNavBarColor;
        ViewRadius(_cancelBtn, 4);
    }
    return _cancelBtn;
}


@end

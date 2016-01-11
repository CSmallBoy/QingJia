//
//  HCEvaluationTextView.m
//  HealthCloud
//
//  Created by bsoft on 15/10/23.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCFeedbackTextView.h"

@interface HCFeedbackTextView()<UITextViewDelegate>

@end

@implementation HCFeedbackTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    // 最大长度
    if (range.location > self.maxTextLength - 1)
    {
        return NO;
    }
    // 关闭键盘
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(feedbackTextViewdidBeginEditing)])
    {
        [self.delegate feedbackTextViewdidBeginEditing];
    }
    // 清空默认文字
    if ([textView.text isEqualToString:_placeholder])
    {
        textView.text = @"";
        textView.textColor =[UIColor blackColor];// RGB(46, 46, 46);
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // 显示默认文字
    if (!textView.text.length)
    {
        textView.text = _placeholder;
        textView.textColor = RGB(200, 200, 200);
    }
    else
    {
        textView.textColor = [UIColor blackColor];
    }
    if ([self.delegate respondsToSelector:@selector(feedbackTextViewdidEndEditing)])
    {
        [self.delegate feedbackTextViewdidEndEditing];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > self.maxTextLength)
    {
        textView.text = [textView.text substringToIndex:self.maxTextLength];
    }
}


#pragma mark - getter or setter

// 文字输入框

- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] init];
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.bounces = NO;
        _textView.scrollEnabled = NO;
        _textView.delegate = self;
        _textView.textColor = RGB(200, 200, 200);//[UIColor lightGrayColor];
        _textView.font = [UIFont systemFontOfSize:15];
    }
    return _textView;
}

// 设置替代文字

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textView.text = placeholder;
}

// 设置文本默认最大长度

- (NSInteger)maxTextLength
{
    if (!_maxTextLength)
    {
        return 500;
    }
    return _maxTextLength;
}

@end

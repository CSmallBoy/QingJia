//
//  CFJInputView.m
//  CFJInputView
//
//  Created by 陈福杰 on 15/12/1.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "CFJInputView.h"
#import "AppDelegate.h"

@interface CFJInputView()<UITextViewDelegate>

@property (nonatomic, assign) CGRect oldFrame;
@property (assign,nonatomic)CGRect originalFrame;
@property (nonatomic, strong) UILabel *line;

@end

@implementation CFJInputView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        self.frame = CGRectMake(0, CGRectGetMinY(frame), self.frame.size.width, CGRectGetHeight(frame));
        [self addSubview:self.line];
        [self addSubview:self.textView];
        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc //移除通知
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - private methods

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)]>=_keyboardRect.origin.y)
    {
        //没有偏移 就说明键盘没出来，使用动画
        if (self.frame.origin.y== self.originalFrame.origin.y) {
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
                             } completion:nil];
        }
        else
        {
            self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
        }
        _oldFrame = self.frame;
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, 0);
                     } completion:^(BOOL finished) {
                         CGRect tempFrame = _oriFrame;
                         tempFrame.origin.y = self.frame.origin.y;
                         self.frame = tempFrame;
                         self.originalFrame = tempFrame;
                     }];
}

- (void)textDidChanged:(NSNotification *)notif //监听文字改变 换行时要更改输入框的位置
{
    CGSize contentSize = self.textView.contentSize;

    if (contentSize.height > 140)
    {
        return;
    }
    CGRect selfFrame = self.frame;
    
    CGFloat height = (contentSize.height - selfFrame.size.height);
    
    CGFloat selfHeight = selfFrame.size.height + height+6;
    if (_oldFrame.size.height != selfHeight)
    {
        CGFloat originH = (-contentSize.height + selfFrame.size.height)-6;
        CGFloat selfOriginY = _oldFrame.origin.y + originH;
        
        _oldFrame.origin.y = selfOriginY;
        _oldFrame.size.height = selfHeight;
        self.frame = _oldFrame;
        _textView.frame = CGRectMake(10, 3, self.frame.size.width-20, self.frame.size.height-6);
        _oldFrame = self.frame;
    }
}

//将坐标点y 在window和superview转化  方便和键盘的坐标比对
-(float)convertYFromWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
    return o.y;
}
-(float)convertYToWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return o.y;
}

-(float)getHeighOfWindow
{
    return SCREEN_HEIGHT-64;
}

-(BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 关闭键盘
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if ([self.delegate respondsToSelector:@selector(inputView:String:)])
        {
            [self.delegate inputView:self String:textView.text];
        }
        textView.text = @"请输入评论内容...";
        textView.textColor = [UIColor lightGrayColor];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (IsEmpty(textView.text))
    {
        textView.text = @"请输入评论内容...";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入评论内容..."])
    {
        textView.text = @"";
        textView.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return YES;
}

#pragma mark - setter or getter 

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _originalFrame = frame;
    _oriFrame = self.frame;
}

- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 3, self.frame.size.width-20, self.frame.size.height-6)];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.delegate = self;
        
        _textView.text = @"请输入评论内容...";
        _textView.textColor = [UIColor lightGrayColor];
        
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 4;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    }
    return _textView;
}

- (UILabel *)line
{
    if (!_line)
    {
        _line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        _line.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    }
    return _line;
}


@end

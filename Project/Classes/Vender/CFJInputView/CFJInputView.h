//
//  CFJInputView.h
//  CFJInputView
//
//  Created by 陈福杰 on 15/12/1.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFJInputView;

@protocol CFJInputViewDelegate <NSObject>

- (void)inputView:(CFJInputView *)inputView String:(NSString *)string;

@end

@interface CFJInputView : UIView

@property (nonatomic, strong) UITextView *textView;


@property (nonatomic, strong) id<CFJInputViewDelegate>delegate;
// 原始
@property(assign,nonatomic)CGRect oriFrame;
//隐藏键盘
-(BOOL)resignFirstResponder;

@end

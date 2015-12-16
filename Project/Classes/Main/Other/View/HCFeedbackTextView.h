//
//  HCEvaluationTextView.h
//  HealthCloud
//
//  Created by bsoft on 15/10/23.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCFeedbackTextViewDelegate <NSObject>

@optional

- (void)feedbackTextViewdidBeginEditing;            // 开始编辑

- (void)feedbackTextViewdidEndEditing;              // 结束编辑

@end

@interface HCFeedbackTextView : UIView


@property (nonatomic, strong) UITextView *textView; // 输入框

@property (nonatomic, strong) NSString *placeholder; // 替代文字

@property (nonatomic, assign) NSInteger maxTextLength; // 最大输入长度

@property (nonatomic, weak) id<HCFeedbackTextViewDelegate>delegate;


@end

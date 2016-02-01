//
//  HCPromisedTextViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTextViewCell.h"

@interface HCPromisedTextViewCell ()<HCFeedbackTextViewDelegate,UITextViewDelegate>
{
    UILabel     *_label1;
//    UILabel     *_placeholderLbale;
//    HCFeedbackTextView  *_textView;
}
@end

@implementation HCPromisedTextViewCell

+(instancetype)CustomCellWithTableView:(UITableView *)tableView
{
   static  NSString *textViewCellID = @"textViewCellID";
    HCPromisedTextViewCell *cell = [[HCPromisedTextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textViewCellID];

        [cell addSubviews];

    return cell;
}

-(void)feedbackTextViewdidEndEditing
{
    self.textFieldBlock(_textView.textView.text,self.indexPath);

}

#pragma mark -- private method

-(void)addSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 60, 40)];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = [UIColor blackColor];
    [self addSubview:_label1];
    
    _textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(60, 2, SCREEN_WIDTH-70, 80)];
    _textView.delegate = self;
    [self addSubview:_textView];
}

#pragma mark --- Setter Or  Getter

-(void)setTitle:(NSString *)title
{
    _title = title;
    _label1.text = title;
    if (_isBlack) {
        _textView.userInteractionEnabled = NO;
        _textView.textView.textColor = [UIColor blackColor];
    }
}

-(void)setDetail:(NSString *)detail
{
    _detail = detail;
    
    if (self.text == nil || [self.text isEqualToString:@""]) {
        _textView.placeholder = detail;
    }
    else
    {
        _textView.placeholder = self.text;
        
        _textView.textView.textColor = [UIColor blackColor];
    
    }
    
}



@end

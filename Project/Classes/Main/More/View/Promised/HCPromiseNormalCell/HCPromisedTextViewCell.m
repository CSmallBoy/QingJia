//
//  HCPromisedTextViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTextViewCell.h"
#import "HCFeedbackTextView.h"
@interface HCPromisedTextViewCell ()<UITextViewDelegate>
{
    UILabel     *_label;
//    UILabel     *_placeholderLbale;
    HCFeedbackTextView  *_textView;
}
@end

@implementation HCPromisedTextViewCell

+(instancetype)CustomCellWithTableView:(UITableView *)tableView
{
   static  NSString *textViewCellID = @"textViewCellID";
    HCPromisedTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textViewCellID];
    if (!cell) {
        cell = [[HCPromisedTextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textViewCellID];
        [cell addSubviews];
    }
    return cell;
}

#pragma mark -- private method

-(void)addSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 60, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor blackColor];
    [self addSubview:_label];
    
    _textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(60, 2, SCREEN_WIDTH-70, 80)];
   
    [self addSubview:_textView];

}

#pragma mark --- Setter Or  Getter

-(void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = title;
    if (_isBlack) {
        _textView.userInteractionEnabled = NO;
        _textView.textView.textColor = [UIColor blackColor];
    }
}

-(void)setDetail:(NSString *)detail
{
    _detail = detail;
    _textView.placeholder = detail;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

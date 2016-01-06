//
//  HCPromisedTextViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTextViewCell.h"

@interface HCPromisedTextViewCell ()<UITextViewDelegate>
{
    UILabel     *_label;
    UILabel     *_placeholderLbale;
    UITextView  *_textView;
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

#pragma mark UITextViewdelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
  _placeholderLbale.text = @"";
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (_textView.text.length == 0) {
        _placeholderLbale.text = self.detail;
    }
    else
    {
       _placeholderLbale.text = @"";
    }
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
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(60, 2, SCREEN_WIDTH-70, 80)];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textView];
    
    _placeholderLbale = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH-70, 80)];
    _placeholderLbale.backgroundColor = [UIColor clearColor];
    _placeholderLbale.textColor = RGB(203, 203, 203);
    _placeholderLbale.font = [UIFont systemFontOfSize:14];
    _placeholderLbale.numberOfLines = 0 ;
    [_textView addSubview:_placeholderLbale];

}

#pragma mark --- Setter Or  Getter
-(void)setTitle:(NSString *)title
{

    _title = title;
    _label.text = title;
}

-(void)setDetail:(NSString *)detail
{
    _detail = detail;
    _placeholderLbale.text = detail;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

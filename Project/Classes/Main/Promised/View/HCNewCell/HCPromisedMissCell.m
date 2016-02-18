//
//  HCPromisedMissCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//
#import "HCPromisedMissCell.h"
#import "HCFeedbackTextView.h"

#import "HCPromisedMissInfo.h"


#import "TLTiltSlider.h"

@interface HCPromisedMissCell ()<UITextFieldDelegate,HCFeedbackTextViewDelegate>

@property (nonatomic,strong) NSArray *placeholderTitleArr;
@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic,strong) HCFeedbackTextView *textView;

@end

@implementation HCPromisedMissCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark---UITextfieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(dismissDatePicker2)])
    {
        [self.delegate dismissDatePicker2];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _missInfo.LossAddress = textField.text;
    
}

#pragma mark ----HCFeedbackTextViewDelegate

-(void)feedbackTextViewdidBeginEditing
{
    if ([self.delegate respondsToSelector:@selector(dismissDatePicker2)])
    {
        [self.delegate dismissDatePicker2];
    }
}

-(void)feedbackTextViewdidEndEditing
{
    
    if ([self.textView.textView.text isEqualToString:@"点击输入走失时的一些特点，比如：相貌特征，身高，所穿衣物"]) {
        _missInfo.LossDesciption = nil;
    }
    else
    {
        _missInfo.LossDesciption = self.textView.textView.text;
    }
}

#pragma mark --- private mothods
//添加滑块
-(void)addSlider
{
//    TLTiltSlider *slider = [[TLTiltSlider alloc] initWithFrame:(CGRect){.origin.x = 110, .origin.y = 4, SCREEN_WIDTH-150, .size.height = 5}];
    UISlider  *slider = [[UISlider alloc]initWithFrame:CGRectMake(110, 4, SCREEN_WIDTH-150, 40)];
    slider.minimumTrackTintColor = COLOR(230, 45, 55, 1);
    slider.minimumValue = 0.0;
    slider.maximumValue = 120;
    [slider setThumbImage:IMG(@"SliderClick-2") forState:(UIControlStateNormal)];
    [self.contentView addSubview:slider];
    
    //最大值和最小值label
    UILabel *minLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 12, 30, 20)];
    minLabel.text = @"0:00";
    minLabel.adjustsFontSizeToFitWidth = YES;
    minLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:minLabel];
    
    UILabel *maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 12, 30, 20)];
    maxLabel.textColor = [UIColor blackColor];
    maxLabel.text = @"2:00";
    maxLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:maxLabel];

}

#pragma mark---Setter Or Getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    _titleLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row == 0)
    {
        [self addSlider];
    }
    else if (indexPath.row == 1)
    {
        self.textField.placeholder = self.placeholderTitleArr[indexPath.row];
        self.textField.text = _missInfo.LossAddress;
        self.textField.delegate = self;
        [self.contentView addSubview:self.textField];
 
    }else if(indexPath.row == 2)
    {
        self.textView.placeholder = self.placeholderTitleArr[indexPath.row];
        
        
        if (_missInfo.LossDesciption)
        {
            self.textView.textView.text = _missInfo.LossDesciption;
            self.textView.textView.textColor = [UIColor blackColor];
        }
        [self.contentView addSubview:self.textView];
    
    }
}

-(HCFeedbackTextView *)textView
{
    if (!_textView)
    {
        _textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(85, 0, SCREEN_WIDTH-100, 88)];
        _textView.maxTextLength = SCREEN_WIDTH-100;
        //        _textView.textView.textColor = [UIColor blackColor];
        self.textView.delegate = self;
    }
    return _textView;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 4, SCREEN_WIDTH-100, 40)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = SYSTEMFONT(15);
    }
    return _textField;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 4, 60, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = RGB(46, 46, 46);
    }
    return _titleLabel;
}

- (NSArray *)placeholderTitleArr
{
    if (!_placeholderTitleArr)
    {
        _placeholderTitleArr = @[@"点击输入走失时间",@"点击输入走失地点",@"点击输入走失时的一些特点，比如：相貌特征，身高，所穿衣物"];
    }
    return _placeholderTitleArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"时间",@"地点",@"描述"];
    }
    return _titleArr;
}

@end

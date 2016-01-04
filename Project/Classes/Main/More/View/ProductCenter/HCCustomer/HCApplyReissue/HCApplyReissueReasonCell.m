//
//  HCApplyReissueReasonCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReissueReasonCell.h"
#import "HCFeedbackTextView.h"
#import "HCApplyReissueResonInfo.h"
@interface HCApplyReissueReasonCell()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) HCFeedbackTextView *textView;
@property (nonatomic, strong) UIView *contentImgView;

@end

@implementation HCApplyReissueReasonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.contentImgView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLab.frame = CGRectMake(16, 0, 80, 40);
    _textView.frame = CGRectMake(0, 40, SCREEN_WIDTH-10, 100);
    _contentImgView.frame = CGRectMake(0, 140, SCREEN_WIDTH, SCREEN_WIDTH/3);

}

#pragma mark---private methods

- (void)handleDeleteButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcpublishTableViewCellDeleteImageViewIndex:)])
    {
        [self.delegate hcpublishTableViewCellDeleteImageViewIndex:button.tag];
    }
}

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcpublishTableViewCellImageViewIndex:)])
    {
        [self.delegate hcpublishTableViewCellImageViewIndex:button.tag];
    }
}

- (void)setupImageView:(NSMutableArray *)arrayM
{

    [self.contentImgView removeAllSubviews];
    CGFloat buttonWidth = SCREEN_WIDTH/3;
    for (NSInteger i = 1; i < arrayM.count+1; i++)
    {
        if (i <= 3)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat buttonX = ((i-1)%3) * buttonWidth;
            CGFloat buttonY = ((int)(i-1) / 3) * buttonWidth;
            button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth);
            [button setImage:arrayM[i-1] forState:UIControlStateNormal];
            [self.contentImgView addSubview:button];
            
            if (i != arrayM.count)
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


#pragma mark--Setter Or Getter

-(void)setInfo:(HCApplyReissueResonInfo *)info
{
    _info = info;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [self setupImageView:_info.imageArray];
}

-(UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"原因描述:";
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}

-(HCFeedbackTextView *)textView
{
    if (!_textView)
    {
        _textView = [[HCFeedbackTextView alloc]init];

        _textView.placeholder = @"请输入原因";
        _textView.maxTextLength = SCREEN_WIDTH;
    }
    return _textView;
}


- (UIView *)contentImgView
{
    if (!_contentImgView)
    {
        _contentImgView = [[UIView alloc] init];
        [self.contentView addSubview:_contentImgView];
    }
    return _contentImgView;
}
@end

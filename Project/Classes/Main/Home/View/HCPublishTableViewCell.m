//
//  HCPublishTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPublishTableViewCell.h"
#import "HCPublishInfo.h"

@interface HCPublishTableViewCell()

@property (nonatomic, strong) UISwitch *switchs;
@property (nonatomic, strong) UIView *contentImgView;

@end

@implementation HCPublishTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - private methods

- (void)handleSwitch:(UISwitch *)switchs
{
    _info.OpenAddress = [NSString stringWithFormat:@"%@", @(switchs.on)];
}

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
//显示已选中的图片
- (void)setupImageView:(NSMutableArray *)arrayM
{
    NSInteger rows = arrayM.count / 4;
    rows += (arrayM.count%4) ? 1 : 0;
    self.contentImgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH/4)*rows);
    
    [self.contentImgView removeAllSubviews];
    CGFloat buttonWidth = SCREEN_WIDTH/4;
    for (NSInteger i = 1; i < arrayM.count+1; i++)
    {
        if (i <= 9)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat buttonX = ((i-1)%4) * buttonWidth;
            CGFloat buttonY = ((int)(i-1) / 4) * buttonWidth;
            button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth);
            [button setImage:arrayM[i-1] forState:UIControlStateNormal];
            [self.contentImgView addSubview:button];
            
            if (i != arrayM.count)
            {
                UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteBtn.tag = i;
                deleteBtn.frame = CGRectMake(WIDTH(button)-25, 0, 25, 22);
                deleteBtn.backgroundColor = [UIColor greenColor];
                [deleteBtn setImage:IMG(@"close") forState:UIControlStateNormal];
                [deleteBtn addTarget:self action:@selector(handleDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
                [button addSubview:deleteBtn];
            }
        }
    }
}

#pragma mark - setter or getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        [self setupImageView:_info.FTImages];
    }else if (indexPath.row == 2)
    {
        self.textLabel.text = @"位置是否公开";
        [self.contentView addSubview:self.switchs];
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        self.textLabel.text = @"谁能看见";
        self.detailTextLabel.text = @"所有人可见";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (UISwitch *)switchs
{
    if (!_switchs)
    {
        _switchs = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 30, 30)];
        _switchs.on = YES;
        [_switchs addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchs;
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

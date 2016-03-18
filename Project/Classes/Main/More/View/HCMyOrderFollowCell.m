//
//  HCMyOrderFollowCell.m
//  Project
//
//  Created by 朱宗汉 on 16/3/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMyOrderFollowCell.h"
#import "HCMyOrderFollowInfo.h"

@interface HCMyOrderFollowCell ()
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *roundView;
@property (nonatomic,strong) UIView *grayLine;
@end


@implementation HCMyOrderFollowCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyOrderFollowCellID";
    
    HCMyOrderFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
       cell = [[HCMyOrderFollowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       [cell addSubviews]; 
    }
    
    return cell;
}

-(void)addSubviews
{
    for (UIView *view in self.subviews) {
    
        [view removeFromSuperview];
    }
    
    [self addSubview:self.addressLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.grayLine];
    [self addSubview:self.roundView];

}


#pragma mark --- setter Or getter


-(void)setInfo:(HCMyOrderFollowInfo *)info
{
    _info = info;
    
    self.addressLabel.text = info.adress;
    self.timeLabel.text = info.time;
    if (info.isArrived)
    {
        self.addressLabel.textColor = COLOR(222, 35, 46, 1);
        self.timeLabel.textColor = COLOR(222, 35, 46, 1);
        _roundView.frame = CGRectMake(25, 10, 10, 10);
        _roundView.backgroundColor =COLOR(222, 35, 46, 1);
    }
}


- (UILabel *)addressLabel
{
    if(!_addressLabel){
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, SCREEN_WIDTH-70, 30)];
        _addressLabel.adjustsFontSizeToFitWidth = YES;
        _addressLabel.textColor = [UIColor lightGrayColor];
    }
    return _addressLabel;
}


- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, SCREEN_WIDTH-70, 30)];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}


- (UIView *)roundView
{
    if(!_roundView){
        _roundView = [[UIView alloc]initWithFrame:CGRectMake(25, 10, 10, 10)];
        _roundView.backgroundColor = kHCBackgroundColor;
        ViewRadius(_roundView, 5);
    }
    return _roundView;
}


- (UIView *)grayLine
{
    if(!_grayLine){
        _grayLine = [[UIView alloc]initWithFrame:CGRectMake(29, 10, 2, 70)];
        _grayLine.backgroundColor = kHCBackgroundColor;
    }
    return _grayLine;
}



@end

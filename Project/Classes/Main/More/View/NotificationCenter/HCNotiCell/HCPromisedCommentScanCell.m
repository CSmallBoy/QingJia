//
//  HCPromisedCommentScanCellTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 16/4/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedCommentScanCell.h"
#import "HCPromisedCommentInfo.h"
@interface HCPromisedCommentScanCell ()
@property (nonatomic,strong) UIImageView *headIV;
@property (nonatomic,strong) UILabel     *nameLabel;
@property (nonatomic,strong) UILabel     *phoneLabel;
@property (nonatomic,strong) UILabel     *commentLabel;
@property (nonatomic,strong) UILabel     *timeLabel;

@property (nonatomic,strong) NSString    *cityStr;
@property (nonatomic,strong) NSString    *streenStr;

@end

@implementation HCPromisedCommentScanCell

+(instancetype)CellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"CommentScan";
    HCPromisedCommentScanCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HCPromisedCommentScanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    return cell;
}

-(void)addSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.headIV];
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.commentLabel];

}


#pragma mark --- setter  Or getter 

-(void)setInfo:(HCPromisedCommentInfo *)info
{
    _info = info;
    NSURL *url = [readUserInfo url:info.imageName :kkUser];
    [self.headIV sd_setImageWithURL:url placeholderImage:IMG(@"Head-Portraits")];

    self.nameLabel.text = self.info.nickName;
    self.phoneLabel.text = self.info.phoneNo;
    self.timeLabel.text = [self.info.createTime substringToIndex:16];
    
    // 反地理信息编码
    
    NSArray *arr = [self.info.createLocation componentsSeparatedByString:@","];
    double la = [arr[0] doubleValue];
    double lo = [arr[1] doubleValue];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:la longitude:lo];
    
    
     CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSDictionary *dict =
            [[placemarks objectAtIndex:0] addressDictionary];
            self.streenStr =[dict objectForKey:@"Street"];
            NSLog(@"street address: %@",[dict objectForKey:@"Street"]);
            
            //获取城市
           self.cityStr = placemark.locality;
            if (!self.cityStr) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                self.cityStr = placemark.administrativeArea;
            }
            NSLog(@"city = %@", self.cityStr);
            //_cityLable.text = city;
            //[_cityButton setTitle:city forState:UIControlStateNormal];
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }

        self.commentLabel.text = [NSString stringWithFormat:@"该标签在%@%@被扫描",self.cityStr,self.streenStr];

    }];
    
}


- (UIImageView *)headIV
{
    if(!_headIV){
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        ViewRadius(_headIV, 30);
    }
    return _headIV;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 100, 20)];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}


- (UILabel *)phoneLabel
{
    if(!_phoneLabel){
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, 150, 30)];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 15, 20)];
        IV.image = IMG(@"phone");
        [_phoneLabel addSubview:IV];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor blackColor];
        
    }
    return _phoneLabel;
}


- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-200, 20, 190, 20)];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _timeLabel;
}



- (UILabel *)commentLabel
{
    if(!_commentLabel){
        _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH-20, 50)];
        _commentLabel.numberOfLines = 0;
        _commentLabel.font = [UIFont systemFontOfSize:17];
        _commentLabel.textColor = kHCNavBarColor;
    }
    return _commentLabel;
}




@end

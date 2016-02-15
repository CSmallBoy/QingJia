//
//  HCMedicalCell.m
//  Project
//
//  Created by 朱宗汉 on 16/2/3.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMedicalCell.h"
#import "HCMedicalFrameIfo.h"
#import "HCMedicalInfo.h"

@interface HCMedicalCell ()
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *Content;
@end

@implementation HCMedicalCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
   static  NSString  *ID = @"MedicalCellID";
    HCMedicalCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HCMedicalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubview];
    }

    return cell;
}


#pragma mark --- private  mothods

-(void)addSubview
{
   
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self addSubview:self.title];
    [self addSubview:self.Content];

}

#pragma mark --- getter Or setter


-(void)setInfo:(HCMedicalFrameIfo *)info
{
    _info =info;
    
    self.title.frame = info.titleFrame;
    
    self.Content.frame = self.info.contentFrame;
    self.Content.text = self.info.title;

}


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    switch (indexPath.row)
    {
        case 0:
            self.title.text = @"身高";
            break;
        case 1:
            self.title.text = @"体重";
            break;
        case 2:
            self.title.text = @"血型";
            break;
        case 3:
            self.title.text = @"过敏史";
            break;
        case 4:
            self.title.text = @"医疗状况";
            break;
        case 5:
            self.title.text = @"医疗笔记";
            break;
        default:
            break;
    }

}


- (UILabel *)title
{
    if(!_title){
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}



- (UILabel *)Content
{
    if(!_Content){
        _Content = [[UILabel alloc]init];
        _Content.textColor = [UIColor blackColor];
        _Content.numberOfLines = 0  ;
        _Content.font = [UIFont systemFontOfSize:14];
        _Content.textAlignment  = NSTextAlignmentLeft;
    }
    return _Content;
}



@end

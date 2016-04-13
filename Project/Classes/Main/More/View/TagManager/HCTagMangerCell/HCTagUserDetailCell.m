//
//  HCTagUserDetailCell.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserDetailCell.h"
#import "HCNewTagInfo.h"

 // ---------------------------标签试用者详细信息 cell 为完成-----------------------------
@interface HCTagUserDetailCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *headBtn ;
@property (nonatomic,strong) NSArray *baseTitles;
@property (nonatomic,strong) NSArray *medicalTitles;

@property (nonatomic,strong) NSArray *basePlaceHolderArr;
@property (nonatomic,strong) NSArray *medicalPlaceHolderArr;
@end


@implementation HCTagUserDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TagUserDetailCell";
    HCTagUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell = [[HCTagUserDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    
    return cell;
}

#pragma mark --- private mothods

-(void)addSubviews
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.headBtn];
}

#pragma mark --- setter  Or getter


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    if (indexPath.row == 0) {
        
        
    }
    
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 80, 30)];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}


- (UITextField *)textField
{
    if(!_textField){
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 7, SCREEN_WIDTH-100, 30)];
        _textField.textColor = [UIColor blackColor];
        _textField.delegate = self;
    }
    return _textField;
}



- (NSArray *)baseTitles
{
    if(!_baseTitles){
        _baseTitles = @[@"头像",@"姓名",@"性别",@"生日",@"住址",@"学校"];
    }
    return _baseTitles;
}




@end

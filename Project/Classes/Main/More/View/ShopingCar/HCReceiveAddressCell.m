//
//  HCReceiveAddressCell.m
//  Project
//
//  Created by 朱宗汉 on 16/3/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCReceiveAddressCell.h"
#import "HCAddressInfo.h"


@interface HCReceiveAddressCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@property (nonatomic,strong) UIView *editView;
@property (nonatomic,strong) UIButton  *editBtn;
@property (nonatomic,strong) UIButton  *deleteBtn;

@property (nonatomic,strong) UIView *grayLine;

@property (nonatomic,strong) UIView * addressView;
@property (nonatomic,strong) UIButton *defaultBtn;
@property (nonatomic,strong) UILabel  *defaultLabel;
@end

@implementation HCReceiveAddressCell
// ----------------------收货地址cell-----------------------

+(instancetype)cellWithTableView:(UITableView *)tableView
{
     static NSString *ID = @"ReceiveAddressCell";
    
    HCReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell = [[HCReceiveAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }

    return cell;
}


#pragma mark --- provate mothods

-(void)addSubviews
{

    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.addressLabel];
    
    [self addSubview:self.grayLine];
    
    [self addSubview:self.addressView];
    [self addSubview:self.editView];
    

}


-(void)defaultBtnClick:(UIButton *)button
{
    self.block(self.indexpath);
}

-(void)editBtnClick:(UIButton *)button
{
    NSDictionary *dic = @{@"index": self.indexpath};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toEditVC" object:nil userInfo:dic];

}

#pragma mark --- setter Or getter 


-(void)setInfo:(HCAddressInfo *)info
{
    _info = info;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@",info.consigneeName,info.phoneNumb];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@[%@]",info.receivingCity,info.receivingStreet,info.postcode];
    if (info.isDefault) {
        [self.defaultBtn setBackgroundImage:IMG(@"thehook") forState:UIControlStateNormal];
        self.defaultLabel.text = @"默认地址";
    }
    else
    {
        [self.defaultBtn setBackgroundImage:IMG(@"addressquan") forState:UIControlStateNormal];
        self.defaultLabel.text = @"设置默认地址";
    }

}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}


- (UILabel *)addressLabel
{
    if(!_addressLabel){
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+5, SCREEN_WIDTH-20, 20)];
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _addressLabel;
}


- (UIView *)addressView
{
    if(!_addressView){
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.addressLabel.frame) +15, 200, 40)];
        [_addressView addSubview:self.defaultBtn];
        [_addressView addSubview:self.defaultLabel];
        
    }
    return _addressView;
}


- (UIButton *)defaultBtn
{
    if(!_defaultBtn){
        _defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _defaultBtn.frame = CGRectMake(0, 5, 20, 20);
        [_defaultBtn addTarget:self action:@selector(defaultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultBtn;
}


- (UILabel *)defaultLabel
{
    if(!_defaultLabel){
        _defaultLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 120, 30)];
        _defaultLabel.textColor = [UIColor blackColor];
        _defaultLabel.font = [UIFont systemFontOfSize:14];
    }
    return _defaultLabel;
}



- (UIView *)editView
{
    if(!_editView){
        _editView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-150,CGRectGetMaxY(self.addressLabel.frame) +10 , 140, 40)];
        [_editView addSubview:self.editBtn];
        [_editView addSubview:self.deleteBtn];
        
        NSArray *arr = @[@"bianji",@"shanchu"];
        for (int i = 0; i<2; i++)
        {
            UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(70*i, 10, 20, 20)];
            IV.image =IMG(arr[i]) ;
            [_editView addSubview:IV];
        }
        
        
    }
    return _editView;
}



- (UIButton *)editBtn
{
    if(!_editBtn){
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(20, 10, 30, 20);
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}



- (UIButton *)deleteBtn
{
    if(!_deleteBtn){
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(90, 10, 30, 20);
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}




- (UIView *)grayLine
{
    if(!_grayLine){
        _grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addressLabel.frame)+8, SCREEN_WIDTH, 1)];
        _grayLine.backgroundColor = kHCBackgroundColor;
    }
    return _grayLine;
}


@end

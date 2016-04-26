//
//  HCTagUserDetailCell.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserDetailCell.h"
#import "HCFeedbackTextView.h"
#import "HCNewTagInfo.h"

 // ---------------------------标签试用者详细信息 cell 为完成-----------------------------
@interface HCTagUserDetailCell ()<UITextFieldDelegate,HCFeedbackTextViewDelegate,UITextViewDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) HCFeedbackTextView *textView;
@property (nonatomic,strong) UIImageView *headBtn ;
@property (nonatomic,strong) UISwitch *addressSW;


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

#pragma mark --- UITextField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
    switch (textField.tag) {
        case 100:
        {
            // 头像
        }
            break;
        case 101:
        {
            self.info.trueName = textField.text;
        }
            break;
        case 102:
        {
            self.info.sex = textField.text;
        }
            break;
        case 103:
        {
           // 生日
        }
            break;
        case 104:
        {
            self.info.homeAddress = textField.text;
        }
            break;
        case 105:
        {
            self.info.school = textField.text;
        }
            break;
            
        case 200:
        {
            self.info.height = textField.text;
        }
            break;
        case 201:
        {
            self.info.weight = textField.text;
        }
            break;
        case 202:
        {
            self.info.bloodType = textField.text;
        }
            break;
        default:
            break;
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 303)
    {
        self.info.allergic = textView.text;
    }
    else if (textView.tag == 304)
    {
        self.info.cureNote = textView.text;
    }else
    {
        self.info.cureCondition = textView.text;
    }
   
    
    if (textView.text.length == 0) {
        self.textView.placeholder = self.medicalPlaceHolderArr[textView.tag-300];
        self.textView.textView.textColor = COLOR(200, 200, 200, 1);
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"点击输入过敏史"]||
        [textView.text isEqualToString:@"点击输入医疗笔记"]||
        [textView.text isEqualToString:@"点击输入医疗状况"])
    {
        self.textView.placeholder = nil;
    }
   
    
  
   
    self.textView.textView.textColor = [UIColor blackColor];
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
    [self.contentView addSubview:self.textView];

        
    _addressSW = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 7, 30, 30)];
    _addressSW.on = YES;
    _addressSW.hidden = YES;
    [_addressSW addTarget:self action:@selector(addressSWClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_addressSW];
        
    
    
}

-(void)addressSWClick:(UISwitch *)sw
{
  
    if (sw.on) {
        self.info.openHomeAddress = @"1";
    }
    else
    {
        self.info.openHomeAddress = @"0";
    }
    
    
}



#pragma mark --- setter  Or getter


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.section == 0) {
        self.textView.hidden = YES;
        self.titleLabel.text = self.baseTitles[indexPath.row];
        self.textField.placeholder = self.basePlaceHolderArr[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                self.headBtn.hidden = NO;
                self.textField.enabled = NO;
                if (self.image) {
                    self.headBtn.image = self.image;
                }
                else
                {
                    NSURL *url = [readUserInfo originUrl:_info.imageName :kkObject];
                    [self.headBtn sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
                }
              
            }
                
                break;
            case 1:
            {
                self.headBtn.hidden = YES;
                self.textField.text = self.info.trueName;
            }
                break;
            case 2:
            {
                self.headBtn.hidden = YES;
                self.textField.hidden = NO;
                self.textField.text = self.info.sex;
            }
                break;
            case 3:
            {
                self.headBtn.hidden = YES;
                self.textField.hidden = NO;
                self.textField.text = self.info.birthDay;
                self.textField.enabled = NO;// 生日
            }
                break;
            case 4:
            {
                _addressSW.hidden = NO;
                self.headBtn.hidden = YES;
                self.textField.text = self.info.homeAddress;
            }
                break;
            case 5:
            {
                self.headBtn.hidden = YES;
                self.textField.text = self.info.school;
            }
                break;
            default:
                break;
        }
        
        self.textField.tag = 100+indexPath.row;
    }
    else
    {
        self.titleLabel.text = self.medicalTitles[indexPath.row];
        self.textField.placeholder = self.medicalPlaceHolderArr[indexPath.row];
        self.headBtn.hidden = YES;
        
        switch (indexPath.row) {
            case 0:
            {
                self.textField.text = self.info.height;
                 self.textView.hidden = YES;
            }
                break;
            case 1:
            {
                self.textField.text = self.info.weight;
                 self.textView.hidden = YES;
            }
                break;
            case 2:
            {
                self.textField.text = self.info.bloodType;
                 self.textView.hidden = YES;
            }
                break;
            case 3:
            {
                self.textField.hidden = YES;
                self.textView.hidden = NO;
                self.textView.placeholder = self.medicalPlaceHolderArr[indexPath.row];
                if (!IsEmpty(self.info.allergic)) {
                    self.textView.textView.text = self.info.allergic;
                    self.textView.textView.textColor = [UIColor blackColor];
                }
                
             
            }
                break;
            case 4:
            {
                self.textField.hidden = YES;
               
                self.textView.placeholder = self.medicalPlaceHolderArr[indexPath.row];
                if (!IsEmpty(self.info.cureNote)) {
                     self.textView.textView.text = self.info.cureNote;
                     self.textView.textView.textColor = [UIColor blackColor];
                }
                
            }
                break;
            case 5:
            {
                self.textField.hidden = YES;
                self.textView.hidden = NO;
                self.textView.placeholder = self.medicalPlaceHolderArr[indexPath.row];
                if (!IsEmpty(self.info.cureCondition)) {
                    self.textView.textView.text = self.info.cureCondition;
                     self.textView.textView.textColor = [UIColor blackColor];
                }
            }
                break;
            default:
                break;
        }
        
        self.textField.tag = 200 + indexPath.row;
        self.textView.textView.tag = 300 +indexPath.row;
        
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


-(HCFeedbackTextView *)textView
{
    if (!_textView)
    {
        _textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(85, 0, SCREEN_WIDTH-100, 88)];
        _textView.maxTextLength = SCREEN_WIDTH-100;
        _textView.textView.delegate = self;
        self.textView.delegate = self;
        
    }
    return _textView;
}



- (NSArray *)baseTitles
{
    if(!_baseTitles){
        _baseTitles = @[@"头像",@"姓名",@"性别",@"生日",@"住址",@"学校"];
    }
    return _baseTitles;
}


- (NSArray *)medicalTitles
{
    if(!_medicalTitles){
        _medicalTitles = @[@"身高",@"体重",@"血型",@"过敏史",@"医疗笔记",@"医疗状况"];
    }
    return _medicalTitles;
}


- (NSArray *)basePlaceHolderArr
{
    if(!_basePlaceHolderArr){
        _basePlaceHolderArr = @[@"",@"点击输入姓名",@"点击输入性别",@"点击输入生日",@"点击输入住址",@"点击输入学校"];
    }
    return _basePlaceHolderArr;
}



- (NSArray *)medicalPlaceHolderArr
{
    if(!_medicalPlaceHolderArr){
        _medicalPlaceHolderArr = @[@"点击输入身高",@"点击输入体重",@"点击输入血型",@"点击输入过敏史",@"点击输入医疗笔记",@"点击输入医疗状况"];
    }
    return _medicalPlaceHolderArr;
}



- (UIImageView *)headBtn
{
    if(!_headBtn){
        _headBtn = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-45, 2, 40, 40)];
        
           }
    return _headBtn;
}



@end

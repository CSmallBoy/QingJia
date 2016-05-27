//
//  HCLostInfoCell.m
//  钦家
//
//  Created by Tony on 16/5/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCLostInfoCell.h"
#import "PlaceholderTextView.h"

#define CELL_HEAD_HEIGHT 60
#define CELL_HEIGHT 50
#define CELL_FOOT_HEIGHT 80

@interface HCLostInfoCell ()<UITextViewDelegate>

@property (nonatomic, strong)UIImageView *headButton;//头像
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)PlaceholderTextView *textView;//过敏史
@property (nonatomic, strong)UIView *sexSelect;//性别选择

@end

@implementation HCLostInfoCell


+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"lostInfoCell";
    HCLostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[HCLostInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell addAllSubviewsByindexPath:indexPath];
    return cell;
}

- (void)addAllSubviewsByindexPath:(NSIndexPath *)indexPath
{
    [self removeAllSubviews];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (CELL_HEIGHT-30)/2, 60/375.0*SCREEN_WIDTH, 30)];
    titleLabel.textAlignment = 1;
    [self addSubview:titleLabel];
    [self addSubview:self.textField];
    
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, CELL_HEIGHT-1, SCREEN_WIDTH-60/375.0*SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineLabel];
    
    if (indexPath.section == 0)
    {
        self.textField.tag = 600 + indexPath.row;
        if (indexPath.row == 0)//头像
        {
            [self.textField removeFromSuperview];
            titleLabel.frame = CGRectMake(0, (CELL_HEAD_HEIGHT-30)/2, 60/375.0*SCREEN_WIDTH, 30);
            lineLabel.frame = CGRectMake(60/375.0*SCREEN_WIDTH, CELL_HEAD_HEIGHT-1, SCREEN_WIDTH-60/375.0*SCREEN_WIDTH, 1);
            titleLabel.text = @"头像";
            [self addSubview:self.headButton];
        }
        else if (indexPath.row == 1)//姓名
        {
            titleLabel.text = @"姓名";
            self.textField.placeholder = @"请输入真实姓名";
        }
        else if (indexPath.row == 2)//性别
        {
            titleLabel.text = @"性别";
            [self.textField removeFromSuperview];
            [self addSubview:self.sexSelect];
        }
        else if (indexPath.row == 3)//生日
        {
            titleLabel.text = @"生日";
            self.textField.placeholder = @"请选择出生年月";
            self.textField.enabled = NO;
        }
        else if (indexPath.row == 4)//住址
        {
            titleLabel.text = @"住址";
            self.textField.placeholder = @"请输入家庭住址";
        }
        else//学校
        {
            titleLabel.text = @"学校";
            lineLabel.frame = CGRectMake(0, CELL_HEIGHT-1, SCREEN_WIDTH, 1);
            self.textField.placeholder = @"请输入就读学校";
        }
    }
    else
    {
        self.textField.tag = 700 + indexPath.row;
        if (indexPath.row == 0)//身高
        {
            titleLabel.text = @"身高";
            self.textField.placeholder = @"请输入身高";
        }
        else if (indexPath.row == 1)//体重
        {
            titleLabel.text = @"体重";
            self.textField.placeholder = @"请输入体重";
        }
        else if (indexPath.row == 2)//血型
        {
            titleLabel.text = @"血型";
            self.textField.placeholder = @"请输入血型";
        }
        else//过敏史
        {
            titleLabel.text = @"过敏史";
            titleLabel.frame = CGRectMake(0, (CELL_FOOT_HEIGHT-30)/2, 60/375.0*SCREEN_WIDTH, 30);
            lineLabel.frame = CGRectMake(0, CELL_FOOT_HEIGHT-1, SCREEN_WIDTH, 1);
            [self.textField removeFromSuperview];
            [self addSubview:self.textView];
        }
    }
    
}

#pragma mark - textViewdelegate / textFieldDelegate
//实时监测textFeild变化
-(void)textChangeAction:(UITextField *)textField
{
    switch (textField.tag) {
        case 601:
        {
            self.info.trueName = textField.text;//姓名
        }
            break;
        case 604:
        {
            self.info.homeAddress = textField.text;//家庭住址
        }
            break;
        case 605:
        {
            self.info.school = textField.text;//学校
        }
            break;
            
        case 700:
        {
            self.info.height = textField.text;//身高
        }
            break;
        case 701:
        {
            self.info.weight = textField.text;//体重
        }
            break;
        case 702:
        {
            self.info.bloodType = textField.text;//血型
        }
            break;
        default:
            break;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.info.allergic = textView.text;//过敏史
}

#pragma mark - buttonClick
- (void)selectdButtonAction:(UIButton *)sender
{
    UIView *view = sender.superview;
    UIButton *button1 = [view viewWithTag:520];
    UIButton *button2 = [view viewWithTag:521];
    if (sender.tag == 520)
    {
        button2.selected = sender.selected;
        sender.selected = !sender.selected;
        if (sender.selected)
        {
            self.info.sex = @"男";
        }
        else
        {
            self.info.sex = @"女";
        }
    }
    else if (sender.tag == 521)
    {
        button1.selected = sender.selected;
        sender.selected = !sender.selected;
        if (sender.selected)
        {
            self.info.sex = @"女";
        }
        else
        {
            self.info.sex = @"男";
        }
    }
}


#pragma mark - lazyLoading

- (UIImageView *)headButton
{
    if (_headButton == nil)
    {
        _headButton =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 2.5, 55, 55)];
        _headButton.image = IMG(@"label_Head-Portraits");
    }
    return _headButton;
}

- (UITextField *)textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, 0, SCREEN_WIDTH-60/375.0*SCREEN_WIDTH, CELL_HEIGHT)];
        [_textField addTarget:self action:@selector(textChangeAction:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (PlaceholderTextView *)textView
{
    if (_textView == nil)
    {
        _textView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, 0, SCREEN_WIDTH-60/375.0*SCREEN_WIDTH, CELL_FOOT_HEIGHT-1)];
        _textView.placeholder = @"请输入过敏史";
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.placeholderColor = RGB(199, 199, 199);
    }
    return _textView;
}

- (UIView *)sexSelect
{
    if (_sexSelect == nil)
    {
        _sexSelect = [[UIView alloc] initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, 0, SCREEN_WIDTH-60/375.0*SCREEN_WIDTH, CELL_HEIGHT-1)];
        
        UIButton *manButton = [UIButton buttonWithType:UIButtonTypeCustom];
        manButton.frame = CGRectMake(0, (CELL_HEIGHT-20)/2, 20, 20);
        manButton.tag = 520;
        [manButton setBackgroundImage:IMG(@"contactUnSelect") forState:UIControlStateNormal];
        [manButton setBackgroundImage:IMG(@"contactSelect") forState:UIControlStateSelected];
        [manButton addTarget:self action:@selector(selectdButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *manLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(manButton)+10, 0, 30, CELL_HEIGHT)];
        manLabel.textColor = [UIColor blackColor];
        manLabel.text = @"男";
        
        UIButton *womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        womanButton.frame = CGRectMake(MaxX(manLabel)+20, (CELL_HEIGHT-20)/2, 20, 20);
        womanButton.tag = 521;
        [womanButton setBackgroundImage:IMG(@"contactUnSelect") forState:UIControlStateNormal];
        [womanButton setBackgroundImage:IMG(@"contactSelect") forState:UIControlStateSelected];
        [womanButton addTarget:self action:@selector(selectdButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *womanLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(womanButton)+10, 0, 30, CELL_HEIGHT)];
        womanLabel.textColor = [UIColor blackColor];
        womanLabel.text = @"女";
        
        [_sexSelect addSubview:manButton];
        [_sexSelect addSubview:manLabel];
        [_sexSelect addSubview:womanButton];
        [_sexSelect addSubview:womanLabel];
    }
    return _sexSelect;
}


#pragma mark - setter

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            if (self.info.headImage)
            {
                self.headButton.image = self.info.headImage;
            }
            else
            {
                self.headButton.image = IMG(@"label_Head-Portraits");
            }
            
        }
        if (indexPath.row == 3)
        {
            self.textField.text = self.info.birthDay;
        }
    }
}

@end

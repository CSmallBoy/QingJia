//
//  HCGradeManagerTableViewCell.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGradeManagerTableViewCell.h"
#import "HCFriendMessageInfo.h"

#import "HCCreateGradeInfo.h"

@interface HCGradeManagerTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *codeImgView;
@property (nonatomic, strong) UILabel *statusLabel;


@end

@implementation HCGradeManagerTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - private methods

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(HCGradeManagerTableViewCellSelectedTag:)])
    {
        [self.delegate HCGradeManagerTableViewCellSelectedTag:button.tag];
    }
}
//这个地方需要进行修改
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    if (indexPath.section == 0)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
        if (_IsAble) {
            self.textField.enabled = YES;
        }else{
            self.textField.enabled = NO;
        }
        
        if (indexPath.row == 1)
        {
            self.titleLabel.text = @"家庭ID";
            [self.contentView addSubview:self.codeImgView];
            self.textField.text = [HCAccountMgr manager].loginInfo.createFamilyId;;
            //self.textField.placeholder = @"this is familyID";
            self.textField.enabled = NO;
        }
        //        else if (indexPath.row == 2)
        //        {
        //            self.titleLabel.text = @"个性签名";
        //            self.textField.text = _info.familyDescription;
        //            //self.textField.placeholder = @"请输入家庭地址";
        //            self.textField.placeholder = @"请输入个性签名";
        //        }
    }
    
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            self.titleLabel.text = [NSString stringWithFormat:@"家庭成员（%lu人）",(unsigned long)_array.count];
            self.titleLabel.frame = CGRectMake(15, 10, 120, 24);
            _number = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-25, 4, 16, 16)];
            _number.text = @"88";
            _number.textColor = [UIColor whiteColor];
            _number.backgroundColor = [UIColor redColor];
            _number.textAlignment = NSTextAlignmentCenter;
            _number.font = [UIFont systemFontOfSize:10];
            ViewBorderRadius(_number, 7, 1, [UIColor redColor]);
            [self.contentView addSubview:_number];
            
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.statusLabel];
        }else
        {
            //            [self.contentView removeAllSubviews];
            //            for (NSInteger i = 0; i < _array.count+2; i++)
            //            {
            //
            //                CGFloat width = SCREEN_WIDTH*0.17;
            //                CGFloat buttonX = i%4 *width + ((i%4+1)*20);
            //                CGFloat buttonY = i/4 *(width+20) + ((i/4+1)*10);
            //                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //                button.frame = CGRectMake(buttonX, buttonY, width, width);
            //                //[button setImage:_image forState:UIControlStateNormal];
            //
            //
            //                HCFriendMessageInfo *info;
            //                if (i < _array.count) {
            //                     info = _array[i];
            //                }
            //
            //                UIScrollView *ButtonSv = [[UIScrollView alloc]init];
            //                ButtonSv.frame = CGRectMake(0, 0, SCREEN_WIDTH, MaxY(button));
            //
            //                [self.contentView addSubview:ButtonSv];
            //
            //
            //                UIImageView *ima = [[UIImageView alloc]init];
            //                [ima sd_setImageWithURL:[readUserInfo url:info.imageName :kkUser]];
            //                [button setImage:ima.image forState:UIControlStateNormal];
            //                button.tag = i;
            //               // [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            //                [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
            //                ViewRadius(button, width/2);
            //               // [self.contentView addSubview:button];
            //                [ButtonSv addSubview:button];
            //
            //
            //                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, MaxY(button), button.frame.size.width, 20)];
            //                title.text = info.nickName;
            //                title.textAlignment = NSTextAlignmentCenter;
            //                title.font = [UIFont systemFontOfSize:13];
            //                if(i == _array.count){
            //                    [button setImage:IMG(@"Classinfo_but_plus") forState:UIControlStateNormal];
            //                     title.text = @"添加成员";
            //                }
            //                else if(i == _array.count +1)
            //                {
            //                   // [button setImage:IMG(@"Classinfo_but_plus") forState:UIControlStateNormal];
            //                  //  title.text = @"删除成员";
            //                }
            //                [self.contentView addSubview:title];
            //            }
        }
    }
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remove_message_num) name:@"audit_num" object:nil];
}
//移除
//- (void)remove_message_num{
//    [_number removeFromSuperview];
//}]

//-(void)btnClick:(UIButton) btn
//{
//    btn.selected = !btn.selected;
//
//    self.
//}
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 70, 24)];
        _titleLabel.textColor = DarkGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100, 44)];
    }
    return _textField;
}

- (UIImageView *)codeImgView
{
    if (!_codeImgView)
    {
        _codeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 7, 30, 30)];
        _codeImgView.image = OrigIMG(@"person-message_2D-barcode");
    }
    return _codeImgView;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 10, 40, 24)];
        _statusLabel.textColor = kHCNavBarColor;
        _statusLabel.font = [UIFont systemFontOfSize:15];
        _statusLabel.text = @"审核";
        
    }
    return _statusLabel;
}


@end

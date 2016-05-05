//
//  HCUserCodeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUserCodeViewController.h"

@interface HCUserCodeViewController ()

@end

@implementation HCUserCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的二维码";
    [self setupBackItem];
    self.view.backgroundColor = [UIColor grayColor];
    //如果完善过信息执行makeUI
    [self makeUI];
}

- (void)makeUI{
    UIView *view_back = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.07, SCREEN_HEIGHT*0.2, SCREEN_WIDTH *0.86, SCREEN_WIDTH *0.90+5)];
    view_back.backgroundColor = [UIColor whiteColor];
    UIImageView *Image_head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, SCREEN_WIDTH *0.15, SCREEN_WIDTH *0.15)];
    UILabel *nick_label = [[UILabel alloc]initWithFrame:CGRectMake(20 + SCREEN_WIDTH*0.2, 12, SCREEN_WIDTH*0.6, 20)];
    UILabel *userId_label = [[UILabel alloc]initWithFrame:CGRectMake(20 + SCREEN_WIDTH*0.2, 35, SCREEN_WIDTH*0.6, 20)];
    UILabel *Individuality_label = [[UILabel alloc]initWithFrame:CGRectMake(20 + SCREEN_WIDTH*0.2, 55, SCREEN_WIDTH*0.6, 20)];
    UIImageView *code_image = [[UIImageView alloc]initWithFrame:CGRectMake(view_back.frame.size.width*0.1, 70, view_back.frame.size.width*0.8, view_back.frame.size.width*0.8)];
    //赋值
    //1 只要登录就会存在本地  这是毋庸置疑的
    NSDictionary *dict = [readUserInfo getReadDic];
    nick_label.text = dict[@"UserInf"][@"nickName"];
    userId_label.text = dict[@"UserInf"][@"userId"];
    Individuality_label.text =dict[@"UserInf"][@"userDescription"];
    UIImage *image = [readUserInfo creatQrCode:userId_label.text];
    code_image.image = image;
    if (IsEmpty(_head_image)) {
        if (IsEmpty(dict[@"PhotoStr"])) {
        }else{
            [Image_head sd_setImageWithURL:[readUserInfo url:dict[@"PhotoStr"] :kkUser] placeholderImage:IMG(@"Head-Portraits")];
        }
    }else{
        [Image_head sd_setImageWithURL:[readUserInfo url:_head_image :kkUser] placeholderImage:IMG(@"Head-Portraits")];
        
    }
    [view_back addSubview:Image_head];
    [view_back addSubview:nick_label];
    [view_back addSubview:userId_label];
    [view_back addSubview:Individuality_label];
    [view_back addSubview:code_image];
    [self.view addSubview:view_back];
    
}

@end

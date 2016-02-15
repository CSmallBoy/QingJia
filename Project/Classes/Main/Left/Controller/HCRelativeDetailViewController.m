//
//  HCRelativeDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRelativeDetailViewController.h"

@interface HCRelativeDetailViewController ()

@end

@implementation HCRelativeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _title_name;
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUI];
    // Do any additional setup after loading the view.
}

-(void)makeUI
{
    //头像
    UIImageView * head_image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 64+15, SCREEN_HEIGHT*0.115, SCREEN_HEIGHT*0.115)];
    head_image.image = [UIImage imageNamed:@"image_hea.jpg"];
    ViewBorderRadius(head_image, SCREEN_HEIGHT*0.115*0.5, 1, [UIColor redColor]);
    [self.view addSubview:head_image];
    //出生日期
    UILabel *label_birthday = [[UILabel alloc]initWithFrame:CGRectMake(5, 64+15+15+SCREEN_HEIGHT*0.115, 80, 20)];
    label_birthday.font = [UIFont systemFontOfSize:15];
    label_birthday.text = @"出生日期";
    [self.view addSubview:label_birthday];
    UITextField *textf;
    for (int  i = 0; i < 3; i ++)
    {
        textf = [[UITextField alloc]init];
        switch (i)
        {
            case 0:
            {
                textf.frame = CGRectMake(25 + SCREEN_HEIGHT*0.115, 64+15, SCREEN_WIDTH*0.5, 30);
                textf.placeholder = @"姓名";
            }
                break;
            case 1:
            {
                textf.frame = CGRectMake(25+ SCREEN_HEIGHT*0.115, 64+15+30, SCREEN_WIDTH*0.5, 30);
                textf.placeholder = @"男";
                
            }
                break;
            case 2:
            {
                textf.frame = CGRectMake(30+40, 64+30+SCREEN_HEIGHT*0.115, SCREEN_WIDTH*0.5, 30);
                textf.placeholder = @"请输入出生日期";
            }
                break;
            default:
                break;
                
        }
        [textf setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [self.view addSubview:textf];
    }

    [self.view addSubview:label_birthday];
    
}

@end

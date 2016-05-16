//
//  HCBindTwoViewController.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCBindTwoViewController.h"
#import "NHCBindPhoneNumAPi.h"
@interface HCBindTwoViewController ()<UITextFieldDelegate>{
    UITextField *text_tf;
    UILabel *label;
    NSString *phone;
}

@end

@implementation HCBindTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"123";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        return 300;
    }else{
        return 44;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (Cell==nil) {
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 70, 30)];
        label.text = @"新的手机号";
        text_tf= [[UITextField alloc]initWithFrame:CGRectMake(label.bounds.size.width+10, 5, SCREEN_WIDTH-20 - label.bounds.size.width, 30)];
        text_tf.delegate = self;
        [Cell addSubview:label];
        [Cell addSubview:text_tf];
    }
    if (indexPath.row==1) {
        [label removeFromSuperview];
        [text_tf  removeFromSuperview];
        UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        UIButton  *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.frame = CGRectMake(15, 30, SCREEN_WIDTH-30, 30) ;
        [nextBtn setBackgroundColor:COLOR(222, 35, 46, 1)];
        //    [nextBtn addTarget:self action:@selector(nextStop:) forControlEvents:UIControlEventTouchUpInside];
        [nextBtn addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
        [nextBtn setTitle:@"确定修改绑定" forState:UIControlStateNormal];
        
        ViewRadius(nextBtn, 5);
        [view addSubview:nextBtn];
        
        
        UILabel  *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH, 15)];
        blueLabel.text = @"《服务协议》《隐私协议》";
        blueLabel.textAlignment = NSTextAlignmentCenter;
        blueLabel.font = [UIFont systemFontOfSize:10];
        blueLabel.textColor = COLOR(49, 162, 246, 1);
        blueLabel.adjustsFontSizeToFitWidth = YES;
        [view addSubview:blueLabel];
        [Cell addSubview:view];
    }
    return Cell;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    phone = textField.text;
}
-(void)button{
    NHCBindPhoneNumAPi *api = [[NHCBindPhoneNumAPi alloc]init];
    api.PhoneNum = phone;
    api.theCode = _code;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        [self showHUDView:@"修改成功"];
    }];
}


@end

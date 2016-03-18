//
//  HCMTalkApplyAfterSaleController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMTalkApplyAfterSaleController.h"
#import "HCMtalkMyOrderInfo.h"

@interface HCMTalkApplyAfterSaleController ()

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) HCMtalkMyOrderInfo *info;

@end

@implementation HCMTalkApplyAfterSaleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请售后";
    [self setupBackItem];
    
    [self.view addSubview:self.myTableView];
}


#pragma mark ---- tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 3) {
        return 1;
    }
    else
    {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    else if (indexPath.section == 1)
    {
        return 44;
    }
    else if (indexPath.section == 2)
    {
        if ( indexPath.row == 0) {
            return 44;
        }
        else
        {
            return 80;
        }
        
    }
    else
    {
        return 120;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section == 0) {
        
        UIImageView * bigIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        bigIV.image = IMG(@"1");
        [cell addSubview:bigIV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, SCREEN_WIDTH-120, 40)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@"套餐A M-talk二维码标签10张+M-talk烫印机1个" ];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 2)];
        
        label.attributedText = attStr;
        label.numberOfLines = 0;
        [cell addSubview:label];
        
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(120,CGRectGetMaxY(label.frame) +5, 50, 20)];
        numLabel.text = @"X1";
        numLabel.textColor = [UIColor blackColor];
        [cell addSubview:numLabel];
        
        UILabel *priceLabe = [[UILabel alloc]initWithFrame:CGRectMake(120,CGRectGetMaxY(numLabel.frame)+5, 80, 30)];
        priceLabe.textColor = [UIColor blackColor];
        priceLabe.text = self.info.price;
        [cell addSubview:priceLabe];
        return cell;

    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"退货选择  M-Talk烫印机"];
            [attStr addAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 3)];
            
            cell.textLabel.attributedText = attStr;
        }
        else
        {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"退货款 8.9元"];
            [attStr addAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 3)];
            
            cell.textLabel.attributedText = attStr;
   
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"退货原因";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [UIColor grayColor];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 6, 80, 30)];
            label.text = @"不能烫印标签";
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentRight;
            
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
        else
        {
            UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 60)];
            textView.text = @"原因描述";
            textView.textColor = [UIColor blackColor];
            [cell addSubview:textView];
        
        }
        
        
    }
    else
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
        titleLabel.text = @"上传图片";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 50, 50, 50);
        [button setBackgroundImage:IMG(@"") forState:UIControlStateNormal];
    
    }
    
    
    
    return nil;
}


#pragma mark --- private mothod


- (HCMtalkMyOrderInfo *)info
{
    if(!_info){
        _info = [[HCMtalkMyOrderInfo alloc]init];
        _info.title = @"套餐A M-talk二维码标签10张+M-talk烫印机1个";
        _info.price = @"￥9.9元";

    }
    return _info;
}


- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        _myTableView.backgroundColor = kHCBackgroundColor;
        
    }
    return _myTableView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end

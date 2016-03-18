//
//  HCMtalkAuditThroughController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkAuditThroughController.h"

@interface HCMtalkAuditThroughController ()

@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation HCMtalkAuditThroughController

- (void)viewDidLoad {
    [super viewDidLoad];
    // ------------------------审核通过--------------------------------
    self.title = @"审核通过";
    [self setupBackItem];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footerView];
    
}

#pragma mark --- tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 120;
    }
    else if (indexPath.section == 1)
    {
        return 44;
    }
    else
    {
        if (indexPath.row == 0 || indexPath.row == 2)
        {
            return 44;
        }
        else
        {
            return 120;
        }
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section == 0)
    {
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
        priceLabe.text = @"￥9.9元";
        [cell addSubview:priceLabe];
        
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"退货选择  M-Talk烫印机"];
            [attStr addAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 4)];
            cell.textLabel.attributedText = attStr;
            
            UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"➖",@"1",@"➕"]];
            segment.frame = CGRectMake(SCREEN_WIDTH-160, 6, 150, 30);
            segment.backgroundColor = [UIColor whiteColor];
            segment.tintColor = [UIColor grayColor];
            [cell addSubview:segment];
            
        }
        else
        {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"退货款 8.9元"];
            [attStr addAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 4)];
            
            cell.textLabel.attributedText = attStr;
            
        }
    }
    else
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
            [cell addSubview:label];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row ==1)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-10, 30)];
            label.textColor = [UIColor blackColor];
            label.text = @"原因描述：烫印机烫不了标签，想退货";
            [cell addSubview:label];
            
            for (int i =0; i<3; i++)
            {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+70*i, 50, 60, 60)];
                imageView.image = IMG(@"1");
                [cell addSubview:imageView];
            }
            
        }
        else
        {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"退款去向 微信钱包"];
            [attStr addAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 4)];
            cell.textLabel.attributedText = attStr;
        }
        
    }
    
    return cell;
}



#pragma mark --- setter Or getter


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


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        imageView.image = IMG(@"answer");
        [button addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 60, 30)];
        label.textColor = OrangeColor;
        label.text = @"联系客服";
        label.adjustsFontSizeToFitWidth= YES;
        
        [button addSubview:imageView];
        [button addSubview:label];
        
        [_footerView addSubview:button];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(110, 0,SCREEN_WIDTH-110 , 50);
        [rightBtn setTitle:@"审核通过" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.backgroundColor = OrangeColor;
        
        [_footerView addSubview:rightBtn];
    }
    return _footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

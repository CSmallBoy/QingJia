//
//  HCMtalkMyOrderFinisheController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkMyOrderFinisheController.h"
#import "HCMTalkApplyAfterSaleController.h"

#import "HCMyOrderDetailInfo.h"

@interface HCMtalkMyOrderFinisheController ()

@property (nonatomic,strong) HCMyOrderDetailInfo *info;
@property (nonatomic,strong) UITableView * myTableView;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation HCMtalkMyOrderFinisheController

// ---------------------------我的订单完成-----------------------------
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"完成";
    [self setupBackItem];
    [self requestData];
    self.view.backgroundColor = kHCBackgroundColor;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);

    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footerView];
}

#pragma mark --- tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    else if (section == 1)
    {
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
    if (section == 3) {
        return 0.1;
    }
    else
    {
        return 8;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    else if (indexPath.section == 1)
    {
        return 120;
    }
    else if (indexPath.section== 2)
    {
        if (indexPath.row == 0) {
            
            return 44;
        }
        else
        {
            return 70;
        }
        
    }
    else
    {
        if (indexPath.row == 0) {
            return 60;
        }
        else
        {
            return 44;
        }
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0 ) {
        
     
        
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = [NSString stringWithFormat:@"订单号：%@",self.info.orderNum];
            }
                break;
    
            case 1:
            {
                
                UIImageView *smallIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
                smallIV.image = IMG(@"person");
                [cell addSubview:smallIV];
                
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(45, 6, 70, 30)];
                lable.textColor = [UIColor blackColor];
                lable.adjustsFontSizeToFitWidth = YES;
                lable.text = self.info.name;
                [cell addSubview:lable];
                
                UIImageView *telIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable.frame)+10, 12, 15, 20)];
                telIV.image = IMG(@"phone");
                [cell addSubview:telIV];
                
                
                UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(telIV.frame)+5, 6,100 , 30)];
                telLabel.textColor = [UIColor blackColor];
                telLabel.adjustsFontSizeToFitWidth = YES;
                telLabel.text = self.info.telNum;
                [cell addSubview:telLabel];

                
            }
                break;
            case 2:
            {

                UIImageView *smallIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
                smallIV.image = IMG(@"yihubaiying_but_Pointe");
                [cell addSubview:smallIV];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(smallIV.frame)+5, 6, SCREEN_WIDTH-60, 30)];
                label.textColor = [UIColor blackColor];
                label.adjustsFontSizeToFitWidth = YES;
                label.text = self.info.address;
                [cell addSubview:label];
            
                
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"您的快递已经签收，欢迎再次光临M-Talk商城~";
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
                break;
            default:
                break;
        }

    }
    else if (indexPath.section == 1)
    {  UIImageView * bigIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
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
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            
        
            cell.textLabel.text = @"支付方式";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 6, 70, 30)];
            label.text = @"微信支付";
            label.textColor = [UIColor blackColor];
            
            [cell addSubview:label];
            
           

        }
        else
        {
            UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
            timeLabel.textColor = [UIColor blackColor];
            timeLabel.text = @"时间信息";
            [cell addSubview:timeLabel];
            
            UILabel *buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 200, 15)];
            buyLabel.textColor = [UIColor lightGrayColor];
            buyLabel.font = [UIFont systemFontOfSize:13];
            buyLabel.text = [NSString stringWithFormat:@"下单时间：%@",self.info.buyTime];
            [cell addSubview:buyLabel];
            
            UILabel *sendLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 15)];
            sendLabel.textColor = [UIColor lightGrayColor];
            sendLabel.font = [UIFont systemFontOfSize:13];
            sendLabel.text = [NSString stringWithFormat:@"配送时间：%@",self.info.sendTime];
            [cell addSubview:sendLabel];

        }
        return cell;
    }
    
    else
    {
        if (indexPath.row == 0) {

            UILabel * allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
            allPriceLabel.textColor = [UIColor blackColor];
            allPriceLabel.adjustsFontSizeToFitWidth = YES;
            allPriceLabel.text = @"商品总额";
            [cell addSubview:allPriceLabel];
            
            UILabel * disCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 80, 20)];
            disCountLabel.textColor = [UIColor redColor];
            disCountLabel.text = @"满一百减二十";
            disCountLabel.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:disCountLabel];
            
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 6, 70, 30)];
            label.textAlignment = NSTextAlignmentRight;
            label.text = @"￥199.9";
            label.textColor = [UIColor redColor];
            [cell addSubview:label];
            
            UILabel *disCountNumLB = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 35, 70, 30)];
            disCountNumLB.textAlignment = NSTextAlignmentRight;
            disCountNumLB.text = @"-￥20";
            disCountNumLB.textColor = [UIColor redColor];
            [cell addSubview:disCountNumLB];
        }
        else
        {
            
            UILabel *disCountNumLB = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 6, 110, 30)];
            disCountNumLB.textAlignment = NSTextAlignmentRight;
            disCountNumLB.text = [NSString stringWithFormat:@"实付款%@",self.info.factPrice];
            disCountNumLB.textColor = [UIColor redColor];
            [cell addSubview:disCountNumLB];

            return cell;
        }
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark --- private mothods

-(void)buttonClick:(UIButton *)button
{
    if (button.tag == 101) {
        
        HCMTalkApplyAfterSaleController *applyVC = [[HCMTalkApplyAfterSaleController alloc]init];
        [self.navigationController pushViewController:applyVC animated:YES];
        
    }
}


#pragma mark --- setter Or getter


- (HCMyOrderDetailInfo *)info
{
    if(!_info){
        _info = [[HCMyOrderDetailInfo alloc]init];
        _info.orderNum = @"1234567890";
        _info.name = @"Tim";
        _info.telNum = @"12345678909";
        _info.address = @"上海市闵行区集心路168号1号楼507 【邮编：123344】";
        _info.title = @"套餐A M-Talk二维码标签10张+M-talk烫印机1个";
        _info.price = @"￥9.9元";
        _info.buyTime = @"2016-03-01 9:00";
        _info.sendTime = @"2016-03-01 16:00";
        _info.allPrice = @"￥199.9";
        _info.factPrice = @"￥179.9";
    }
    return _info;
}


- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
        _myTableView.delegate   =self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = kHCBackgroundColor;
    }
    return _myTableView;
}



- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _footerView.backgroundColor = kHCBackgroundColor;
        
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
        
        NSArray *arr = @[@"删除订单",@"申请售后",@"再次订购"];
        
        for (int i = 0; i<3; i++)
        {
            CGFloat jiange = (SCREEN_WIDTH-110)/3;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(110+jiange *i, 10, jiange-10, 30) ;
            btn.layer.borderWidth = 1;
            btn.tag = 100 + i;
            btn.layer.borderColor = kHCBackgroundColor.CGColor;
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            if (i!=2) {
            
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
            }
            else
            {
                
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor redColor];

            }
            
            ViewRadius(btn, 5);
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_footerView addSubview:btn];
            
        }
        
        
        
    }
    return _footerView;
}



#pragma mark --- network
-(void)requestData
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

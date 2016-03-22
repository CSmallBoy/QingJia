//
//  HCProductDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCProductDetailController.h"

#import "HCProductShopingCarController.h"

#import "HCMtalkShopingInfo.h"

@interface HCProductDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * mytableView;
@property (nonatomic,strong) HCMtalkShopingInfo *info;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation HCProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // -------------------商品详情-------------------------------
    self.title = @"商品详情";
    [self setupBackItem];
    self.view.backgroundColor = kHCNavBarColor;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"shopingCar") style:UIBarButtonItemStylePlain target:self action:@selector(shopingCarItemClick:)];
    self.navigationItem.rightBarButtonItem = right;
    self.info = self.data[@"info"];
    UIImageView *imageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    imageVIew.image = IMG(@"girl");
    self.mytableView.tableHeaderView = imageVIew;
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mytableView];
    [self.view addSubview:self.footerView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    
}

-(void)viewWillAppear:(BOOL)animated
{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=kHCNavBarColor;
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

#pragma mark ---- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 110;
    }
    else if (indexPath.row == 1)
    {
        return 44;
    }
    else if (indexPath.row == 2)
    {
        return 44;
    }
    else
    {
        return 55;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.row == 0) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20,40)];
        label.textColor = [UIColor lightGrayColor];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:self.info.title];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 3)];
        label.adjustsFontSizeToFitWidth = YES;
        label.attributedText = attStr;
        [cell addSubview:label];
        
        UILabel *temaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 50, 15)];
        temaiLabel.text = @"特卖";
        temaiLabel.textColor = COLOR(222, 46, 35, 1);
        temaiLabel.layer.borderWidth = 1;
        temaiLabel.layer.borderColor = COLOR(222, 46, 35, 1).CGColor;
        temaiLabel.textAlignment = NSTextAlignmentCenter;
        ViewRadius(temaiLabel, 10);
        temaiLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:temaiLabel];
        
        
        UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 60, 100, 15)];
        blueLabel.text = @"满一百二十减二十";
        blueLabel.backgroundColor = COLOR(48, 123, 225, 1);
        blueLabel.textColor = [UIColor whiteColor];
        blueLabel.textAlignment = NSTextAlignmentCenter;
        blueLabel.font = [UIFont systemFontOfSize:12];
        ViewRadius(blueLabel, 10);
        blueLabel.adjustsFontSizeToFitWidth = YES;
        [cell addSubview:blueLabel];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,75 , 70, 30)];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:17];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.text = [NSString stringWithFormat:@"￥%@元",self.info.price];
        priceLabel.adjustsFontSizeToFitWidth = YES;
        [cell addSubview:priceLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kHCBackgroundColor;
        [cell addSubview:lineView];
        
    }
    else if (indexPath.row == 1)
    {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"数量选择 套餐A1个"];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 2)];
        label1.attributedText = attStr;
        [cell addSubview:label1];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kHCBackgroundColor;
        [cell addSubview:lineView];
        
    }
    else if (indexPath.row == 2)
    {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"服务 由顺丰快递发货，M-talk商城提供售后服务"];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 2)];
        label1.attributedText = attStr;
        [cell addSubview:label1];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kHCBackgroundColor;
        [cell addSubview:lineView];
        
    }
    else
    {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"提示 M-talk烫印机支持7天无理由退货"];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 2)];
        label1.attributedText = attStr;
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 35, 300, 20)];
        label2.text = @"M-talk标签不支持退货";
        label2.textColor = [UIColor blackColor];
        label2.adjustsFontSizeToFitWidth = YES;
        [cell addSubview:label1];
        [cell addSubview:label2];
        
    }
    
    return cell;
}


#pragma mark --- private mothods

-(void)shopingCarItemClick:(UIBarButtonItem *)right
{
   
}

-(void)buttonClick:(UIButton *)button
{
    if (button.tag == 100) {
        
        HCProductShopingCarController *shopingCarVC = [[HCProductShopingCarController alloc]init];
        shopingCarVC.data  = @{@"info" : self.info};
        
        [self.navigationController pushViewController:shopingCarVC animated:YES];
        
    }

}

#pragma mark ---- getter or setter


- (UITableView *)mytableView
{
    if(!_mytableView){
        _mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.backgroundColor = [UIColor whiteColor];
    }
    return _mytableView;
}


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _footerView.backgroundColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        imageView.image = IMG(@"answer");
        [button addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 60, 30)];
        label.textColor = OrangeColor;
        label.text = @"联系客服";
        label.adjustsFontSizeToFitWidth= YES;
        
        [button addSubview:imageView];
        [button addSubview:label];
        
        [_footerView addSubview:button];
        
        NSArray *arr = @[@"加入购物车",@"即刻购买"];
        
        for (int i = 0; i<2; i++)
        {
            CGFloat jiange = (SCREEN_WIDTH-150)/2;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(150+jiange *i, 10, jiange-10, 30) ;
            btn.layer.borderWidth = 1;
            btn.tag = 100 + i;
            btn.layer.borderColor = kHCBackgroundColor.CGColor;
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if (i==0)
            {
                btn.backgroundColor = OrangeColor;
            }
            else
            {
                btn.backgroundColor = COLOR(222, 46, 35, 1);
                
            }
            
            ViewRadius(btn, 5);
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_footerView addSubview:btn];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = kHCBackgroundColor;
            
            [_footerView addSubview:lineView];
            
    }
    }
    return _footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end

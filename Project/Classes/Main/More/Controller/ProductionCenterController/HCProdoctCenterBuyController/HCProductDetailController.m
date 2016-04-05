//
//  HCProductDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCProductDetailController.h"
#import "HCSureTheOrderController.h"
#import "HCProductShopingCarController.h"

#import "HCMtalkShopingInfo.h"

@interface HCProductDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * mytableView;
@property (nonatomic,strong) HCMtalkShopingInfo *info;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,strong) UIView *segmentView;
@property (nonatomic,strong) UILabel  *label;
@property (nonatomic,strong) UILabel *labelNum;

@property (nonatomic,strong) UIView *blackView;
@property (nonatomic,strong) UIView *rightView;
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
        _labelNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"数量选择 套餐A1个"];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 4)];
        _labelNum.attributedText = attStr;
        [cell addSubview:_labelNum];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kHCBackgroundColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell addSubview:lineView];
        
    }
    else if (indexPath.row == 2)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"服务 由顺丰快递发货，M-talk商城提供售后服务"];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 2)];
        label.attributedText = attStr;
        [cell addSubview:label];
        
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
       
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH*0.7, SCREEN_HEIGHT)];
        _rightView.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 80, 80)];
        imageView.image = IMG(@"1");
        [_rightView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 100, 30)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = [self.info.title substringToIndex:3];
        [_rightView addSubview:titleLabel];
        
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 80, 100, 30)];
        priceLabel.textColor = [UIColor blackColor];
        priceLabel.text = [NSString stringWithFormat:@"￥%@元",self.info.price];
        [_rightView addSubview:priceLabel];

        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 50, 30)];
        textLabel.textColor = [UIColor blackColor];
        textLabel.text = @"数量";
        [_rightView addSubview:textLabel];
        
        
        _segmentView = [[UIView alloc]initWithFrame:CGRectMake(50, 110, 150/375.0*SCREEN_WIDTH, 30)];
        _segmentView.layer.borderWidth = 1;
        _segmentView.layer.borderColor = kHCBackgroundColor.CGColor;
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:@"-" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.layer.borderWidth = 1;
        [button1 addTarget:self action:@selector(minusNum) forControlEvents:UIControlEventTouchUpInside];
        button1.frame = CGRectMake(0, 0, 50/375.0*SCREEN_WIDTH, 30);
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(50/375.0*SCREEN_WIDTH, 0, 50/375.0*SCREEN_WIDTH, 30)];
        self.label.text =@"1";
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setTitle:@"+" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
        button3.layer.borderWidth =1;
        button3.frame = CGRectMake(50/375.0*SCREEN_WIDTH*2, 0, 50/375.0*SCREEN_WIDTH, 30);
        
        [_segmentView addSubview:button1];
        [_segmentView  addSubview:self.label];
        [_segmentView addSubview:button3];
        
        [_rightView addSubview:_segmentView];
        
        
        NSArray *colors = @[OrangeColor,kHCNavBarColor];
        NSArray *titles = @[@"加入购物车",@"即刻购买"];
        for (int i= 0; i<2; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * SCREEN_WIDTH*0.7/2, SCREEN_HEIGHT-50, SCREEN_WIDTH*0.7/2, 50);
            btn.backgroundColor = colors[i];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buyOrJoinShopingCar:) forControlEvents:UIControlEventTouchUpInside];
            [_rightView addSubview:btn];
        }
        
        
        [self.navigationController.view addSubview:_rightView];
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _rightView.frame = CGRectMake(SCREEN_WIDTH*0.3, 0, SCREEN_WIDTH*0.7, SCREEN_HEIGHT);
        }completion:^(BOOL finished) {
            
            [self.navigationController.view addSubview:self.blackView];
            self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        
    }
}

#pragma mark --- private mothods


-(void)minusNum
{
    NSInteger num = [self.label.text integerValue];
    
    if (num==1) {
        return;
    }
    num = num - 1;
    self.label.text = [NSString stringWithFormat:@"%ld",(long)num];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"数量选择 套餐A%ld个",(long)num]];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 4)];
    _labelNum.attributedText = attStr;
}

-(void)addNum
{
    NSInteger num = [self.label.text integerValue];
    num = num+1;
    self.label.text = [NSString stringWithFormat:@"%ld",(long)num];
    self.label.text = [NSString stringWithFormat:@"%ld",(long)num];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"数量选择 套餐A%ld个",(long)num]];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 4)];
    _labelNum.attributedText = attStr;
}

-(void)shopingCarItemClick:(UIBarButtonItem *)right
{
   
    HCProductShopingCarController *shopingCarVC = [[HCProductShopingCarController alloc]init];
    self.info.isSelect = NO;
    shopingCarVC.data  = @{@"info" : self.info};
    
    [self.navigationController pushViewController:shopingCarVC animated:YES];
}


-(void)tap:(UITapGestureRecognizer *)tap
{
    [self.blackView removeFromSuperview];
    [self.rightView removeFromSuperview];
}

-(void)buttonClick:(UIButton *)button
{
    if (button.tag == 100) {
        
        HCProductShopingCarController *shopingCarVC = [[HCProductShopingCarController alloc]init];
        self.info.isSelect = NO;
        shopingCarVC.data  = @{@"info" : self.info};
        
        [self.navigationController pushViewController:shopingCarVC animated:YES];
        
    }
    else
    {
        HCSureTheOrderController *sureVC = [[HCSureTheOrderController alloc]init];
        sureVC.data = @{@"info":self.info};
        [self.navigationController pushViewController:sureVC animated:YES];
    
    }

}


-(void)buyOrJoinShopingCar:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"即刻购买"]) {
     
        [self.rightView removeFromSuperview];
        [self.blackView removeFromSuperview];
        HCSureTheOrderController *sureVC = [[HCSureTheOrderController alloc]init];
        sureVC.data = @{@"info":self.info};
        [self.navigationController pushViewController:sureVC animated:YES];
    }
    else
    {
        [self.rightView removeFromSuperview];
        [self.blackView removeFromSuperview];
        
        HCProductShopingCarController *shopingCarVC = [[HCProductShopingCarController alloc]init];
        self.info.isSelect = NO;
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
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
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


- (UIView *)blackView
{
    if(!_blackView){
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_blackView addGestureRecognizer:tap];
        
    }
    return _blackView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end

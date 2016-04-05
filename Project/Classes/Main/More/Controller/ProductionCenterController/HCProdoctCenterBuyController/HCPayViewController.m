//
//  HCPayViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPayViewController.h"
#import "HCReceiveAddressController.h"
@interface HCPayViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UILabel *chooseAdressLB;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIButton *useNewAddressBtn;
@property (nonatomic,strong) UILabel  *choosePayWays;
@property (nonatomic,strong) UIButton  *surePay;
@property (nonatomic,strong) NSMutableArray  *btnArr;

@property (nonatomic,strong) UIButton  *zhifubaoBtn;
@property (nonatomic,strong) UIButton *weiChatBtn;
@property (nonatomic,strong) UIButton *unionpayBtn;


@end

@implementation HCPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //--------------------支付-----------------------------
    self.title = @"支付";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    
    [self.view addSubview:self.chooseAdressLB];
    [self.view addSubview:self.addressLabel];
    [self.view addSubview:self.useNewAddressBtn];
    [self.view addSubview:self.choosePayWays];
    [self.view addSubview:self.surePay];
    [self.view addSubview:self.zhifubaoBtn];
    [self.view addSubview:self.weiChatBtn];
    [self.view addSubview:self.unionpayBtn];
    
    
}


#pragma mark --- provite  mothods


-(void)zhifubaoBtnClick:(UIButton *)btn
{

    btn.layer.borderColor = kHCNavBarColor.CGColor;
    self.weiChatBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.unionpayBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    UILabel *label = (UILabel *)[self.weiChatBtn viewWithTag:200];
    label.textColor = [UIColor blackColor];
    UIImageView *imageView = (UIImageView *)[self.weiChatBtn viewWithTag:100];
    imageView.image = IMG(@"buttonNormal");
    
    UILabel *label1 = (UILabel *)[self.unionpayBtn viewWithTag:200];
    label1.textColor = [UIColor blackColor];
    UIImageView *imageView1 = (UIImageView *)[self.unionpayBtn viewWithTag:100];
    imageView1.image = IMG(@"buttonNormal");
    
    UILabel *label2 = (UILabel *)[btn viewWithTag:200];
    label2.textColor = kHCNavBarColor;
    UIImageView *imageView2 = (UIImageView *)[btn viewWithTag:100];
    imageView2.image = IMG(@"buttonSelected");

}

-(void)weiChatBtnClick:(UIButton *)btn
{

    btn.layer.borderColor = kHCNavBarColor.CGColor;
    self.zhifubaoBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.unionpayBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    UILabel *label = (UILabel *)[self.zhifubaoBtn viewWithTag:200];
    label.textColor = [UIColor blackColor];
    UIImageView *imageView = (UIImageView *)[self.zhifubaoBtn viewWithTag:100];
    imageView.image = IMG(@"buttonNormal");
    
    UILabel *label1 = (UILabel *)[self.unionpayBtn viewWithTag:200];
    label1.textColor = [UIColor blackColor];
    UIImageView *imageView1 = (UIImageView *)[self.unionpayBtn viewWithTag:100];
    imageView1.image = IMG(@"buttonNormal");
    
    UILabel *label2 = (UILabel *)[btn viewWithTag:200];
    label2.textColor = kHCNavBarColor;
    UIImageView *imageView2 = (UIImageView *)[btn viewWithTag:100];
    imageView2.image = IMG(@"buttonSelected");


}


-(void)unionpayBtnClick:(UIButton *)btn
{
    btn.layer.borderColor = kHCNavBarColor.CGColor;
    self.weiChatBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.zhifubaoBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    UILabel *label = (UILabel *)[self.weiChatBtn viewWithTag:200];
    label.textColor = [UIColor blackColor];
    UIImageView *imageView = (UIImageView *)[self.weiChatBtn viewWithTag:100];
    imageView.image = IMG(@"buttonNormal");
    
    UILabel *label1 = (UILabel *)[self.unionpayBtn viewWithTag:200];
    label1.textColor = [UIColor blackColor];
    UIImageView *imageView1 = (UIImageView *)[self.zhifubaoBtn viewWithTag:100];
    imageView1.image = IMG(@"buttonNormal");
    
    UILabel *label2 = (UILabel *)[btn viewWithTag:200];
    label2.textColor = kHCNavBarColor;
    UIImageView *imageView2 = (UIImageView *)[btn viewWithTag:100];
    imageView2.image = IMG(@"buttonSelected");


}

-(void)tap:(UITapGestureRecognizer *)tap
{

    HCReceiveAddressController *receivedView = [[HCReceiveAddressController alloc]init];
    [self.navigationController pushViewController:receivedView animated:YES];

    

}


#pragma mark --- getter Or setter


- (UILabel *)chooseAdressLB
{
    if(!_chooseAdressLB){
        _chooseAdressLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 84,200, 20)];
        _chooseAdressLB.textColor = [UIColor blackColor];
        _chooseAdressLB.text = @"1.选择收货地址";
        _chooseAdressLB.adjustsFontSizeToFitWidth = YES;
    }
    return _chooseAdressLB;
}


- (UILabel *)addressLabel
{
    if(!_addressLabel){
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.chooseAdressLB.frame)+5,250 ,80)];
        
        _addressLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_addressLabel addGestureRecognizer:tap];
        _addressLabel.layer.borderWidth = 1;
        _addressLabel.layer.borderColor = [UIColor blackColor].CGColor;
        
        NSArray *arr = @[@"Vivian",@"上海市闵行区集心路168号",@"18317160680"];
        
        for (int i = 0; i<3; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5+i*25, 250, 20)];
            label.text = arr[i];
            label.textColor = [UIColor blackColor];
            label.adjustsFontSizeToFitWidth = YES;
            [_addressLabel addSubview:label];
        }
    }
    return _addressLabel;
}


- (UIButton *)useNewAddressBtn
{
    if(!_useNewAddressBtn){
        _useNewAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _useNewAddressBtn.frame = CGRectMake(10, CGRectGetMaxY(self.addressLabel.frame)+10, 200, 20);
        _useNewAddressBtn.backgroundColor = kHCNavBarColor;
        [_useNewAddressBtn setTitle:@"使用新增地址" forState:UIControlStateNormal];
        [_useNewAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewRadius(_useNewAddressBtn, 5);
    }
    return _useNewAddressBtn;
}


- (UILabel *)choosePayWays
{
    if(!_choosePayWays){
        _choosePayWays = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.useNewAddressBtn.frame)+10,200, 20)];
        _choosePayWays.textColor = [UIColor blackColor];
        _choosePayWays.text = @"2.选择支付方式";
        _choosePayWays.adjustsFontSizeToFitWidth = YES;
    }
    return _choosePayWays;
}



- (UIButton *)surePay
{
    if(!_surePay){
        _surePay = [UIButton buttonWithType:UIButtonTypeCustom];
        _surePay.frame = CGRectMake(15, SCREEN_HEIGHT-35, SCREEN_WIDTH-30, 30);
        _surePay.backgroundColor = kHCNavBarColor;
        [_surePay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_surePay setTitle:@"确认支付" forState:UIControlStateNormal];
        ViewRadius(_surePay, 5);
    }
    return _surePay;
}



- (NSMutableArray *)btnArr
{
    if(!_btnArr){
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}



- (UIButton *)zhifubaoBtn
{
    if(!_zhifubaoBtn){
        _zhifubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhifubaoBtn.frame = CGRectMake(10, CGRectGetMaxY(self.choosePayWays.frame)+10 + (0 *40), SCREEN_WIDTH-20, 30);
        _zhifubaoBtn.layer.borderWidth = 1;
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 20)];
        imageView.image = IMG(@"buttonSelected");
        label.textColor = kHCNavBarColor;
        _zhifubaoBtn.layer.borderColor = kHCNavBarColor.CGColor;
        
        label.text = @"支付宝支付";
        label.adjustsFontSizeToFitWidth = YES;
        
        imageView.tag = 100;
        label.tag = 200;
        [_zhifubaoBtn addSubview:imageView];
        [_zhifubaoBtn addSubview:label];
        [_zhifubaoBtn addTarget:self action:@selector(zhifubaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhifubaoBtn;
}


- (UIButton *)weiChatBtn
{
    if(!_weiChatBtn){
        _weiChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weiChatBtn.frame = CGRectMake(10, CGRectGetMaxY(self.choosePayWays.frame)+10 + (1 *40), SCREEN_WIDTH-20, 30);
        _weiChatBtn.layer.borderWidth = 1;
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 20)];
        imageView.image = IMG(@"buttonNormal");
        label.textColor = [UIColor blackColor];
        _weiChatBtn.layer.borderColor = [UIColor blackColor].CGColor;
        
        label.text = @"微信支付";
        label.adjustsFontSizeToFitWidth = YES;
        
        imageView.tag = 100;
        label.tag = 200;
        
        [_weiChatBtn addSubview:imageView];
        [_weiChatBtn addSubview:label];
        [_weiChatBtn addTarget:self action:@selector(weiChatBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _weiChatBtn;
}



- (UIButton *)unionpayBtn
{
    if(!_unionpayBtn){
        _unionpayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _unionpayBtn.frame = CGRectMake(10, CGRectGetMaxY(self.choosePayWays.frame)+10 + (2 *40), SCREEN_WIDTH-20, 30);
        _unionpayBtn.layer.borderWidth = 1;
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 20)];
        imageView.image = IMG(@"buttonNormal");
        label.textColor = [UIColor blackColor];
        _unionpayBtn.layer.borderColor = [UIColor blackColor].CGColor;
        
        label.text = @"微信支付";
        label.adjustsFontSizeToFitWidth = YES;
        
        imageView.tag = 100;
        label.tag = 200;
        
        [_unionpayBtn addSubview:imageView];
        [_unionpayBtn addSubview:label];
        [_unionpayBtn addTarget:self action:@selector(unionpayBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _unionpayBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

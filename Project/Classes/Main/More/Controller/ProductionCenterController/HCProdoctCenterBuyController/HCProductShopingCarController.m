//
//  HCProductShopingCarController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCProductShopingCarController.h"

#import "HCShopingCarCell.h"

#import "HCMtalkShopingInfo.h"


@interface HCProductShopingCarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *editTableView;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray  *dataArr;
@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,strong) UIView  *editedFooterView;
@property (nonatomic,strong) UILabel *allPriceLabel;
@property (nonatomic,assign) CGFloat allPrice;
@property (nonatomic,strong) UIImageView *IV;
@property (nonatomic,assign) BOOL  isSelectAll;


@property (nonatomic,strong) UIView *shareView;
@property (nonatomic,strong) UIView *blackView;

@end

@implementation HCProductShopingCarController

- (void)viewDidLoad {
    [super viewDidLoad];
   // -------------------购物车-------------------------------
    self.title = @"购物车";
    self.view.backgroundColor = kHCBackgroundColor;
    [self setupBackItem];
    [self requestData];
    _allPrice = 0;
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footerView];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editedClick:)];
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=kHCNavBarColor;
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

#pragma mark --- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.myTableView) {
         return 1;
    }
    else
    {
        if (section == 0) {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myTableView)
    {
        return 100;
    }
    else
    {
        if (indexPath.section == 0 && indexPath.row == 0 ) {
            
            return 44;
        }
        else
        {
            return 100;
        }
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (tableView == self.editTableView && indexPath.section == 0 && indexPath.row == 0)
    {
        
        UITableViewCell *cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        _IV = [[UIImageView alloc]initWithFrame:CGRectMake(10,6, 30, 30)];
        if (_isSelectAll) {
            _IV.image = IMG(@"thehook");
        }
        else
        {
           _IV.image = IMG(@"addressquan");
        }
       
        
        [cell1 addSubview:_IV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 6, 100, 30)];
        label.text = @"全选";
        [cell1 addSubview:label];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    
    HCShopingCarCell *cell = [HCShopingCarCell cellWithTableView:tableView];
    cell.info = self.dataArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HCMtalkShopingInfo *info = self.dataArr[indexPath.section];
    cell.block2 = ^{
        _allPrice = _allPrice +[info.price floatValue];
         self.allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元 ",_allPrice];
        
        if ([self.allPriceLabel.text isEqualToString:@"合计：￥-0.00元"] || [self.allPriceLabel.text isEqualToString:@"合计：￥0.00元"])
        {
            self.allPriceLabel.text = @"合计：￥-";
        }
    
    };
    
    cell.block1 = ^{
        _allPrice = _allPrice-[info.price floatValue];
        self.allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元 ",_allPrice];
        if ([self.allPriceLabel.text isEqualToString:@"合计：￥-0.00元"] || [self.allPriceLabel.text isEqualToString:@"合计：￥0.00元"])
        {
            self.allPriceLabel.text = @"合计：￥-";
        }

    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myTableView)
    {
        HCMtalkShopingInfo *info = self.dataArr[indexPath.section];
        
        if (info.isSelect == NO) {
            info.isSelect = YES;
            if (info.allPrice.length>0) {
                CGFloat price = [info.allPrice floatValue];
                _allPrice = _allPrice +price;
            }
            else
            {
                CGFloat price = [info.price floatValue];
                _allPrice = _allPrice +price;
            }
            
            
            self.allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元 ",_allPrice];
            if ([self.allPriceLabel.text isEqualToString:@"合计：￥-0.00元"] || [self.allPriceLabel.text isEqualToString:@"合计：￥0.00元"])
            {
                self.allPriceLabel.text = @"合计：￥-";
            }

            
        }
        else
        {
            info.isSelect = NO;
            
            if (info.allPrice.length>0) {
                CGFloat price = [info.allPrice floatValue];
                _allPrice = _allPrice -price;
            }
            else
            {
                CGFloat price = [info.price floatValue];
                _allPrice = _allPrice -price;
            }
            
            
            self.allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元 ",_allPrice];
            if ([self.allPriceLabel.text isEqualToString:@"合计：￥-0.00元"] || [self.allPriceLabel.text isEqualToString:@"合计：￥0.00元"])
            {
                self.allPriceLabel.text = @"合计：￥-";
            }
        }
        [self.myTableView reloadData];
    }
    else
    {
        
        if (indexPath.section == 0 && indexPath.row == 0 ) {
            
            if (_isSelectAll) {
                _isSelectAll = NO;
                for (  HCMtalkShopingInfo *info in self.dataArr)
                {
                    info.isSelect = NO;
                }
            }
            else
            {
                _isSelectAll = YES;
                for (  HCMtalkShopingInfo *info in self.dataArr)
                {
                    info.isSelect = YES;
                }
            }
            [self.editTableView reloadData];
            
        }
        else
        {
            HCMtalkShopingInfo *info = self.dataArr[indexPath.section];
            
            if (info.isSelect == NO)
            {
                info.isSelect = YES;
            }
            else
            {
                info.isSelect = NO;
            }
            
            [self.editTableView reloadData];
        
        }

    }

}

#pragma mark --- provited mothods

-(void)editedClick:(UIBarButtonItem *)right
{
  
    [self.view addSubview:self.editTableView];
    [self.view addSubview:self.editedFooterView];

    UIBarButtonItem *finshed = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishedClick:)];
    self.navigationItem.rightBarButtonItem = finshed;

}

-(void)finishedClick:(UIBarButtonItem *)finished
{
    [self.editTableView removeFromSuperview];
    [self.editedFooterView removeFromSuperview];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editedClick:)];
    self.navigationItem.rightBarButtonItem = right;


}

-(void)EditBottomBtnClick:(UIButton *)btn
{
    if (btn.tag == 100) {//点击了分享按钮
        
        [self.view addSubview:self.shareView];
        [self.view addSubview:self.blackView];
        
    }
   
}


-(void)tap:(UITapGestureRecognizer *)tap
{
    [self.shareView removeFromSuperview];
    [self.blackView removeFromSuperview];

}

#pragma mark ---  setter  Or getter


- (NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = kHCBackgroundColor;
    }
    return _myTableView;
}


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH *0.6, 60)];
        leftView.backgroundColor = [UIColor lightGrayColor];
        
        [leftView addSubview:self.allPriceLabel];
        
        UILabel *disCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,40 , SCREEN_WIDTH * 0.5, 20)];
        disCountLabel.text = @"满一百减二十：-￥20";
        disCountLabel.font = [UIFont systemFontOfSize:12];
        [leftView addSubview:disCountLabel];
        
        [_footerView addSubview:leftView];
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SCREEN_WIDTH*0.6,0 , SCREEN_WIDTH*0.4, 60);
        rightBtn.backgroundColor = kHCNavBarColor;
        [rightBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_footerView addSubview:rightBtn];
        
    }
    return _footerView;
}


- (UILabel *)allPriceLabel
{
    if(!_allPriceLabel){
        _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5,SCREEN_WIDTH*0.3, 30)];
        _allPriceLabel.textColor = [UIColor blackColor];
        _allPriceLabel.text = @"合计：￥-";
        _allPriceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _allPriceLabel;
}



- (UITableView *)editTableView
{
    if(!_editTableView){
        _editTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-114) style:UITableViewStyleGrouped];
        _editTableView.delegate = self;
        _editTableView.dataSource = self;
        _editTableView.backgroundColor = kHCBackgroundColor;
    }
    return _editTableView;
}



- (UIView *)editedFooterView
{
    if(!_editedFooterView){
        _editedFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _editedFooterView.backgroundColor = [UIColor whiteColor];
        
        NSArray *arr = @[@"分享",@"删除"];
        
        for (int i = 0; i<2; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*(SCREEN_WIDTH/2), 0, SCREEN_WIDTH/2, 50);
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.tag = 100+i;
            [button addTarget:self action:@selector(EditBottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_editedFooterView addSubview:button];
        }
        
        UIView*lineView1= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = [UIColor lightGrayColor];
        [_editedFooterView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, 1, 50)];
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [_editedFooterView addSubview:lineView2];
        
        
    }
    return _editedFooterView;
}



- (UIView *)shareView
{
    if(!_shareView){
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-220/375.0*SCREEN_WIDTH, SCREEN_WIDTH, 220/375.0*SCREEN_WIDTH)];
        _shareView.backgroundColor = [UIColor whiteColor];
        
        
        NSArray *images = @[@"share_mtalk",@"WeChat",@"QQ",@"Circle-of-Friends",@"QQspace",@"Sinaweibo"];
        NSArray *names = @[@"M-Talk群聊",@"微信好友",@"QQ好友",@"朋友圈",@"QQ空间",@"新浪微博"];
        
        for (int i = 0; i<6; i++) {
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30/375.0*SCREEN_WIDTH +(i%3*(130/375.0*SCREEN_WIDTH)),20+(i/3)*110/375.0*SCREEN_WIDTH,55/375.0*SCREEN_WIDTH, 55/375.0*SCREEN_WIDTH)];
            imageView.image = IMG(images[i]);
            [_shareView addSubview:imageView];

            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x -10,imageView.frame.origin.y + imageView.frame.size.height +5, 60, 20)];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text  = names[i];
            label.font = [UIFont systemFontOfSize:10];
            
            [_shareView addSubview:label];
            
            
        }

    }
    return _shareView;
}



- (UIView *)blackView
{
    if(!_blackView){
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.shareView.frame.size.height)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_blackView addGestureRecognizer:tap];
        
    }
    return _blackView;
}




#pragma mark ---- netwotk
-(void)requestData
{

    for (int i = 0; i<3; i++)
    {
        HCMtalkShopingInfo *info = [[HCMtalkShopingInfo alloc]init];
        info.title = @"套餐A M-talk二维码标签10张优惠";
        info.price = @"9.9";
        info.discount = @"满一百减二十";
        [self.dataArr addObject:info];
    }
    
    [self.dataArr insertObject:self.data[@"info"] atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

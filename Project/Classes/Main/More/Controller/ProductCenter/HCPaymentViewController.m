//
//  HCOrderOnlineViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPaymentViewController.h"
#import "HCAddNewAddressViewController.h"
#import "HCAddressInfo.h"
#import "HCAddressApi.h"

#import "KWFormViewQuickBuilder.h"
#import "HCTagUserInfo.h"

#import "HCGoodsListTableViewCell.h"
#import "HCPayWayTableViewCell.h"

@interface HCPaymentViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UIView* beSureToPayView;
@property (nonatomic,strong) UIView* useNewAddressView;
@property (nonatomic,strong) UIView* headerView;
@property (nonatomic,strong) UILabel* headerViewLable;

@property (nonatomic,strong) UITextView *acceptGoodsAddressTextView;

@property (nonatomic,assign) CGFloat labelHeight;
//商品清单表头
@property (nonatomic,strong) NSArray* listTitleArr;

@property (nonatomic,strong) HCAddressInfo *info;

@property (nonatomic, strong) UIBarButtonItem *rightItem;
@end

@implementation HCPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"支付";
    [self setupBackItem];
    self.tableView.separatorStyle = NO;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self requestHomeData];
     self.navigationItem.rightBarButtonItem = self.rightItem;
}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        if (indexPath.section == 0)
        {
            UITableViewCell* acceptCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"acceptGoodsAddress"];
                [acceptCell.contentView addSubview:self.acceptGoodsAddressTextView];
            cell = acceptCell;
            
        }
        else if (indexPath.section == 1)
        {
            HCGoodsListTableViewCell *goodsListcell = [[HCGoodsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsList"];
            cell = goodsListcell;
        }
        else
        {
        HCPayWayTableViewCell* payCell = [[HCPayWayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"payway"];
        cell = payCell;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (IsEmpty(_info))
    {
        return 0;
    }
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (IsEmpty(_info))
    {
        return nil;
    }
    if (section == 2)
    {
        return self.beSureToPayView;
    }
    else if(section == 0)
    {
        return self.useNewAddressView;
    }else
    {
        return nil;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (IsEmpty(_info))
    {
        return nil;
    }
    _headerViewLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH(self.view)-20, 30)];
    _headerViewLable.numberOfLines = 0;
    _headerViewLable.font = [UIFont systemFontOfSize:15];
    
    
    if (section == 0)
    {
        self.headerViewLable.text = @"1.选择收货地址";
    }
    else if (section == 1)
    {
        self.headerViewLable.attributedText =  [self changeStringColorAndFontWithStart:@"2.商品清单" smallString:@"(预印板预计三天内送达，定制版十五天后发货)" end:@""];
        CGSize size = CGSizeMake(WIDTH(self.view)-20,2000);
        CGSize labelsize = [_headerViewLable.text sizeWithFont:_headerViewLable.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [_headerViewLable setFrame:CGRectMake(10,0, labelsize.width, labelsize.height)];
        _labelHeight = labelsize.height + 10;
    }
    else
    {
       self.headerViewLable.text = @"3.选择支付方式";
    }
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), _labelHeight)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.headerViewLable];
    
    return self.headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 120;
    }
    else if(indexPath.section  == 1)
    {
        return 240;
    }
    else
    {
        return 180;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ( section == 0 )
    {
        return 44;
    }if (section == 2)
    {
        return 120;
    }else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 40;
    }
    else
    {
        return MAX(44, _labelHeight);
    }
}

#pragma mark - private methods

-(void)clickGiveUpBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleBeSureToPay
{
    [self showHUDText:@"支付完成"];
}

-(void)handleUseNewAddress
{
    HCAddNewAddressViewController *addNewsAddressVC = [[HCAddNewAddressViewController alloc]init];
    [self.navigationController pushViewController:addNewsAddressVC animated:YES];
}

-(NSMutableAttributedString *)changeStringColorAndFontWithStart:(NSString *)start smallString:(NSString *)smallStr end:(NSString *)end
{
    NSMutableAttributedString *startString = [[NSMutableAttributedString alloc] initWithString:start];
    
    NSMutableAttributedString *smallString = [[NSMutableAttributedString alloc] initWithString:smallStr];
    [smallString addAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(0, smallStr.length)];
    
    
    NSMutableAttributedString *endString= [[NSMutableAttributedString alloc] initWithString:end];
    
    [startString appendAttributedString:smallString];
    [startString appendAttributedString:endString];
    return startString;
}

#pragma mark---Setter Or Getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"") style:UIBarButtonItemStylePlain target:self action:@selector(clickGiveUpBtn)];
        _rightItem.title = @"取消订单";
        
    }
    return _rightItem;
}

-(UIView *)useNewAddressView
{
    if (!_useNewAddressView)
    {
        _useNewAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        UIButton *useNewAddressbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        useNewAddressbtn.frame = CGRectMake(20, 5, SCREEN_WIDTH/2+20,30);
        [useNewAddressbtn setTitle:@"使用新地址" forState:UIControlStateNormal];
        useNewAddressbtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [useNewAddressbtn addTarget:self action:@selector(handleUseNewAddress) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(useNewAddressbtn, 4);
        useNewAddressbtn.backgroundColor = [UIColor redColor];
        _useNewAddressView.backgroundColor = [UIColor whiteColor];
        [_useNewAddressView addSubview:useNewAddressbtn];
    }
    return _useNewAddressView;
}

-(UIView *)beSureToPayView
{
    if(!_beSureToPayView)
    {
        _beSureToPayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 120)];
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(12, 40, WIDTH(self.view)-24, 44);
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [completeBtn addTarget:self action:@selector(handleBeSureToPay) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(completeBtn, 4);
        completeBtn.backgroundColor = [UIColor redColor];
        _beSureToPayView.backgroundColor = [UIColor whiteColor];
        [_beSureToPayView addSubview:completeBtn];
    }
    return _beSureToPayView;

}

-(UITextView*)acceptGoodsAddressTextView
{
        _acceptGoodsAddressTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, WIDTH(self.view)-50, 100) ];
        _acceptGoodsAddressTextView.font = [UIFont systemFontOfSize:16];
        _acceptGoodsAddressTextView.delegate = self;
        _acceptGoodsAddressTextView.backgroundColor = [UIColor clearColor];
        ViewBorderRadius(_acceptGoodsAddressTextView,0, 1, [UIColor lightGrayColor]);
        _acceptGoodsAddressTextView.scrollEnabled = NO;
        NSString *addressStr = [NSString stringWithFormat:@"  %@\n  %@ %@\n  %@",self.info.consigneeName,self.info.receivingCity,self.info.receivingStreet,self.info.phoneNumb];

        _acceptGoodsAddressTextView.text = addressStr;
        _acceptGoodsAddressTextView.editable = NO;
    return _acceptGoodsAddressTextView;
}

- (NSArray *)listTitleArr
{
    if (!_listTitleArr)
    {
        _listTitleArr = @[@"商品", @"数量", @"单价"];
    }
    return _listTitleArr;
}

#pragma mark---network

- (void)requestHomeData
{
    HCAddressApi *api = [[HCAddressApi alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCAddressInfo *info)
     {
         if (requestStatus == HCRequestStatusSuccess)
         {
             _info = info;
             [self.tableView reloadData];
         }else
         {
             [self showHUDError:message];
         }
     }];
}

@end

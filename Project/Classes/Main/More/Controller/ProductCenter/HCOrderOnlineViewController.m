//
//  HCOrderOnlineViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCOrderOnlineViewController.h"
#import "KWFormViewQuickBuilder.h"
#import "HCTagUserInfo.h"

#import "HCGoodsListTableViewCell.h"
#import "HCPayWayTableViewCell.h"

@interface HCOrderOnlineViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UIView* beSureToPayView;
@property (nonatomic,strong) UIView* useNewAddressView;
@property (nonatomic,strong) UIView* headerView;
@property (nonatomic,strong) UILabel* headerViewLable;

@property (nonatomic,strong) UITextView *acceptGoodsAddressTextView;

@property (nonatomic,assign) CGFloat labelHeight;
//商品清单表头
@property (nonatomic,strong) NSArray* listTitleArr;

@end

@implementation HCOrderOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"在线订购";
    [self setupBackItem];
}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        if (indexPath.section == 0)
        {
            UITableViewCell* Tcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"acceptGoodsAddress"];
            
                [Tcell.contentView addSubview:self.acceptGoodsAddressTextView];
            cell = Tcell;
            
        }else if (indexPath.section == 1)
        {
            HCGoodsListTableViewCell *goodsListcell = [[HCGoodsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsList"];
            cell = goodsListcell;
        }else
        {
        HCPayWayTableViewCell* Tcell = [[HCPayWayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsList111"];
            
        cell = Tcell;
            
            
        
    }
    }
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return 1;
    }
    else
    {
        return 4;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.beSureToPayView;
    }else if(section == 0)
    {
        return self.useNewAddressView;
    }else
    {
        return nil;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _headerViewLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH(self.view)-10, 200)];
    if (section == 0)
    {
        self.headerViewLable.text = @"1.选择收货地址";

    }else if (section == 1)
    {
        self.headerViewLable.attributedText =  [self changeStringColorAndFontWithStart:@"2.商品清单" smallString:@"(预印板预计三天内送达，定制版十五天后发货)" end:@""];
    }else
    {
       self.headerViewLable.text = @"3.选择支付方式";
    }
    _headerViewLable.numberOfLines = 0;
    _headerViewLable.font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(WIDTH(self.view)-20,2000);
    CGSize labelsize = [_headerViewLable.text sizeWithFont:_headerViewLable.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    [_headerViewLable setFrame:CGRectMake(10,0, labelsize.width, labelsize.height)];
    _labelHeight = labelsize.height + 10;
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), _labelHeight)];
    
    [self.headerView addSubview:self.headerViewLable];
    
    return self.headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 120;
    }else if(indexPath.section  == 1)
    {
        return 240;
    }
    else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ( section == 0 )
    {
        return 44;
    }if (section == 2)
    {
        return 64;
    }else
    {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MAX(44, _labelHeight);
}

#pragma mark - private methods

-(void)handleBeSureToPay
{
    [self showHUDText:@"支付完成"];
}

-(void)handleUseNewAddress
{
    [self showHUDText:@"使用新地址"];
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

-(UIView *)useNewAddressView
{
    if (!_useNewAddressView)
    {
        _useNewAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 44)];
        UIButton *useNewAddressbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        useNewAddressbtn.frame = CGRectMake(20, 5, WIDTH(self.view)/2+20,30);
        [useNewAddressbtn setTitle:@"使用新地址" forState:UIControlStateNormal];
        [useNewAddressbtn addTarget:self action:@selector(handleUseNewAddress) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(useNewAddressbtn, 4);
        useNewAddressbtn.backgroundColor = [UIColor redColor];
        [_useNewAddressView addSubview:useNewAddressbtn];
    }
    return _useNewAddressView;
}

-(UIView *)beSureToPayView
{
    if(!_beSureToPayView)
    {
        _beSureToPayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 64)];
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(20, HEIGHT(_beSureToPayView)-40, WIDTH(self.view)-40, 45);
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [completeBtn addTarget:self action:@selector(handleBeSureToPay) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(completeBtn, 4);
        completeBtn.backgroundColor = RGB(253, 89, 83);
        [_beSureToPayView addSubview:completeBtn];
    }
    return _beSureToPayView;

}

-(UITextView*)acceptGoodsAddressTextView
{
    if (!_acceptGoodsAddressTextView)
    {
        _acceptGoodsAddressTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, WIDTH(self.view)-50, 100) ];
        _acceptGoodsAddressTextView.font = [UIFont systemFontOfSize:16];
        _acceptGoodsAddressTextView.delegate = self;
        _acceptGoodsAddressTextView.backgroundColor = [UIColor clearColor];
        ViewBorderRadius(_acceptGoodsAddressTextView,0, 1, [UIColor lightGrayColor]);
        _acceptGoodsAddressTextView.scrollEnabled = NO;
        _acceptGoodsAddressTextView.text =@"   Tim\n 上海市闵行区解放路168号5号楼507 \n 15847841241";
        _acceptGoodsAddressTextView.editable = NO;
    }
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
@end

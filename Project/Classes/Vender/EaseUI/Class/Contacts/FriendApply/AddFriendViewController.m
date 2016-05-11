/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "AddFriendViewController.h"

#import "ApplyViewController.h"
#import "AddFriendCell.h"
#import "InvitationManager.h"
#import "HCMessagePersonInfoVC.h"
#import "lhScanQCodeViewController.h"
#import "HCAddFriendlistTableViewCell.h"

#import "HCMailListViewController.h"
//
#import "NHCMessageSearchUserApi.h"
@interface AddFriendViewController ()<UITextFieldDelegate, UIAlertViewDelegate,UIGestureRecognizerDelegate,HCAddFriendlistTableViewCellDelegate>
{
    NSMutableArray *btnArr;
}
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITextField *textField;
@property (nonatomic,strong) UIButton *scanButton;
@property (nonatomic,strong) UIView *blueView;

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, copy) NSString *tableViewReuseIdentifier;

@end

@implementation AddFriendViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

-(UIButton *)scanButton
{
    if (!_scanButton)
    {
        _scanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_scanButton setBackgroundImage:IMG(@"ThinkChange_sel") forState:UIControlStateNormal];
        [_scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_scanButton addTarget:self action:@selector(clickScan) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.title = NSLocalizedString(@"friend.add", @"Add friend");
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    self.tableView.tableFooterView = footerView;

    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.scanButton]];
    HCBarButtonItem *backItem = [[HCBarButtonItem alloc] initWithBackTarget:self.navigationController action:@selector(popViewControllerAnimated:)];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self.view addSubview:self.textField];
    
    [self setKeyBoardDismiss];
}

-(NSMutableArray *)models
{
    if (!_models)
    {
        _models = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    }
    return _models;
}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 55)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"删除" forState:UIControlStateNormal];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 55)];
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"收藏" forState:UIControlStateNormal];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 55)];
    btn3.backgroundColor = [UIColor greenColor];
    [btn3 setTitle:@"举报" forState:UIControlStateNormal];
    btnArr = [[NSMutableArray alloc]initWithObjects:btn1,btn2,btn3, nil];
    
    static NSString *cellIdentifier = @"Cell";
    HCAddFriendlistTableViewCell *cell = (HCAddFriendlistTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[HCAddFriendlistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"Cell"
                                                  withBtns:btnArr
                                                 tableView:self.tableView];
        cell.delegate = self;
    }
        cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selected = [tableView indexPathForSelectedRow];
    if(selected)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark SCSwipeTableViewCellDelegate

- (void)SCSwipeTableViewCelldidSelectBtnWithTag:(NSInteger)tag andIndexPath:(NSIndexPath *)indexpath{

    NSString *btnName ;
    switch ((long)tag)
    {
        case 0:
            btnName = @"删除";
            break;
            
        case 1:
            btnName = @"收藏";
            break;
        
        case 2:
            btnName = @"举报";
            break;
            
        default:
            break;
    }
    NSString *message = [NSString stringWithFormat:@"你选择了 在 %ld 分区 %ld行 %@ 按钮",(long)indexpath.section,(long)indexpath.row ,btnName];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"tips"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"ok"
                                         otherButtonTitles:nil, nil];
    [alert show];
}

- (void)cellOptionBtnWillShow{
    NSLog(@"cellOptionBtnWillShow");
}

- (void)cellOptionBtnWillHide{
    NSLog(@"cellOptionBtnWillHide");
}

- (void)cellOptionBtnDidShow{
    NSLog(@"cellOptionBtnDidShow");
}

- (void)cellOptionBtnDidHide{
    NSLog(@"cellOptionBtnDidHide");
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark--HCAddFriendlistTableViewCellDelegate

-(void)cliclAgreeBtn
{
    NSLog(@"点击了同意");
}

#pragma mark---private Method

-(void)setKeyBoardDismiss
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [_textField resignFirstResponder];
}

-(void)click:(UIButton*)button
{
    if (button.tag == 0 )
    {
        HCMailListViewController *mailVC = [[HCMailListViewController alloc]init];
        [self.navigationController pushViewController:mailVC animated:YES];
    }
    else
    {
        [_models removeAllObjects];
        [self.tableView reloadData];
    }
}
//搜索添加的好友
- (void)searchAction
{
    [_textField resignFirstResponder];
    if(_textField.text.length > 0)
    {
#warning 由用户体系的用户，需要添加方法在已有的用户体系中查询符合填写内容的用户
#warning 以下代码为测试代码，默认用户体系中有一个符合要求的同名用户
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        if ([_textField.text isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notAddSelf", @"can't add yourself as a friend") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        //判断是否已发来申请
        NSArray *applyArray = [[ApplyViewController shareController] dataSource];
        if (applyArray && [applyArray count] > 0)
        {
            for (ApplyEntity *entity in applyArray)
            {
                ApplyStyle style = [entity.style intValue];
                BOOL isGroup = style == ApplyStyleFriend ? NO : YES;
                if (!isGroup && [entity.applicantUsername isEqualToString:_textField.text])
                {
                    NSString *str = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatInvite", @"%@ have sent the application to you"), _textField.text];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:str delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                    return;
                }
            }
        }
        
        NSMutableArray *mutableArr = [NSMutableArray array];
        [mutableArr addObject:_textField.text];
        //联系人的信息界面
        HCMessagePersonInfoVC *MessagePVC = [[HCMessagePersonInfoVC alloc]init];
        NHCMessageSearchUserApi *api = [[NHCMessageSearchUserApi alloc]init];
        api.UserChatID = _textField.text;
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *model) {
          if (requestStatus==100){
                HCMessagePersonInfoVC *vc = [[HCMessagePersonInfoVC alloc]init];
                NSMutableArray *arr = [NSMutableArray array];
                [arr addObject:model];
                vc.dataSource  = arr;
                vc.ChatId = model.NickName;
                vc.ScanCode = YES;
                vc.userInfo = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
       // MessagePVC.dataSource = mutableArr;
        //网络请求
        [self.navigationController pushViewController:MessagePVC animated:YES];
    }
}
//扫描
-(void)clickScan
{
    lhScanQCodeViewController *lhScanVC = [[lhScanQCodeViewController alloc]init];
    lhScanVC.hidesBottomBarWhenPushed = YES;
    lhScanVC.isAddFr = YES;
    [self.navigationController pushViewController:lhScanVC animated:YES];
}

#pragma mark - getter

- (UITextField *)textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.backgroundColor =RGB(240, 70, 110);
        _textField.placeholder = NSLocalizedString(@"输入好友ID号/手机号/昵称",@"input to find friends");//@"friend.inputNameToSearch", @"input to find friends"
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame = CGRectMake(WIDTH(_textField)-40, 0, 40, 40);
        [searchBtn setBackgroundImage:OrigIMG(@"more") forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        _textField.rightView=searchBtn;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        
    }
    
    return _textField;
}

-(UIView *)blueView
{
    if (!_blueView)
    {
        _blueView = [[UIView alloc]initWithFrame:CGRectMake(10, 60, WIDTH(self.view)-20, 80)];
        _blueView.backgroundColor = [UIColor blueColor];
        
        NSArray *textArr = @[@"添加通讯录好友",@"清空好友申请"];
        NSArray *imgArr = @[@"time",@"more"];
        for (int i = 0; i < 2; i ++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.frame = CGRectMake((WIDTH(self.view)/2-10)*i, 0,WIDTH(self.view)/2-10 , HEIGHT(self.view));
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_blueView addSubview:btn];
            
            NSString *imgStr = imgArr[i];
            NSString *textStr = textArr[i];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH(btn)/2-20, 10, 40, 40)];
            img.image = IMG(imgStr);
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, WIDTH(btn), 30)];
            label.text = textStr;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            
            [btn addSubview:img];
            [btn addSubview:label];
        }
    }
    return _blueView;
}

- (UIView *)headerView
{
    if (_headerView == nil)
    {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
        _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        [_headerView addSubview:_textField];
        [_headerView addSubview:self.blueView];
    }
    return _headerView;
}

@end

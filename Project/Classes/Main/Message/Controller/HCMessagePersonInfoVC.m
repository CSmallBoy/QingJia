//
//  HCMessagePersonInfoVC.m
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMessagePersonInfoVC.h"
#import "AddFriendCell.h"
#import "InvitationManager.h"
#import "HCAddFriendTableViewCell.h"
//获取个人信息
#import "NHCMessageSearchUserApi.h"
@interface HCMessagePersonInfoVC ()
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@end

@implementation HCMessagePersonInfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人信息";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddFriendCell";
    HCAddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[HCAddFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.nameStr = self.dataSource[0];
//        cell.indexPath = indexPath;
        cell.nameStr = _userInfo.NickName;
        cell.ImageName = _userInfo.userHeadPhoto;
        cell.adress = _userInfo.HomeAddress;
        cell.sign = _userInfo.UserDescription;
        
        cell.indexPath = indexPath;
    
        
    }
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0) ? 80 : 40 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 0) ? 10 : 80;
}
//确认添加按钮
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"确认添加" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.frame = CGRectMake(20, 40, WIDTH(self.view)-40, 40);
    ViewRadius(button, 3);
    [button addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 80)];
    footerView.backgroundColor = CLEARCOLOR;
    [footerView addSubview:button];
    return (section == 0) ? nil : footerView;
}

#pragma mark---private methods
//确认添加
-(void)clickAdd
{
    NSString *buddyName;
    if(_ScanCode){
        buddyName = _userInfo.chatName;
    }else{
         buddyName = self.dataSource[0];
    }
   
    if ([self didBuddyExist:buddyName])
    {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeat", @"'%@'has been your friend!"), buddyName];

        [EMAlertView showAlertWithTitle:message
                                message:nil
                        completionBlock:nil
                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                      otherButtonTitles:nil];

    }
    else if([self hasSendBuddyRequest:buddyName])
    {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatApply", @"you have send fridend request to '%@'!"), buddyName];
        [EMAlertView showAlertWithTitle:message
                                message:nil
                        completionBlock:nil
                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                      otherButtonTitles:nil];
        
    }else{
        [self showMessageAlertView];
    }
}

- (BOOL)hasSendBuddyRequest:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList)
    {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState == eEMBuddyFollowState_NotFollowed &&
            buddy.isPendingApproval)
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList)
    {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState != eEMBuddyFollowState_NotFollowed)
        {
            return YES;
        }
    }
    return NO;
}

- (void)showMessageAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:NSLocalizedString(@"saySomething", @"say somthing")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                                          otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView cancelButtonIndex] != buttonIndex)
    {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *username = [loginInfo objectForKey:kSDKUsername];
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@：%@", username, messageTextField.text];
        }
        else{
            messageStr = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyInvite", @"%@ invite you as a friend"), username];
        }
        [self sendFriendApplyAtIndexPath:self.selectedIndexPath
                                 message:messageStr];
    }
}
//发送请求
- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath
                           message:(NSString *)message
{
    NSString *buddyName = [self.dataSource objectAtIndex:indexPath.row];
    if (buddyName && buddyName.length > 0)
    {
        //[self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
        __block EMError *error;
        //这个地方把手机号转成  chatUserName
        
        
        if (_ScanCode){
            //发送请求
             [[EaseMob sharedInstance].chatManager addBuddy:_userInfo.chatName message:message error:&error];
            if (error)
            {
                [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
            }
            else
            {
                [self showHint:NSLocalizedString(@"添加信息已发送", @"send successfully")];
            }
        }else{
            NHCMessageSearchUserApi *api = [[NHCMessageSearchUserApi alloc]init];
            api.UserChatID = buddyName;
            [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *model) {
                [[EaseMob sharedInstance].chatManager addBuddy:model.chatName message:message error:&error];
                //[self hideHud];
                if (error)
                {
                    [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
                }
                else
                {
                    [self showHint:NSLocalizedString(@"添加信息已发送", @"send successfully")];
                }
            }];
//            [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chatUserName) {
//                [[EaseMob sharedInstance].chatManager addBuddy:chatUserName message:message error:&error];
//                [self hideHud];
//                if (error)
//                {
//                    [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
//                }
//                else
//                {
//                    [self showHint:NSLocalizedString(@"添加信息已发送", @"send successfully")];
//                }
//            }];
        }
      
    
    }
}

@end

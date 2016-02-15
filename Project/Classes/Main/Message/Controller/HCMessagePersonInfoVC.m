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
        cell.nameStr = self.dataSource[0];
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

-(void)clickAdd
{
    NSString *buddyName = self.dataSource[0];
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

- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath
                           message:(NSString *)message
{
    NSString *buddyName = [self.dataSource objectAtIndex:indexPath.row];
    if (buddyName && buddyName.length > 0)
    {
        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        [self hideHud];
        if (error)
        {
            [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
        }
        else
        {
            [self showHint:NSLocalizedString(@"添加信息已发送", @"send successfully")];
        }
    }
}

@end

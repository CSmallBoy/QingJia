//
//  HCReadNotificationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCOtherNotificationViewController.h"
#import "HCNotificationDetailViewController.h"
#import "HCButtonItem.h"

#import "SCSwipeTableViewCell.h"

#import "HCMyNotificationCenterTableViewCell.h"

#import "HCNotificationCenterApi.h"
#import "HCNotificationCenterInfo.h"
#import "HCNotificationDeleteApi.h"

@interface HCOtherNotificationViewController ()<UISearchBarDelegate,SCSwipeTableViewCellDelegate>
{
    NSMutableArray *btnArr;
}
@property (nonatomic,strong) NSMutableArray * results;

@property(nonatomic,strong)UISearchBar      *seatchBar;
@property (nonatomic,strong)UITableView     *resultTableView;
@property (nonatomic,strong)UIView          *resultView;
@end

@implementation HCOtherNotificationViewController
#define readNotificationID @"readNotificationID"

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(30);
    self.tableView.tableHeaderView.backgroundColor = [UIColor yellowColor];
    [self.tableView.tableHeaderView addSubview:self.seatchBar];
    [self requestData];


    
}

#pragma mark ---  SCSwipeTableViewCellDelegate

//点击 侧滑出来的button
- (void)SCSwipeTableViewCelldidSelectBtnWithTag:(NSInteger)tag andIndexPath:(NSIndexPath *)indexpath{
//    NSLog(@"you choose the %ldth btn in section %ld row %ld",(long)tag,(long)indexpath.section,(long)indexpath.row);
    NSString *message = [NSString stringWithFormat:@"你选择了第%ld组第%ld行第%ld个按钮",(long)indexpath.section,(long)indexpath.row,(long)tag];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"tips"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"ok"
                                         otherButtonTitles:nil, nil];
    [alert show];
    
    
//    switch (tag) {
//        case 100:
//            [self showHUDText:@"删除成功"];
//            break;
//        case 200:
//            [self showHUDText:@"举报成功"];
//            break;
//        case 300:
//            [self showHUDText:@"收藏成功"];
//            break;
//        default:
//            break;
//    }
//    
    
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


#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
//        HCMyNotificationCenterTableViewCell *cell = [HCMyNotificationCenterTableViewCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.info = self.dataSource[indexPath.row];
//        return cell;
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 55)];
        btn1.backgroundColor = [UIColor redColor];
        [btn1 setBackgroundImage:IMG(@"1.png") forState:UIControlStateNormal];
        btn1.tag = 100;
        [btn1 setTitle:@"删除" forState:UIControlStateNormal];
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 55)];
        btn2.backgroundColor = [UIColor orangeColor];
        btn2.tag = 200;
        [btn2 setTitle:@"举报" forState:UIControlStateNormal];
        
        UIButton  *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 55)];
        btn3.backgroundColor = [UIColor greenColor];
        btn3.tag = 300;
        [btn3 setTitle:@"收藏" forState:UIControlStateNormal];
        
        btnArr = [[NSMutableArray alloc]initWithObjects:btn1,btn2,btn3,nil];

        
        static NSString *cellIdentifier = @"Cellllll";
        SCSwipeTableViewCell *cell = (SCSwipeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[SCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"Celllll"
                                                      withBtns:btnArr
                                                     tableView:self.tableView];
            cell.delegate = self;
        }
        cell.info = self.dataSource[indexPath.row];
        return cell;
    }
    else
    {
        static NSString  *cellID = @"NormalCell";
        UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID  ];
           
        }
        HCNotificationCenterInfo *info = self.results[indexPath.row];
        
        cell.textLabel.text = info.name;
        cell.imageView.image = [UIImage imageNamed:@"label_Head-Portraits"];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}

#pragma mark ---UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return self.dataSource.count;
    }
    else
    {
        return self.results.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{//（编辑方法）只要实现这个代理方法，左滑删除的效果就会出现
//  if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//      
//  }
//}

//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 收藏举报删除
//    NSArray  *titles = @[@"删除",@"举报",@"收藏"];
//    NSMutableArray  *arr = [NSMutableArray array];
//    NSArray  *colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor greenColor]];
//   
//    for (int i = 0; i<3; i++) {
//        
//        
//    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:titles[i] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//       
//        if ([action.title isEqualToString:@"删除"]) {
//            
//            [self.dataSource removeObjectAtIndex:indexPath.row];
//            [self.tableView reloadData];
//        }
//        else if ([action.title isEqualToString:@"收藏"])
//        {
//            [self showHUDSuccess:@"收藏成功"];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您真的要举报么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
//            [alert show];
//        }
//        }];
//
//        action.backgroundColor = colors[i];
//        
//        [arr addObject:action];
//    }
//
//    return arr;
//}


#pragma mark ---UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.seatchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH- 60, 30);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-60, 0, 60, 30);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.backgroundColor = COLOR(189, 189, 183, 1);
    [button addTarget:self action:@selector(canleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView.tableHeaderView addSubview:button];

    [self.view addSubview:self.resultView];
    
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    self.resultTableView.frame= CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-283.5-144);
    
    NSLog(@"%@",searchText);
    if (searchText.length != 0)
    {
        [self.view addSubview:self.resultTableView];
    }
    else
    {
        [self.resultTableView removeFromSuperview];
    }
    [self.results removeAllObjects];
    for ( HCNotificationCenterInfo *info in self.dataSource) {
        NSRange  range = [info.name rangeOfString:searchText];
        if (range.location != NSNotFound) {
            [self.results addObject:info];
            
        }
    }
    [self.resultTableView reloadData];
    
    
}

#pragma mark --- buttonClick
-(void)canleButton:(UIButton  *)button
{
    self.seatchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [self.tableView.tableHeaderView bringSubviewToFront: self.seatchBar];
    self.seatchBar.text = nil;
    [self.resultTableView removeFromSuperview];
    [self.resultView removeFromSuperview];
    [self.seatchBar endEditing:YES];
}

-(void)keyboardWasShown:(NSNotification *)noti
{
    CGRect keyBoardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSLog(@"——————————————%lf",keyBoardFrame.size.height);
    self.resultTableView.frame= CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-keyBoardFrame.size.height-144);
    
}

#pragma mark --- getter Or setter


- (UISearchBar *)seatchBar
{
    if(!_seatchBar){
        _seatchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 30)];
        _seatchBar.placeholder = @"请输入关键词快速搜索";
        _seatchBar.delegate = self;
    }
    return _seatchBar;
}


- (NSMutableArray *)results
{
    if(!_results){
        _results = [[NSMutableArray alloc]init];
    }
    return _results;
}

//
- (UITableView *)resultTableView
{
    if(!_resultTableView){
        _resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-144) style:UITableViewStylePlain];
        _resultTableView.backgroundColor = [UIColor whiteColor];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
    }
    return _resultTableView;
}


- (UIView *)resultView
{
    if(!_resultView){
        _resultView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-144)];
        _resultView.backgroundColor =[UIColor blackColor];
        _resultView.alpha = 0.2;
    }
    return _resultView;
}



#pragma mark - network

//-(void)requestDelete:(NSIndexPath *)indexPath
//{
//    HCNotificationDeleteApi *api = [[HCNotificationDeleteApi alloc]init];
//    api.NoticeId = 1000000004;
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id info) {
//        if (requestStatus == HCRequestStatusSuccess)
//        {
//            
//        }
//    }];
//}


- (void)requestData
{

        for (int i = 0; i<20; i++)
        {
            HCNotificationCenterInfo *info = [[HCNotificationCenterInfo alloc]init];
            info.image = @"0000000";
            info.name  = [NSString stringWithFormat:@"小红 %d",i];
            info.sex = @"女";
            info.age = @"6";
            info.sendTime = @"2015-12-12";
            info.missDesc = @"某年某月某日，我的女儿小红，在人民广场与我走失，6岁，马尾辫，穿着宝红色上衣，白色裤子，她性格腼腆，不害羞内向，希望有心人看见了，能即时与我联系，不胜感激，好人一生平安";
            
            [self.dataSource addObject:info];
        }

//    HCNotificationCenterApi *api = [[HCNotificationCenterApi alloc] init];
//    api.NoticeType = 100;
//    api.theStatus = @"已读";
//    api.Start = 1000;
//    api.Count = 20;
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array)
//    {
//        if (requestStatus == HCRequestStatusSuccess)
//        {
//            [self.dataSource removeAllObjects];
//            [self.dataSource addObjectsFromArray:array];
//            [self.tableView reloadData];
//        }
//        else
//        {
//            [self.dataSource removeAllObjects];
//            [self.dataSource addObjectsFromArray:array];
//            [self.tableView reloadData];
//            [self showHUDError:message];
//        }
//    }];

}
@end

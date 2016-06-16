//
//  HCFamilyUserInfoViewController.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCFamilyUserInfoViewController.h"
#import "HCMemberApi.h"
@interface HCFamilyUserInfoViewController ()
{
    NSMutableDictionary *memberInfo;
    UIImageView *headImage;
}
@end

@implementation HCFamilyUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor redColor];
    memberInfo = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    
    [self addMemberData];
    NSLog(@"%@",_info.nickName);
    
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    view.image = [UIImage imageNamed:@"personinfo_background"];
    UIButton *back_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_button setFrame:CGRectMake(10, 30, 30, 30)];
    [back_button setImage:[UIImage imageNamed:@"barItem-back"] forState:UIControlStateNormal];
    [back_button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back_button];
    
    self.tableView.tableHeaderView = view;
    
    UILabel *title = [[UILabel alloc]init];
    title.frame = CGRectMake(0, 30, SCREEN_WIDTH, 30);
    title.text = @"个人信息";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.center = CGPointMake(SCREEN_WIDTH/2, title.center.y);
    [self.view addSubview:title];
    
    headImage = [[UIImageView alloc]init];
    headImage.frame = CGRectMake(0, 80, WIDTH(self.view)*0.4, WIDTH(self.view)*0.4);
    ViewRadius(headImage, WIDTH(headImage)/2);
    headImage.center = CGPointMake(SCREEN_WIDTH/2, headImage.center.y);
    [self.view addSubview:headImage];
    
    
    // Do any additional setup after loading the view.
}
- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)addMemberData
{
    HCMemberApi *memberApi = [[HCMemberApi alloc]init];
    memberApi.memberId = _memberId;
    [memberApi startRequest:^(HCRequestStatus requestStatus, NSString *message, id response) {
        
        NSLog(@"%@",response);
        memberInfo = [[response objectForKey:@"Data"] objectForKey:@"UserInf"];
        [headImage sd_setImageWithURL:[readUserInfo url:[memberInfo objectForKey:@"imageName"] :kkUser]];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"indetifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *array = [NSArray arrayWithObjects:@"姓名",@"ID",@"签名",@"生日",@"年龄",@"属相",@"时光", nil];
    
    cell.textLabel.text = array[indexPath.row];
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(100, 0, SCREEN_WIDTH, 60);
    [cell.contentView addSubview:label];
    if (memberInfo.count !=0) {
        
        switch (indexPath.row) {
            case 0:
                label.text=[memberInfo objectForKey:@"trueName"];
                break;
            case 1:
                label.text = _memberId;
                break;
            case 2:
                label.text = [memberInfo objectForKey:@"userDescription"];
                break;
            case 3:
                label.text = [memberInfo objectForKey:@"birthDay"];
                break;
            case 4:
                label.text = [memberInfo objectForKey:@"birthDay"];
                break;
            case 5:
                label.text = [memberInfo objectForKey:@"chineseZodiac"];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

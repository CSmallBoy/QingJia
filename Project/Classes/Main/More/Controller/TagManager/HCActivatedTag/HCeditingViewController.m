//
//  HCeditingViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/28.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCeditingViewController.h"
#import "HCUnactivatedTagViewController.h"
#import "HCTagManagerViewController.h"
@interface HCeditingViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL a;//增加删除紧急联系人
    NSArray *_arr_all;
    NSArray *_arr;
    NSArray *_arr2;
    NSArray *_arr3;
    NSArray *_arr4;
    NSArray *tf_arr_all;
    NSArray *tf_arr;
    NSArray *tf_arr2;
    NSArray *tf_arr3;
    NSArray *tf_arr4;
    UILabel *label1;
    
   
}
@property(nonatomic,strong) UITableView *tabview;
@end

@implementation HCeditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr = @[@"头像",@"姓名",@"性别",@"生日",@"住址",@"学校"];
    _arr2 = @[@"姓名",@"关系",@"手机号"];
    _arr3 = @[@"姓名",@"关系",@"手机号"];
    _arr4 = @[@"身高",@"体重",@"血型",@"过敏史",@"医疗状况",@"医疗笔记"];
    _arr_all = @[_arr,_arr2,_arr3,_arr4];
//假数据
    tf_arr = @[@"点击上传使用着的头像",@"点击输入标签使用者的姓名",@"男",@"2012—10-2",@"点击输入标签使用这的居住住址",@"点击输入标签使用的职业"];
    tf_arr2 = @[@"点击输入紧急联系人的姓名",@"输入紧急联系人与标签使用者的关系",@"点击输入紧急联系人的电话"];
    tf_arr3 = @[@"点击输入紧急联系人的姓名",@"输入紧急联系人与标签使用者的关系",@"点击输入紧急联系人的电话"];
    tf_arr4 = @[@"身高",@"体重",@"血型",@"过敏史",@"医疗状况",@"医疗笔记"];
    tf_arr_all = @[tf_arr,tf_arr2,tf_arr3,tf_arr4];
    self.title = @"标签详情编辑";
    [self makeUI];
    a = YES;
    
}

#pragma mark 界面设计
-(void)makeUI
{
    _tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tabview.delegate = self;
    _tabview.dataSource = self;
    UIView *view_foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIButton *button_complete = [UIButton buttonWithType:UIButtonTypeCustom];
    button_complete.frame = CGRectMake(SCREEN_WIDTH*0.2, 10, SCREEN_WIDTH*0.6, 20);
    [button_complete addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [view_foot addSubview:button_complete];
    view_foot.backgroundColor = [UIColor greenColor];
    _tabview.tableFooterView =view_foot;
    [self.view addSubview:_tabview];
}

-(void)complete
{
    HCTagManagerViewController *vc2 = [[HCTagManagerViewController alloc]init];
    [self.navigationController pushViewController:vc2 animated:YES];
}
#pragma mark tabview代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==3)
    {
        return 6;
    }
    else
    {
        if (a==YES&&section==2)
        {
            return 6;
        }
        return 3;
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


#pragma mark 指定删除一个section
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //数据固定  不用复用
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,60, 24)];
    label1.font = [UIFont systemFontOfSize:15];
    [cell addSubview:label1];
    //创建文本框
    UITextField *text_tf = [[UITextField alloc]initWithFrame:CGRectMake(70, 3, SCREEN_WIDTH*0.60, 38)];
    [cell addSubview:text_tf];
    //头像的选择
    if (a&&indexPath.section==2){
        label1.text = _arr_all[3][indexPath.row];
        text_tf.placeholder = tf_arr_all[3][indexPath.row];
    }
    else {
        label1.text = _arr_all[indexPath.section][indexPath.row];
        text_tf.placeholder = tf_arr_all[indexPath.section][indexPath.row];
        
    }
    [text_tf setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [text_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    if(a&&indexPath.section==3){
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
    }
    if(indexPath.section==0&&indexPath.row==0)
    {
        UIButton *header_butt = [UIButton buttonWithType:UIButtonTypeCustom];
        [header_butt setBackgroundImage:[UIImage imageNamed:@"image_hea.jpg"] forState:UIControlStateNormal];
        header_butt.frame = CGRectMake(SCREEN_WIDTH*0.85,3, 38, 38);
        [cell addSubview:header_butt];
    }
    if (indexPath.section==0&&indexPath.row==4) {
        UISwitch * sw_itch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 7, 45, 15)];
        [cell addSubview:sw_itch];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
   
    static NSString*identifier = @"identifier";
    UIView*view =[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 80, 24)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    if (view==nil) {
        view = [[UIView alloc]init];
    }
    switch (section) {
        case 0:
        {
            label.text = @"基本信息";
        }
            break;
        case 1:
        {
             label.text = @"紧急联系人";
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(93, 3, 24, 24);
            [button setBackgroundColor:[UIColor redColor]];
            [view addSubview:button];
            [button addTarget:self action:@selector(AddbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 2:
        {
            if(a){
                label.text = @"医疗急救卡";
                UISwitch * sw_itch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 7, 45, 15)];
                [view addSubview:sw_itch];
            }else{
                label.text = @"紧急联系人";
                UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(93, 3, 24, 24);
                [button setBackgroundColor:[UIColor greenColor]];
                [view addSubview:button];
                [button addTarget:self action:@selector(reducebuttonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
           
        }
            break;
        case 3:
        {
            if(a){
            
            }else{
                label.text = @"医疗急救卡";
                UISwitch * sw_itch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 7, 45, 15)];
                [view addSubview:sw_itch];
            }
            
        }
            break;
     
        default:
            break;
    }
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (a&&section==3) {
        return 0;
    }else{
        return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (a&&indexPath.section==3) {
        return 0;
    }else{
        return 44;
    }
}
//增加紧急联系人
-(void)AddbuttonClick:(UIButton*)button{
    a= NO;
    [_tabview reloadData];
}
//删除紧急联系人
-(void)reducebuttonClick:(UIButton*)button{
    a= YES;
    [_tabview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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

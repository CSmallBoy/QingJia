//
//  HCAddPromiseViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAddPromiseViewController.h"
#import "HCPromisedHeaderIVCell.h"
#import "HCPromisedNormalCell.h"
#import "HCpromisedNormalImageCell.h"
#import "HCPromisedTextViewCell.h"
#import "HCPromisedAddCallMessageAPI.h"

@interface HCAddPromiseViewController ()
{
    BOOL   _isFive;
}
@property(nonatomic,strong)NSMutableArray   *BigTitleArr;  // 标题数组
@property(nonatomic,strong)NSMutableArray   *BigDetailTitleArr; //详情标题数组
@property(nonatomic,strong)NSMutableArray   *BigDetailDetailArr;// 详情 后面数组
@property(nonatomic,strong)UITableView      *DetaileTableview;


@end

@implementation HCAddPromiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一呼百应";
    self.tableView.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self createUI];
    
}



#pragma mark UiTableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger  missIndex = 0;
    NSInteger  HospotilIndex = 0;
    if (_isFive)
    {
        missIndex = 3;
        HospotilIndex = 4;
    }
    else
    {
        missIndex = 2;
        HospotilIndex = 3;
        
    }
    
    if(indexPath.section == 0 && indexPath.row ==0 )
    {
        HCPromisedHeaderIVCell  *cell = [HCPromisedHeaderIVCell CustomCellWithTableView:tableView];
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        
        return cell;
    }else  if   ((indexPath.section == 0 &&(indexPath.row ==3 || indexPath.row ==4)) ||(indexPath.section == missIndex && indexPath.row == 0))
        
    {
        HCpromisedNormalImageCell *cell = [HCpromisedNormalImageCell CustomCellWithTableView:tableView];
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        return cell;
        
    }else  if  ((indexPath.section == missIndex &&(indexPath.row == 1)) ||(indexPath.section == HospotilIndex && indexPath.row == 1))
    
    {
        HCPromisedTextViewCell  *cell = [HCPromisedTextViewCell CustomCellWithTableView:tableView];
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        return cell;
    }
    else  if (indexPath.section == HospotilIndex && indexPath.row == 2)
    {
        static NSString *finishedCellID = @"finishedCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:finishedCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:finishedCellID];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15, 7, SCREEN_WIDTH-30, 30);
            [button setTitle:@"完成" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(FinishedClick) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            ViewRadius(button , 5);
            button.backgroundColor = RGB(222, 35, 46);
            [cell addSubview:button];
        }
        return cell;
        
    }else
    {
        HCPromisedNormalCell  *cell = [HCPromisedNormalCell CustomCellWithTableView:tableView];
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        return cell;
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    }
    else  if  (_isFive)
    {
    
        if (((indexPath.section == 3 &&(indexPath.row == 1)) ||(indexPath.section == 4 && indexPath.row == 1) )) {
            
              return 88;
            
        }
      
    }
    else  if  ((indexPath.section == 2 &&(indexPath.row == 1)) ||(indexPath.section == 3 && indexPath.row == 1))
        
    {
        return 88;
        
    }

    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isFive) {
        return 5;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        label.textColor = [UIColor blackColor];
        label.text = self.BigTitleArr[section];
        [view addSubview:label];
        UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(110, 10, 20, 20);
        [button addTarget:self action:@selector(AddPersonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (section == 1) {
        
            [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_Plus"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_reduce"] forState:UIControlStateNormal];
        }
        view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
        [view addSubview:button];
        return view;
    }
    else  if (section == 2 && _isFive)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        label.textColor = [UIColor blackColor];
        label.text = self.BigTitleArr[section];
        [view addSubview:label];
        UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(110, 10, 20, 20);
        [button addTarget:self action:@selector(MovePersonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (section == 1) {
            
            [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_Plus"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_reduce"] forState:UIControlStateNormal];
        }
        view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
        [view addSubview:button];
        return view;

    }else
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        UILabel  *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 40)];
        lable.text = self.BigTitleArr[section];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
        [view addSubview:lable];
        view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
        return view;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFive)
    {
        switch (section) {
        case 0:
            return  5;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 3;
                break;

        default:
            break;
    }
        
        return 0;}else
    {
        switch (section) {
            case 0:
                return  5;
                break;
            case 1:
                return 3;
                break;
            case 2:
                return 2;
                break;
            case 3:
                return 3;
                break;
            default:
                break;
        }
        
        return 0;
    
    }
    
}

#pragma mark --- private method

-(void)createUI
{
    [self.view addSubview:self.DetaileTableview];
}

//点击了添加紧急联系人
-(void)AddPersonClick :(UIButton *)button
{
    if (_isFive) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能添加两个联系人" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    _isFive = YES;
    
    [self.BigTitleArr insertObject:@"紧急联系人" atIndex:1];
    [self.BigDetailTitleArr insertObject:@[@"姓名",@"关系",@"手机号"] atIndex:1];
    [self.BigDetailDetailArr insertObject:@[@"点击输入紧急联系人真实姓名",@"输入紧急联系人与走失者联系，如父子",@"点击输入紧急联系人的手机号码"] atIndex:1];
    [self.DetaileTableview reloadData];

}
//点击了传出紧急联系人
-(void)MovePersonClick : (UIButton *)button
{
    _isFive = NO;
    
    [self.BigTitleArr removeObjectAtIndex:2];
    [self.BigDetailTitleArr removeObjectAtIndex:2];
    [self.BigDetailDetailArr removeObjectAtIndex:2];
    
    [self.DetaileTableview reloadData];
  
}
//点击了完成
-(void)FinishedClick
{
//    [self updateData];
}


#pragma mark ---Setter  Or Getter

-(NSMutableArray *)BigDetailTitleArr
{
    if (!_BigDetailTitleArr)
    {
         _BigDetailTitleArr = [NSMutableArray array];
        //基本信息
        NSArray   *arrJiben = @[@"姓名",@"性别",@"年龄",@"住址",@"学校"];
        [_BigDetailTitleArr addObject:arrJiben];
        // 紧急联系人1
        NSArray   *arrLianxi = @[@"姓名",@"关系",@"手机号"];
        [_BigDetailTitleArr addObject:arrLianxi];
        // 走失信息
        NSArray  *arrZoushi = @[@"地点",@"描述"];
        [_BigDetailTitleArr addObject:arrZoushi];
        // 医疗救助信息
        NSArray  *arrYiLiao =  @[@"血型",@"过敏史",@""];
        [_BigDetailTitleArr addObject:arrYiLiao];
       
    }
    return _BigDetailTitleArr;
}
// 组头标题
-(NSMutableArray *)BigTitleArr
{
    if (!_BigTitleArr)
    {
        NSArray   *arrTitile = @[@"基本信息",@"紧急联系人",@"走失信息",@"医疗救助信息"];
        _BigTitleArr = [NSMutableArray arrayWithArray:arrTitile];
    }
    return _BigTitleArr;
}

-(NSMutableArray *)BigDetailDetailArr
{
    if (!_BigDetailDetailArr)
    {
        _BigDetailDetailArr = [NSMutableArray array];
        // 基本信息的detail数组
        
        NSArray  *arrJiibenDetail = @[@"点击输入走失者真实姓名",@"X",@"XXXX-XX-XX",@"点击输入走失者的",@"点击输入走失者学校名称"];
        [_BigDetailDetailArr addObject:arrJiibenDetail];
        // 紧急联系人 detail 数组
        NSArray  *arrJinjiDetail = @[@"点击输入紧急联系人真实姓名",@"输入紧急联系人与走失者联系，如父子",@"点击输入紧急联系人的手机号码"];
        [_BigDetailDetailArr addObject:arrJinjiDetail];
        // 走失信息 detaile数组
        NSArray *arrZoushiDetail = @[@"点击输入走失地点",@"点击输入走失时的一些特点，比如：相貌特征，身高，所传衣物"];
        [_BigDetailDetailArr addObject:arrZoushiDetail];
        // 医疗救助detail 数组
        NSArray  *arrYiLiaoDetail = @[@"点击输入走失者的血型",@"如果走时者有药物过敏历史,点击输入过敏药物名称",@""];
        [_BigDetailDetailArr addObject:arrYiLiaoDetail];
    }

    return _BigDetailDetailArr;
}

-(UITableView *)DetaileTableview
{
    if (!_DetaileTableview) {
        
        CGRect  frame = CGRectMake(0, 64,SCREEN_WIDTH , SCREEN_HEIGHT-64);
        _DetaileTableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _DetaileTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _DetaileTableview.delegate = self;
        _DetaileTableview.dataSource = self;
    }
    return _DetaileTableview;
}

#pragma mark --- network

-(void)updateData
{
    HCPromisedAddCallMessageAPI  *api = [[HCPromisedAddCallMessageAPI alloc]init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            NSLog(@"%@",responseObject);
        }
        
    }];
}




- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
     [self setupBackItem];
    
}


@end

//
//  HCAddPromiseViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAddPromiseViewController.h"
#import "HCPromisedHeaderIVCell.h"

@interface HCAddPromiseViewController ()

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
    [self createData];
    [self createUI];
    
}

#pragma mark  搭建UI界面
-(void)createUI
{

    [self.view addSubview:self.DetaileTableview];
    
    

}

#pragma mark  创建数据
-(void)createData
{
// 组头标题
    NSArray   *arrTitile = @[@"基本信息",@"紧急联系人",@"紧急联系人",@"走失信息",@"医疗救助信息"];
    self.BigTitleArr = [NSMutableArray arrayWithArray:arrTitile];
//基本信息
    NSArray   *arrJiben = @[@"姓名",@"性别",@"年龄",@"住址",@"学校"];
    [self.BigDetailTitleArr addObject:arrJiben];
// 紧急联系人1  紧急联系人2
    NSArray   *arrLianxi = @[@"姓名",@"关系",@"手机号"];
    [self.BigDetailTitleArr addObject:arrLianxi];
    [self.BigDetailTitleArr addObject:arrLianxi];
// 走失信息
    NSArray  *arrZoushi = @[@"地点",@"描述"];
    [self.BigDetailTitleArr addObject:arrZoushi];
// 医疗救助信息
    NSArray  *arrYiLiao =  @[@"血型",@"过敏史"];
    [self.BigDetailTitleArr addObject:arrYiLiao];
    
// 基本信息的detail数组
    
    NSArray  *arrJiibenDetail = @[@"点击输入走失者真实姓名",@"X",@"XXXX-XX-XX",@"点击输入走失者的",@"点击输入走失者学校名称"];
    [self.BigDetailDetailArr addObject:arrJiibenDetail];
// 紧急联系人 detail 数组
    NSArray  *arrJinjiDetail = @[@"点击输入紧急联系人真实姓名",@"输入紧急联系人与走失者联系，如L父子",@"点击输入紧急联系人的手机号码"];
    [self.BigDetailDetailArr addObject:arrJinjiDetail];
    [self.BigDetailDetailArr addObject:arrJinjiDetail];
// 走失信息 detaile数组
    NSArray *arrZoushiDetail = @[@"点击输入走失地点",@"点击输入走失时的一些特点，比如：相貌特征，身高，所传衣物"];
    [self.BigDetailDetailArr addObject:arrZoushiDetail];
// 医疗救助detail 数组
    NSArray  *arrYiLiaoDetail = @[@"点击输入走失者的血型",@"如果走时者有药物过敏历史,点击输入过敏药物名称",@""];
    [self.BigDetailDetailArr addObject:arrYiLiaoDetail];
    
    


}



#pragma mark tableView 的代理方法
#pragma mark 返回每一个cell;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0 && indexPath.row ==0 )
    {
    
        HCPromisedHeaderIVCell  *cell = [HCPromisedHeaderIVCell CustomCellWithTableView:tableView];
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        
        return cell;
    
    }else
        
    {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
            
            cell.textLabel.text = @"测试";
        }
    
         return cell;
    }

   

}

#pragma mark 返回每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    }

    return 44;
}


#pragma mark 返回多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    
    return 5;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}



#pragma mark 返回组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1||section == 2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        label.textColor = [UIColor blackColor];
        label.text = self.BigTitleArr[section];
        [view addSubview:label];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 10, 20, 20)];
        
        if (section == 1) {
            imageView.image = [UIImage imageNamed:@"yihubaiying_but_Plus"];
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"yihubaiying_but_reduce"];
        
        }
        view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
        [view addSubview:imageView];
        return view;
    }
    else
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


#pragma mark 每一组返回多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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

    return 0;
}


#pragma mark 懒加载  
-(NSMutableArray *)BigDetailTitleArr
{
    if (!_BigDetailTitleArr) {
        _BigDetailTitleArr = [NSMutableArray array];
    }

    
    return _BigDetailTitleArr;
}



-(NSMutableArray *)BigTitleArr
{
    if (!_BigTitleArr) {
        _BigTitleArr = [NSMutableArray array];
    }
    
    return _BigTitleArr;
}

-(NSMutableArray *)BigDetailDetailArr
{

    if (!_BigDetailDetailArr) {
        _BigDetailDetailArr = [NSMutableArray array];
    }

    return _BigDetailDetailArr;
}


-(UITableView *)DetaileTableview
{

    if (!_DetaileTableview) {
        
        CGRect  frame = CGRectMake(0, 64,SCREEN_WIDTH , SCREEN_HEIGHT-64);
        _DetaileTableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _DetaileTableview.delegate = self;
        _DetaileTableview.dataSource = self;
    }
    
    return _DetaileTableview;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     [self setupBackItem];
    
   
}


@end

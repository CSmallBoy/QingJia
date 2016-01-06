//
//  HCPromisedViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPromisedViewController.h"
#import "HCPromisedAddCell.h"
#import "HCAddPromiseViewController.h"


@interface HCPromisedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView     *smallTableView;
@property(nonatomic,strong)NSMutableArray  *dataArr;
@property(nonatomic,strong)UIImageView     *bgImage;

@end

@implementation HCPromisedViewController


-(void)viewWillAppear:(BOOL)animated
{
    [ super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArr.count-1 inSection:0];
    [self.smallTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"一呼百应";
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    [self setupBackItem];
    
    [self createData];
    [self createUI];
    

    
    [self  createTableView];
}

#pragma mark  懒加载

-(NSMutableArray *)dataArr
{

    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }

    return _dataArr;
}



-(UITableView *)smallTableView
{


    if (!_smallTableView) {
        
        CGFloat  StabX = self.bgImage.frame.size.width-40;
        CGFloat  StabH = self.bgImage.frame.size.height -  80;
        _smallTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 50, StabX, StabH) style:UITableViewStylePlain];
        _smallTableView.delegate = self;
        _smallTableView.dataSource = self;
        
    }
    return _smallTableView;
    

}


#pragma mark 创建数据
-(void)createData
{

    for (int i = 0; i<4; i++) {
        
        NSString  *str = [NSString stringWithFormat:@"Tom %d",i];
        
        [self.dataArr addObject:str];
    }
    
    [self.dataArr addObject:@"+ 新增录入"];
    
}


#pragma mark 创建界面
-(void)createUI
{
   //背景图片  距离边界个45
    
    _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH-90 ,SCREEN_HEIGHT-300)];
    _bgImage.userInteractionEnabled = YES;
    _bgImage.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+25);
    _bgImage.image = [UIImage imageNamed:@"yihubaiying_Background.png"];
    [self.view addSubview:_bgImage];

    //顶部图片
    CGFloat  headerViewW = _bgImage.frame.size.width/3;
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headerViewW , headerViewW)];
    CGFloat  headerViewY = _bgImage.frame.origin.y-15;
    headerView.center = CGPointMake(SCREEN_WIDTH/2, headerViewY);
    headerView.image = [UIImage imageNamed:@"yihubaiying_icon_m-talk logo_dis.png"];
    [self.view addSubview:headerView];
    
    // 两个图片
    UIImageView  *leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, -15, 30, 30)];
    leftIV.image = [UIImage imageNamed:@"yihubaiying_nail.png"];
    [_bgImage addSubview:leftIV];
    
    CGFloat  rightIVX = _bgImage.frame.size.width - 10-30;
    UIImageView   *rightIV = [[UIImageView alloc]initWithFrame:CGRectMake(rightIVX, -15, 30, 30)];
    rightIV.image = [UIImage imageNamed:@"yihubaiying_nail.png"];
    [_bgImage addSubview:rightIV];

}


-(void)createTableView
{
   
    self.tableView.hidden = YES;
    self.smallTableView.backgroundColor = [UIColor clearColor];
    self.smallTableView.rowHeight = 50;
    self.smallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    [_bgImage addSubview:self.smallTableView];
    

}


-(UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HCPromisedAddCell  *cell = [HCPromisedAddCell customCellWithTable:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.title = self.dataArr[indexPath.row];
    
    
    
    cell.block = ^(NSString  *buttonTitle){
    
        if ([buttonTitle isEqualToString:@"+ 新增录入"]) {  //跳转到添加界面
            
            HCAddPromiseViewController *addVC = [[HCAddPromiseViewController alloc]init];
            [self.navigationController pushViewController:addVC animated:YES];
            
        }
        else
        {
            //跳转到信息界面
        
            
        }
       
    
       
        
    
    };
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;

}

@end

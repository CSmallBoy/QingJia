//
//  HCaddRelativeViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCaddRelativeViewController.h"
//亲戚详情页面
#import "HCRelativeDetailViewController.h"

@interface HCaddRelativeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (nonatomic,strong)UITableView *tabView;
@property (nonatomic,strong)NSMutableArray *arr;
@end

@implementation HCaddRelativeViewController
-(void)viewDidAppear:(BOOL)animated{
    [_tabView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加亲戚";
    
    [self makeUI];
    NSArray *Arr = @[@"儿子",@"女儿",@"兄弟",@"姐妹"];
    _arr = [NSMutableArray arrayWithArray:Arr];
    // Do any additional setup after loading the view.
}
- (void)makeUI{
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [self.view addSubview:_tabView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier =@"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //清除复用重影现象
    for (UILabel *label2 in cell.subviews) {
        [label2 removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, SCREEN_WIDTH/2, 38)];
    if (indexPath.row+1>_arr.count) {
        label.text = @"添加另一个合伙人";
    }else{
        label.text = _arr[indexPath.row];
    }
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell addSubview:label];
    return cell;
}
//选择哪一行就 从哪一行传参数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row+1 > _arr.count) {
        NSLog(@"添加另一个合伙人");
    }else{
        HCRelativeDetailViewController *Vc = [[HCRelativeDetailViewController alloc]init];
        Vc.title_name = _arr[indexPath.row];
        [self.navigationController pushViewController:Vc animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

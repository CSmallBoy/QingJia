//
//  HCPeopleRelationViewController.m
//  钦家
//
//  Created by Tony on 16/5/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPeopleRelationViewController.h"

@interface HCPeopleRelationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataSource;//数据源
@property (nonatomic, strong)UIView *alertBackground;//自定义提示框的背景
@property (nonatomic, strong)UIView *customAlertView;//自定义提示框
@property (nonatomic, strong)UITextField *textField;//提示框中的输入框

@end

@implementation HCPeopleRelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关系选择";
    [self.view addSubview:self.tableView];
}

#pragma mark - lazyLoading

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = @[@"母亲",@"父亲",@"兄弟",@"姐妹",@"子女",@"配偶",@"伴侣",@"老师",@"其他"];
    }
    return _dataSource;
}

- (UIView *)alertBackground
{
    if (_alertBackground == nil)
    {
        _alertBackground = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _alertBackground.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_alertBackground addSubview:self.customAlertView];
    }
    return _alertBackground;
}


- (UIView *)customAlertView
{
    if (_customAlertView == nil)
    {
        _customAlertView = [[UIView alloc] initWithFrame:CGRectMake(35/375.0*SCREEN_WIDTH, 230/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-70/375.0*SCREEN_WIDTH, 180/668.0*SCREEN_HEIGHT)];
        ViewRadius(_customAlertView, 5);
        _customAlertView.backgroundColor = [UIColor whiteColor];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20/668.0*SCREEN_HEIGHT, WIDTH(_customAlertView), 20/668.0*SCREEN_HEIGHT)];
        titleLabel.text = @"自定义关系";
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont systemFontOfSize:19];
        [_customAlertView addSubview:titleLabel];
        
        //输入框
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, MaxY(titleLabel)+40/668.0*SCREEN_HEIGHT, WIDTH(_customAlertView)-120/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        _textField.placeholder = @"请输入人物关系";
        _textField.textAlignment = 1;
        [_customAlertView addSubview:_textField];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, MaxY(_textField)+1, WIDTH(_customAlertView)-120/375.0*SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_customAlertView addSubview:line];
        
        //取消
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(30/375.0*SCREEN_WIDTH, MaxY(line)+30/668.0*SCREEN_HEIGHT, 120/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customAlertView addSubview:cancelButton];
        
        //确认
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(MaxX(cancelButton)+15/375.0*SCREEN_WIDTH, MaxY(line)+30/668.0*SCREEN_HEIGHT, 120/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
        sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customAlertView addSubview:sureButton];
    }
    return _customAlertView;
}


#pragma mark - tableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    if ([cell.textLabel.text isEqualToString:@"其他"])
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.dataSource[indexPath.row];
    if ([string isEqualToString:@"其他"])
    {
        [self.navigationController.view addSubview:self.alertBackground];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRelation:)])
        {
            [self.delegate selectedRelation:string];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - buttonClick
//确定
- (void)sureButtonAction:(UIButton *)sender
{
    if (_textField.text.length > 0)
    {
        [self.alertBackground removeFromSuperview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRelation:)])
        {
            [self.delegate selectedRelation:_textField.text];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入人物关系" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
        [alertView show];
    }
}

//取消
- (void)cancleButtonAction:(UIButton *)sender
{
    [self.alertBackground removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

//
//  HCCheckViewController.m
//  Project
//
//  Created by 陈福杰 on 16/2/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCheckViewController.h"
#import "HCCheckTableViewCell.h"
#import "HCCheckInfo.h"

#define kCheckCellId @"checkcellid"

@interface HCCheckViewController ()<HCCheckTableViewCellDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *customAlertView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *agreeBtn;

@end

@implementation HCCheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"加入家庭审核";
    [self setupBackItem];
    [self reqeustCheckData];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.tableView registerClass:[HCCheckTableViewCell class] forCellReuseIdentifier:kCheckCellId];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCheckCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.info = self.dataSource[indexPath.row];
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - HCCheckTableViewCellDelegate

- (void)HCCheckTableViewCellSelectedModel:(HCCheckInfo *)info
{
    [self.view addSubview:self.contentView];
}

#pragma mark - private methods

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:self.contentView];
    if (!CGRectContainsPoint(self.customAlertView.frame, tapPoint))
    {
        [self.contentView removeFromSuperview];
    }
}

#pragma mark - setter or getter

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:self.view.frame];
        _contentView.backgroundColor = RGBA(0, 0, 0, 0.4);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_contentView addGestureRecognizer:tap];
        [_contentView addSubview:self.customAlertView];
    }
    return _contentView;
}

- (UIView *)customAlertView
{
    if (!_customAlertView)
    {
        _customAlertView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, WIDTH(self.view)-50, 150)];
        _customAlertView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_customAlertView, 4);
        _customAlertView.center = self.view.center;
        
        [_customAlertView addSubview:self.titleLabel];
        [_customAlertView addSubview:self.selectedBtn];
        [_customAlertView addSubview:self.agreeBtn];
    }
    return _customAlertView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WIDTH(self.customAlertView), 20)];
        _titleLabel.text = @"请选择人物身份";
        _titleLabel.textColor = DarkGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIButton *)selectedBtn
{
    if (!_selectedBtn)
    {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedBtn.frame = CGRectMake(15, MaxY(self.titleLabel)+10, WIDTH(self.customAlertView)-30, 44);
        [_selectedBtn setTitle:@"父亲" forState:UIControlStateNormal];
        [_selectedBtn setTitleColor:DarkGrayColor forState:UIControlStateNormal];
        ViewBorderRadius(_selectedBtn, 2, 1, LightGraryColor);
        UIImageView *bottomArrow = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH(_selectedBtn)-30, 12, 20, 20)];
        bottomArrow.image = OrigIMG(@"list_open");
        [_selectedBtn addSubview:bottomArrow];
    }
    return _selectedBtn;
}

- (UIButton *)agreeBtn
{
    if (!_agreeBtn)
    {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(15, MaxY(self.selectedBtn)+10, WIDTH(self.selectedBtn), 44);
        [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        _agreeBtn.backgroundColor = kHCNavBarColor;
        ViewRadius(_agreeBtn, 4);
    }
    return _agreeBtn;
}

#pragma mark - network

- (void)reqeustCheckData
{
    for (NSInteger i = 0; i < 3; i++)
    {
        HCCheckInfo *info = [[HCCheckInfo alloc] init];
        info.imageName = @"2Dbarcode_message_HeadPortraits";
        info.nickName = @"名字";
        info.detail = @"请求加入班级";
        [self.dataSource addObject:info];
    }
    [self.tableView reloadData];
}


@end

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
@property (nonatomic,strong)  NSArray *relationArr;

@property (nonatomic,strong) NSString *seleteStr;

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
    if (tableView == self.tableView)
    {
        HCCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCheckCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.info = self.dataSource[indexPath.row];
        
        return cell;

    }
    else
    {
        static NSString *ID = @"chooseID"  ;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell)
        {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = self.relationArr[indexPath.row];
        return cell;
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        return UITableViewCellEditingStyleDelete;

    }
    
    return UITableViewCellEditingStyleNone;


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
    if (tableView == self.tableView) {
        return self.dataSource.count;
    }
    return self.relationArr.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        return 60;
    }
    return 40;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.tableView) {
        
        self.seleteStr = self.relationArr[indexPath.row];
        
        [self.selectedBtn setTitle:self.seleteStr forState:UIControlStateNormal];
        
        [tableView removeFromSuperview];
        
    }
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

-(void)chooseClick:(UIButton *)button
{
     CGRect  startFrame = [self.selectedBtn convertRect:self.selectedBtn.bounds toView:self.view];
     UITableView *smallTableView = [[UITableView alloc]initWithFrame:CGRectMake(startFrame.origin.x, CGRectGetMaxY(startFrame), startFrame.size.width, 150) style:UITableViewStylePlain];
    smallTableView.delegate = self;
    smallTableView.dataSource =self;
    
    [self.view addSubview:smallTableView];
    
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
        
        [_selectedBtn addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
        
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


- (NSArray *)relationArr
{
    if(!_relationArr){
        _relationArr = @[@"父亲",@"母亲",@"姐妹",@"兄弟",@"姐弟",@"兄妹"];
    }
    return _relationArr;
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

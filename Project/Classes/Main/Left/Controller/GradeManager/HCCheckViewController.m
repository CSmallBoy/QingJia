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


#import "NHCCheckTableViewCell.h"

#import "HCFamilyapplyList.h"

#import "HCFamilyValidationJoinApply.h"

#define kCheckCellId @"checkcellid"

@interface HCCheckViewController ()<HCCheckTableViewCellDelegate,SCSwipeTableViewCellDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *customAlertView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic,strong)  NSArray *relationArr;

@property (nonatomic,strong) NSString *seleteStr;
@property (nonatomic,strong) HCCheckInfo *selectInfo;

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
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
        btn1.backgroundColor = COLOR(46, 122, 225, 1);
        UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        imageView1.image = IMG(@"一呼百应详情－delete");
        [btn1 addSubview:imageView1];
        NSArray *buttonArr = @[btn1];
        static NSString *cellIdentifier = @"joinFamilycellID";
        NHCCheckTableViewCell *cell = (NHCCheckTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[NHCCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:@"joinFamilycellID"
                                                       withBtns:buttonArr
                                                      tableView:self.tableView];
            cell.delegate = self;
        }
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
    self.selectInfo = info;
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

-(void)agreeBtnClick
{
     [self.contentView removeFromSuperview];
    [self showHUDView:nil];
    HCFamilyValidationJoinApply *api = [[HCFamilyValidationJoinApply alloc]init];
    
    api.applyUserId = self.selectInfo.applyUserId;
    
    if ([self.selectedBtn.titleLabel.text isEqualToString:@"曾祖父"]) {
        api.relation = @"0";
    }else if ([self.selectedBtn.titleLabel.text isEqualToString:@"曾祖母"])
    {
        api.relation = @"1";
    }else if ([self.selectedBtn.titleLabel.text isEqualToString:@"祖父"])
    {
        api.relation = @"2";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"祖母"])
    {
        api.relation = @"3";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"父亲"])
    {
        api.relation = @"4";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"母亲"])
    {
        api.relation = @"5";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"兄弟"])
    {
        api.relation = @"6";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"姐妹"])
    {
        api.relation = @"7";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"儿子"])
    {
        api.relation = @"8";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"女儿"])
    {
        api.relation = @"9";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"孙子"])
    {
        api.relation = @"10";
    }
    else if ([self.selectedBtn.titleLabel.text isEqualToString:@"孙女"])
    {
        api.relation = @"11";
    }
    
    
    
   
    
    
    [api startRequest:^(HCRequestStatus statusStatus, NSString *message, id respone) {
        
        if (statusStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            [self showHUDText:@"通过申请"];
            self.selectInfo.permitFlag = @"1";
            [self.tableView reloadData];
           
        }
        else
        {
            
            NSString *str = respone [@"message"];
            [self showHUDError:str];
        }
        
    }];


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
        [_agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _agreeBtn.backgroundColor = kHCNavBarColor;
        ViewRadius(_agreeBtn, 4);
    }
    return _agreeBtn;
}


- (NSArray *)relationArr
{
    if(!_relationArr){
        _relationArr = @[@"曾祖父",@"曾祖母",@"祖父",@"祖母",@"父亲",@"母亲",@"兄弟",@"姐妹",@"儿子",@"女儿",@"孙子",@"孙女"];
    }
    return _relationArr;
}



#pragma mark - network

- (void)reqeustCheckData
{
   
    HCFamilyapplyList *api = [[HCFamilyapplyList alloc]init];
    
    api.familyId = [HCAccountMgr manager].loginInfo.createFamilyId;
    api.endUserId = @"";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
      
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSArray *array = respone[@"Data"][@"rows"];
            for (int i = 0; i<array.count; i++) {
                NSDictionary *dic = array[i];
                HCCheckInfo *info = [HCCheckInfo mj_objectWithKeyValues:dic];
                [self.dataSource addObject:info];
            }
        }
        [self.tableView reloadData];
        
    }];
    
    
}


@end

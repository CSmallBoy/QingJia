//
//  HCPromisedViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//  ———————————————— 呼·应——————————————————————————

#import "HCPromisedViewController.h"
#import "HCPromiseDetailViewController1.h"
#import "HCAddPromiseViewController1.h"
#import "HCNotificationViewController.h"
#import "HCNotificationHeadImageController.h"
#import "HCMyPromisedDetailController.h"
#import "HCOtherPromisedDetailController.h"

#import "Scan_VC.h"

#import "MJRefresh.h"
#import "WKFRadarView.h"

#import "HCPromisedAddCell.h"
#import "HCPromisedListAPI.h"
#import "HCPromisedListInfo.h"
#import "HCObjectListApi.h"

#import "HCTagUserAmostListApi.h"
#import "HCNewTagInfo.h"
#import "HCPromisedTagUserDetailController.h"
#import "HCAddTagUserController.h"


#import "HCPromiedTagWhenMissController.h"
#import "HCLostInfoViewController.h"

@interface HCPromisedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isShouldWhow;//是否有雷达显示
    BOOL isObj;//是否是已存在的对象
}
@property(nonatomic,strong)UITableView     *smallTableView;
@property(nonatomic,strong)NSMutableArray  *dataArr;
@property(nonatomic,strong)UIImageView     *bgImage;//红色背景
@property(nonatomic,strong)UIButton        *headBtn;//雷达按钮
@property(nonatomic,strong)WKFRadarView    *radarView;//雷达效果图
@property(nonatomic,strong)NSString        *nextVCTitle;

@property (nonatomic,strong) UISegmentedControl  *segmented;
@property (nonatomic,strong) HCNotificationViewController *notiVC; // 应界面

@property (nonatomic, strong)UIView *alertBackground;//弹出提示框时的灰色背景
@property (nonatomic, strong)UIView *customAlertView;//自定义提示框
@property (nonatomic, assign)BOOL isNewObj;//是否是新建对象

@property (nonatomic, copy)NSString *hasCall;//是否发过呼

@property (nonatomic, copy)NSString *objId;//传到下个页面的对象ID

@end

@implementation HCPromisedViewController

- (void)viewDidLoad
{
    //  ———————————————— 呼·应——————————————————————————
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    [self addNavItem];
    self.navigationController.navigationItem.backBarButtonItem = nil;
    
    
    [self requestData]; // 请求对象列表
    [self createUI];
    [self.view addSubview:self.notiVC.view];
    self.notiVC.view.hidden = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HeadImage:) name:@"显示头像" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToNextMyDetailController:) name:@"ToNextMyController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToNextOtherController:) name:@"ToNextOtherController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRadarView) name:@"showRadarView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"refreshObjectData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callPromised) name:@"callPromised" object:nil];
    
    //当审核完成之后
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToMyNotificationVC:) name:@"afterReview" object:nil];
    
    //删除呼成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"delectCallSuccess" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([self.hasCall isEqualToString:@"1"])
    {
        [self.radarView removeFromSuperview];
        [self.radarView resume];
        [self.headBtn addSubview:self.radarView];
    }
    else
    {
        [self.radarView removeFromSuperview];
    }
    
    for (NSInteger i = 0; i<self.dataArr.count; i++)
    {
        HCNewTagInfo *info = self.dataArr[i];
        
        if ([info.hasCall isEqualToString:@"1"])
        {
            info.isBlack = YES;
        }
        else
        {
            info.isBlack = NO;
        }
        
    }
    [self.smallTableView reloadData];
}


#pragma mark --- lazyLoading

-(NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
        HCNewTagInfo *info = [[HCNewTagInfo alloc]init];
        info.trueName = @"+ 新增录入";
        [_dataArr addObject:info];
    }
    return _dataArr;
}

-(UITableView *)smallTableView
{
    if (!_smallTableView)
    {
        CGFloat StabX = self.bgImage.frame.size.width-(40/375.0)*SCREEN_WIDTH;
        CGFloat StabH = self.bgImage.frame.size.height-(110/668.0)*SCREEN_HEIGHT;
        _smallTableView = [[UITableView alloc]initWithFrame:CGRectMake((20/375.0)*SCREEN_WIDTH, (60/668.0)*SCREEN_HEIGHT, StabX, StabH) style:UITableViewStylePlain];
        _smallTableView.delegate = self;
        _smallTableView.dataSource = self;
        _smallTableView.backgroundColor = [UIColor clearColor];
        _smallTableView.rowHeight = 50;
        _smallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    _smallTableView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    return _smallTableView;
}


- (UISegmentedControl *)segmented
{
    if(!_segmented){
        _segmented = [[UISegmentedControl alloc]initWithItems:@[@"呼",@"应"]];
        _segmented.frame = CGRectMake(0, 0, 120, 30);
        _segmented.selectedSegmentIndex = 0;
        _segmented.backgroundColor = COLOR(222, 35, 46, 1);
        _segmented.tintColor = [UIColor whiteColor];
        [_segmented addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmented;
}


- (HCNotificationViewController *)notiVC
{
    if(!_notiVC){
        _notiVC = [[HCNotificationViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _notiVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        [self addChildViewController:_notiVC];
    }
    return _notiVC;
}

- (UIImageView *)bgImage
{
    if (_bgImage == nil)
    {
        _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0.8*SCREEN_WIDTH,(350/668.0)*SCREEN_HEIGHT)];
        _bgImage.userInteractionEnabled = YES;
        _bgImage.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+50/668.0*SCREEN_HEIGHT);
        _bgImage.image = [UIImage imageNamed:@"yihubaiying_Background.png"];
        _bgImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImage;
}

- (UIButton *)headBtn
{
    if (_headBtn == nil)
    {
        CGFloat  headerViewW =  110/375.0*SCREEN_WIDTH;
        _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, headerViewW, headerViewW)];
        CGFloat  headerViewY = MinY(self.bgImage)-20;
        _headBtn.center = CGPointMake(SCREEN_WIDTH/2, headerViewY);
        [_headBtn setBackgroundImage:IMG(@"yihubaiying_icon_m-talk logo_dis.png") forState:UIControlStateNormal];
        [_headBtn addSubview:self.radarView];
    }
    return _headBtn;
}

- (WKFRadarView *)radarView
{
    if (_radarView == nil)
    {
        _radarView = [[WKFRadarView alloc] initWithFrame: CGRectMake(0, 0,WIDTH(self.headBtn)*3, WIDTH(self.headBtn)*3)andThumbnail:@"yihubaiying_icon_m-talk logo_dis.png"];
        _radarView.center = CGPointMake(WIDTH(self.headBtn)/2, WIDTH(self.headBtn)/2);
        _radarView.userInteractionEnabled = NO;
    }
    return _radarView;
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
        _customAlertView = [[UIView alloc] initWithFrame:CGRectMake(30/375.0*SCREEN_WIDTH, 230/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-60/375.0*SCREEN_WIDTH, 190/668.0*SCREEN_HEIGHT)];
        ViewRadius(_customAlertView, 5);
        _customAlertView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55/668.0*SCREEN_HEIGHT, WIDTH(_customAlertView), 20/668.0*SCREEN_HEIGHT)];
        titleLabel.text = @"确认发布一呼百应";
        titleLabel.textAlignment = 1;
        [_customAlertView addSubview:titleLabel];
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(30/375.0*SCREEN_WIDTH, MaxY(titleLabel)+45/668.0*SCREEN_HEIGHT, 120/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
        ViewRadius(sureButton, 5);
        sureButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        sureButton.layer.borderWidth = 1;
        [sureButton setTitle:@"是" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customAlertView addSubview:sureButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(MaxX(sureButton)+15/375.0*SCREEN_WIDTH, MaxY(titleLabel)+45/668.0*SCREEN_HEIGHT, 120/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
        ViewRadius(cancelButton, 5);
        cancelButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        cancelButton.layer.borderWidth = 1;
        [cancelButton setTitle:@"否" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customAlertView addSubview:cancelButton];
    }
    return _customAlertView;
}


#pragma mark - layoutSubViews

-(void)createUI
{
    //背景图片
    [self.view addSubview:self.bgImage];
    //顶部图片
    [self.view addSubview:self.headBtn];
    //对象列表
    [self.bgImage addSubview:self.smallTableView];
}

-(void)addNavItem
{
    self.navigationItem.titleView = self.segmented;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"ThinkChange_sel") style:UIBarButtonItemStylePlain target:self action:@selector(ToQrcodeController:)];
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark - alert sureClick/cancelClick
//提示框"是"按钮
- (void)sureButtonAction:(UIButton *)sender
{
    [sender.superview.superview removeFromSuperview];
    isObj = YES;
    //跳转到对象信息详情页面
    [self pushObjectInfoByObjectId];
    
}

//提示框"否"按钮
- (void)cancelButtonAction:(UIButton *)sender
{
    [sender.superview.superview removeFromSuperview];
}


#pragma mark - notificationCenterAction

-(void)HeadImage:(NSNotification *)info
{
    HCNotificationHeadImageController  *imageVC = [[HCNotificationHeadImageController alloc]init];
    imageVC.data = @{@"image":info.userInfo[@"image"]};
    imageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageVC animated:YES];
}

-(void)ToNextMyDetailController:(NSNotification *)info
{

    HCMyPromisedDetailController *detailVC = [[HCMyPromisedDetailController alloc]init];
    detailVC.callId = [info.userInfo objectForKey:@"info"];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];

}

-(void)ToNextOtherController:(NSNotification  *)noti
{
    HCOtherPromisedDetailController * OtherVC = [[HCOtherPromisedDetailController alloc]init];
    OtherVC.callId = [noti.userInfo objectForKey:@"info"];
    OtherVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:OtherVC animated:YES];
}

// 从后台进入活跃状态的时候 判断是否显示雷达显示
-(void)showRadarView
{
    if ([self.hasCall isEqualToString:@"1"])
    {
        [self.radarView removeFromSuperview];
        [self.radarView resume];
        [self.headBtn addSubview:self.radarView];
    }
    else
    {
        [_radarView removeFromSuperview];
    }
    
    
    for (NSInteger i = 0; i<self.dataArr.count; i++)
    {
        HCNewTagInfo *info = self.dataArr[i];
        
        if ([info.hasCall isEqualToString:@"1"])
        {
            info.isBlack = YES;
        }
        else
        {
            info.isBlack = NO;
        }
    }
    
    [self.smallTableView reloadData];
    
}

//打开或者关闭呼
-(void)callPromised
{
    [self requestData];
}

-(void)show
{
    if ([self.hasCall isEqualToString:@"1"])
    {
        [self.radarView removeFromSuperview];
        [self.radarView resume];
        [self.headBtn addSubview:self.radarView];
    }
    else
    {
        [self.radarView removeFromSuperview];
    }
    for (NSInteger i = 0; i<self.dataArr.count; i++)
    {
        HCNewTagInfo *info = self.dataArr[i];
        
        if ([info.hasCall isEqualToString:@"1"])
        {
            info.isBlack = YES;
        }
        else
        {
            info.isBlack = NO;
        }
    }
    
    [self.smallTableView reloadData];
}

//发完呼跳转到"与我相关"
- (void)jumpToMyNotificationVC:(NSNotification *)noti
{
    if (self.segmented.selectedSegmentIndex == 0)
    {
        self.segmented.selectedSegmentIndex = 1;
        self.notiVC.view.hidden = NO;
        self.notiVC.view.bounds = CGRectMake(0, -50, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
}

#pragma mark--UITableViewDelegate

-(UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedAddCell  *cell = [HCPromisedAddCell customCellWithTable:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HCNewTagInfo *info =self.dataArr[indexPath.row];
    cell.info = info;
    cell.buttonW = self.smallTableView.frame.size.width;
    cell.buttonH = (40/668.0)*SCREEN_HEIGHT;
    cell.block = ^(NSString  *buttonTitle,HCNewTagInfo *info)
    {
        if ([buttonTitle isEqualToString:@"+ 新增录入"]) {
            //新增对象
            HCAddTagUserController *addTagUser = [[HCAddTagUserController alloc]init];
            addTagUser.isNewObj = YES;//新增对象
            addTagUser.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addTagUser animated:YES];
            
        }
        else
        {
            self.objId = info.objectId;
            [self.tabBarController.view addSubview:self.alertBackground];
        }
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (60/668.0)*SCREEN_HEIGHT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

#pragma mark --- button Click
//进入二维码扫描
-(void)ToQrcodeController:(UIBarButtonItem *)right
{
    Scan_VC *scanVC = [[Scan_VC alloc]init];
    scanVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanVC animated:YES];
}

//点击对象cell,跳转到对象信息详情
-(void)pushObjectInfoByObjectId
{
    if (isObj) {
        HCPromisedTagUserDetailController *detailVC = [[HCPromisedTagUserDetailController alloc]init];
        detailVC.isObj = NO;//不允许编辑
        detailVC.isNextStep = YES;
        detailVC.objId = self.objId;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


//选择呼/应
-(void)handleSegmentedControl:(UISegmentedControl *)segmented
{
    if (segmented.selectedSegmentIndex == 0) {
        self.notiVC.view.hidden = YES;
    }
    else
    {
        self.notiVC.view.hidden = NO;
        self.notiVC.view.bounds = CGRectMake(0, -50, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    
}

#pragma mark --- network

-(void)requestData
{
    [self showHUDView:nil];
    
     HCTagUserAmostListApi *api = [[HCTagUserAmostListApi alloc]init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        
        if (requestStatus == HCRequestStatusSuccess) {
            [self.dataArr removeAllObjects];
            
            int k = 0;
            NSArray *array = respone[@"Data"][@"rows"];
            for (NSDictionary *dic in array) {
                
                HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues:dic];
                [self.dataArr addObject:info];
                if ([info.hasCall isEqualToString:@"1"])
                {
                    k++;
                }
            }
            if (k > 0)
            {
                self.hasCall = @"1";
                
            }
            else
            {
                self.hasCall = @"0";
            }
            [self show];
            
            HCNewTagInfo *info = [[HCNewTagInfo alloc]init];
            info.trueName = @"+ 新增录入";
            [self.dataArr addObject:info];
            
            [self hideHUDView];
            
            [self.smallTableView reloadData];
 
        }
        if(self.dataArr.count == 0)
        {
            HCNewTagInfo *info = [[HCNewTagInfo alloc]init];
            info.trueName = @"+ 新增录入";
            [self.dataArr addObject:info];
            
            [self hideHUDView];
            
            [self.smallTableView reloadData];
        }
        
    }];
}

//上拉加载更多数据
-(void)requestMoreData
{
    if (self.dataArr.count>1)
    {
        HCPromisedListAPI  *api = [[HCPromisedListAPI alloc]init];
        [self.dataArr removeLastObject];
        HCPromisedListInfo *info = self.dataArr[self.dataArr.count-1];
        api.Start = [info.ObjectId intValue];
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSMutableArray *array) {
            
            if (requestStatus == HCRequestStatusSuccess)
            {
                    [self.dataArr addObjectsFromArray:array];
                    HCPromisedListInfo *info = [[HCPromisedListInfo alloc]init];
                    info.name=@"+ 新增录入";
                    [self.dataArr addObject:info];
                    [self.smallTableView reloadData];
                
                [self.smallTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.smallTableView.mj_footer endRefreshing];
                [self showHUDError:message];
            }
            
        }];
    }
    else
    {
        [self.smallTableView.mj_footer endRefreshing];
    }
    

}

@end

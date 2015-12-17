//
//  HCProducCenterViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCProducCenterViewController.h"
#import "HCProductCenterDetailViewController.h"
#import "HCImgViewTagList.h"
@interface HCProducCenterViewController ()<HCImgViewTagListDelegate>


@property(nonatomic,strong)HCImgViewTagList *imageViewList;


@property(nonatomic,assign) CGFloat padding;
@property(nonatomic,assign)CGFloat btnWidth;
@end

@implementation HCProducCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"产品中心";
    [self setupBackItem];
    
    UIView *shoppingCarView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-70, 50, 140, 140)];
    shoppingCarView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:shoppingCarView];
    
    self.padding = 30;
    self.btnWidth = SCREEN_WIDTH/3-30;
    

    
    [self.view addSubview:self.imageViewList];
   
    
}


-(void)ImgViewTagList:(NSInteger)index
{
    switch (index) {
        case 0:
           [self pushToJDBuyVC];
            break;
            case 1:
            [self pushToMTalkBuyVC];
            break;
            case 2:
            [self pushToTaoBaoVC];
        default:
            break;
    }
}

//跳转京东购买页面
-(void)pushToJDBuyVC
{
    DLog("京东购买");
}

//跳转M-Talk购买页面
 -(void)pushToMTalkBuyVC
{
    DLog("M-talk购买");
    [self.navigationController pushViewController:[[HCProductCenterDetailViewController alloc]init] animated:YES];
    
}
//跳转淘宝购买页面
-(void)pushToTaoBaoVC
{
    DLog("淘宝购买");
}

#pragma mark---Setter And Getter

-(HCImgViewTagList *)imageViewList
{
    if (!_imageViewList) {
        _imageViewList = [[HCImgViewTagList alloc]initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 80)];
        _imageViewList.delegate = self;
        _imageViewList.array = @[@[@"more_test", @"京东购买"], @[@"more_test", @"M-Talk购买"], @[@"more_test", @"淘宝购买"]];
        
    }
    return _imageViewList;
}




@end

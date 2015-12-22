//
//  HCProducCenterViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCProducCenterViewController.h"
#import "HCProductCenterDetailViewController.h"
#import "HCJDBuyViewController.h"
#import "HCTaoBaoViewController.h"

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
    
    UIImageView *shoppingCarView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-70,100, 140, 140)];
    shoppingCarView.image = [UIImage imageNamed:@"Products_but_shopping cart1"];

    
    [self.view addSubview:shoppingCarView];
    
    self.padding = 30;
    self.btnWidth = SCREEN_WIDTH/3-30;
    
    [self.view addSubview:self.imageViewList];
   
    
}


-(void)ImgViewTagList:(NSInteger)index
{
    switch (index)
    {
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
    
    [self.navigationController pushViewController:[HCJDBuyViewController new] animated:YES];

}

//跳转M-Talk购买页面
 -(void)pushToMTalkBuyVC
{
    [self.navigationController pushViewController:[[HCProductCenterDetailViewController alloc]init] animated:YES];
    
}
//跳转淘宝购买页面
-(void)pushToTaoBaoVC
{
     [self.navigationController pushViewController:[HCTaoBaoViewController new] animated:YES];
}

#pragma mark---Setter And Getter

-(HCImgViewTagList *)imageViewList
{
    if (!_imageViewList) {
        _imageViewList = [[HCImgViewTagList alloc]initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, 80)];
        _imageViewList.delegate = self;
        _imageViewList.array = @[@[@"Products_but_shopping cart2", @"京东购买"], @[@"Products_but_shopping cart3", @"M-Talk购买"], @[@"Products_but_shopping cart4", @"淘宝购买"]];
        
    }
    return _imageViewList;
}




@end

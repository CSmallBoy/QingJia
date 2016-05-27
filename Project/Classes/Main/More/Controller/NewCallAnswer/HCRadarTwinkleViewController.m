//
//  HCRadarTwinkleViewController.m
//  钦家
//
//  Created by Tony on 16/5/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRadarTwinkleViewController.h"
#import "WKFRadarView.h"


@interface HCRadarTwinkleViewController ()

@property (nonatomic, strong)WKFRadarView *radarView;//雷达效果
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;//计时

@end

@implementation HCRadarTwinkleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发送中";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.radarView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.timeLabel];
    [self countdown];
    
}

#pragma mark - lazyLoading 

- (WKFRadarView *)radarView
{
    if (_radarView == nil)
    {
        _radarView = [[WKFRadarView alloc] initWithFrame: CGRectMake((SCREEN_WIDTH-300)/2, 190/668.0*SCREEN_HEIGHT, 300, 300)andThumbnail:@"yihubaiying_icon_m-talk logo_dis.png"];
    }
    return _radarView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.radarView)+90/668.0*SCREEN_HEIGHT, SCREEN_WIDTH, 20)];
        _titleLabel.text = @"正在审核中...";
        _titleLabel.textAlignment = 1;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 84, 40, 40)];
        _timeLabel.backgroundColor = [UIColor redColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = 1;
        ViewRadius(_timeLabel, 20);
    }
    return _timeLabel;
}

#pragma mark - time

//倒计时
- (void)countdown
{
    __block int timeout = 3; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLabel.text = @"0";
                //跳转到指定界面
                //1.先返回呼
                [self.navigationController popToRootViewControllerAnimated:YES];
                //2.监听改变选中的页面
                [[NSNotificationCenter defaultCenter] postNotificationName:@"afterReview" object:nil];
                
                
            });
        }else{
            int seconds = timeout % 100;
            NSString *strTime = [NSString stringWithFormat:@"%.d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLabel.text = strTime;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

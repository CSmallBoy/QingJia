//
//  HCMergingFamilyViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMergingFamilyViewController.h"
#import "HCMergingFamilyView.h"
@interface HCMergingFamilyViewController ()<UIGestureRecognizerDelegate>{
    //图片数组
    NSMutableArray *arr;
    UIView *_baseView;
    BOOL anibool;
    int _index;
    //侧面显示的图片view
    UIView *view_all;
    int mid;
    CGFloat fujunli;
    UILabel *name_label;
    
    
}

@end

@implementation HCMergingFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackItem];
    self.view.backgroundColor = [UIColor grayColor];
    HCMergingFamilyView *view_left = [[HCMergingFamilyView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*0.33, SCREEN_HEIGHT)];
    view_left.up_label.text = @"2015";
    view_left.down_label.text = @"2016";
    view_left.time_label.text = @"feb";
    [self.view addSubview:view_left];
    
   
    view_all  = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.33, 64, SCREEN_WIDTH*0.67, SCREEN_HEIGHT -64)];
    view_all.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view_all];
    
    _click=^(int i)
    {
        NSLog(@"单击了第%d项",i);
    };
    _baseView=[[UIView alloc]init];
    _baseView.frame=view_all.bounds;
    NSLog(@"_%f",_baseView.frame.size.height);
    [view_all addSubview:_baseView];
    
    anibool=YES;
    UISwipeGestureRecognizer *rec=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp:)];
    rec.direction=UISwipeGestureRecognizerDirectionUp;
    rec.delegate =self;
    
    [view_all addGestureRecognizer:rec];
    UISwipeGestureRecognizer *recdown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp:)];
    recdown.direction=UISwipeGestureRecognizerDirectionDown;
    recdown.delegate =self;
    [view_all addGestureRecognizer:recdown];
    
    arr = [NSMutableArray arrayWithCapacity:0];
    //到时候从服务器获取的图片信息
    for (int i = 0; i < 11; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [arr addObject:image];
    }
    [self setImages:arr];
}

//开启识别手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES; // Recognizers of this class are the first priority
}
//图片显示
-(void)setImages:(NSArray *)images
{
    _images=images;
    int count=(int)images.count;
     mid=count/2;
    CGFloat smallH=30;
    if (count>6) {
        smallH=20;
    }
    //草纸上的 H = 50
    //距离边上的 负数距离
    fujunli = - (50 * (count-1)/2 -((SCREEN_HEIGHT - 64 - 230)/2));
    for (int i=0; i<count; i++) {
        UIImageView *view1=[[UIImageView alloc]init];
        view1.userInteractionEnabled = YES;
        CGFloat dd=abs(mid-i);
        if (i<mid) {
            view1.frame=CGRectMake(40*dd, fujunli+ 50*i, _baseView.frame.size.width, 46);
            
        }else if(i>mid)
        {
            view1.frame=CGRectMake(40*dd,fujunli+230+50*(i-1), _baseView.frame.size.width, 46);
            
        }else
        {
            view1.frame=CGRectMake(2, 50*mid+fujunli, _baseView.frame.size.width-4, 230);
            
        }
     
        view1.image=arr[i];
        view1.backgroundColor=[UIColor clearColor];
        view1.tag=i+1;
        //view1.clipsToBounds  = YES;
        //添加四个边阴影
        view1.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        view1.layer.shadowOffset = CGSizeMake(4,4);//偏移距离
        view1.layer.shadowOpacity = 0.8;//不透明度
        view1.layer.shadowRadius = 2.0;//半径
        [_baseView addSubview:view1];
    }
    
    CGFloat btnX=_baseView.frame.origin.x;
    CGFloat btnY=_baseView.frame.origin.y;
    CGFloat btnW=_baseView.frame.size.width;
    CGFloat btnH=50*mid;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(btnX, btnY+fujunli, btnW, btnH);
    btn.tag=101;
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchUpInside];
    [view_all addSubview:btn];
    
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(btnX, btnY+230+50*mid+fujunli, btnW, btnH);
    btn2.backgroundColor=[UIColor clearColor];
    btn2.tag=102;
    [btn2 addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchUpInside];
    [view_all addSubview:btn2];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(2, 50*mid, _baseView.frame.size.width-4, 230);
    btn3.backgroundColor=[UIColor clearColor];
    btn3.tag=103;
    [btn3 addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchUpInside];
    [view_all addSubview:btn3];
    
    name_label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *0.33, 50*mid+fujunli +180 + 64, SCREEN_WIDTH *0.67, 50)];
    name_label.text = @"幸福家庭";
    name_label.backgroundColor = [UIColor grayColor];
    name_label.alpha = 0.5;
    name_label.textColor = [UIColor whiteColor];
    name_label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:name_label];
}
-(void)swipeUp:(UISwipeGestureRecognizer *)zer
{
    if (zer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        [self setAllFramge:0];
    }else if(zer.direction==UISwipeGestureRecognizerDirectionDown)
    {
        [self setAllFramge:1];
    }
}
-(void)chick:(UIButton *)btn
{
    if (btn.tag==103) {
        _click(_index);
        NSLog(@"单击了");
    }else
    {
        [self setAllFramge:(int)btn.tag-100];
    }
    
}
//算法  动画效果
-(void)setAllFramge:(int)tag
{
    if (anibool==NO) {
        return;
    }
    anibool=NO;
    unsigned long count=_baseView.subviews.count;
    if (tag==1)
    {
        CGFloat minH=0;
        UIView *minHiew;
        for (int i=1; i<count+1; i++)
        {
            UIView *view1=[_baseView viewWithTag:i];
            CGFloat min=CGRectGetMaxY(view1.frame);
            if (min>minH) {
                minH=min;
                minHiew=[_baseView viewWithTag:i];
            }
            
        }
        if (minH>0) {
            for (int j=0; j<count; j++)[_baseView sendSubviewToBack:minHiew];
            
        }
        [UIView animateWithDuration:0.4 animations:^{
            CGRect rect=[[_baseView viewWithTag:1] frame];
            for (int i=1; i<count+1; i++)
            {
                if (i==count) {
                    [[_baseView viewWithTag:i] setFrame:rect];
                }
                else
                {
                    [[_baseView viewWithTag:i] setFrame:[[_baseView viewWithTag:i+1] frame]];
                }
            }
        } completion:^(BOOL finished) {
            anibool=YES;
            [self bigtop];
        }];
        
    }else
    {
        
        CGFloat minH=10000;
        UIView *minHiew;
        for (int i=1; i<count+1; i++)
        {
            UIView *view1=[_baseView viewWithTag:i];
            CGFloat min=CGRectGetMinY(view1.frame);
            if (min<minH) {
                minH=min;
                minHiew=[_baseView viewWithTag:i];
            }
        }
        if (minH<10000) {
            for (int j=0; j<count; j++)[_baseView sendSubviewToBack:minHiew];
        }
        [UIView animateWithDuration:0.4 animations:^{
            CGRect rect=[[_baseView viewWithTag:count] frame];
            for (int i=1; i<count+1; i++)
            {
                if (i==count) {
                    [[_baseView viewWithTag:1] setFrame:rect];
                }
                else
                {
                    [[_baseView viewWithTag:count-i+1] setFrame:[[_baseView viewWithTag:count-i] frame]];
                }
            }
            
        } completion:^(BOOL finished) {
            anibool=YES;
            [self bigtop];
        }];
    }
    
    

    
}

-(void)bigtop
{
    unsigned long count=_baseView.subviews.count;
    CGFloat maxW=0;
    UIView *maxHiew;
    for (int i=1; i<count+1; i++)
    {
        UIView *view1=[_baseView viewWithTag:i];
        if (view1.frame.size.width>maxW) {
            maxW=view1.frame.size.width;
            maxHiew=[_baseView viewWithTag:i];
            _index=i;
        }
    }
    if (maxW>0) {
        for (int j=0; j<count; j++)[_baseView bringSubviewToFront:maxHiew];
        
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        name_label.alpha = 0;
    }];
    [UIView animateWithDuration:1 animations:^{
        name_label.alpha = 0.5;
    }];
    
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

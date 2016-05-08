//
//  HCPromisedReportController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedReportController.h"

#import "HCFeedbackTextView.h"

@interface HCPromisedReportController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView * upView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UITableView *smallTableView;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) NSArray  *chooseArr;

@end

@implementation HCPromisedReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"举报";
    [self setupBackItem];
    self.view.backgroundColor = COLOR(221, 221, 221, 1);
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(send:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    [self.view addSubview:self.upView];
    [self.view addSubview:self.bottomView];

}

#pragma mark --- tableViewDelegate  and dataScource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chooseArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"smallChooseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.textLabel.text = self.chooseArr[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.button setTitle:self.chooseArr[indexPath.row] forState:UIControlStateNormal];
    [tableView removeFromSuperview];
}


#pragma mark private mothods

-(void)send:(UIBarButtonItem *) right
{

}

-(void)choose:(UIButton *)button
{
   
    [self.view addSubview:self.smallTableView];
    
}

#pragma mark getter- setter

- (UIView *)upView
{
    if(!_upView){
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,80/667.0 *SCREEN_HEIGHT)];
        _upView.backgroundColor = COLOR(241, 241, 241, 1);
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 10, 15, 15)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = IMG(@"report");
        imageView.tintColor = COLOR(62, 134, 224, 1);
        
        
        [_upView addSubview:imageView];
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 10, 50, 20)];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = @"举报原因";
        label.textColor = COLOR(62, 134, 224, 1);
        
        [_upView addSubview:label];
        
        _button =[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(30, CGRectGetMaxY(label.frame) + 10, SCREEN_WIDTH-60, 30);
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = [UIColor blackColor].CGColor;
        [_button setTitle:@"不文明内容" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImageView *sanjiaoIV = [[UIImageView alloc]initWithFrame:CGRectMake(_button.frame.size.width-20, 10, 10, 10)];
        sanjiaoIV.image = IMG(@"sanjiao");
        
        [_button addSubview:sanjiaoIV];
    
        
        
        [_upView addSubview:_button];
        
        
    }
    return _upView;
}


- (UIView *)bottomView
{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upView.frame)+10, SCREEN_WIDTH,260)];
        _bottomView.backgroundColor = COLOR(241, 241, 241, 1);
        HCFeedbackTextView *textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        textView.textView.text = @"描述详情:";
        textView.textView.textColor = [UIColor blackColor];
        textView.textView.backgroundColor = COLOR(241, 241, 241, 1);
        
        [_bottomView addSubview:textView];
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10,180, 60, 60);
        [button setBackgroundImage:IMG(@"Add-Images") forState:UIControlStateNormal];
        
        [_bottomView addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, 60, 20)];
        label.font= [UIFont systemFontOfSize:12];
        label.text = @"添加图片";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        
        [_bottomView addSubview:label];
                                    
        
    }
    return _bottomView;
}



- (UITableView *)smallTableView
{
    if(!_smallTableView){
         CGRect  startFrame = [self.button convertRect:self.button.bounds toView:self.view];
        _smallTableView = [[UITableView alloc]initWithFrame:CGRectMake(startFrame.origin.x, CGRectGetMaxY(startFrame), startFrame.size.width, 150) style:UITableViewStylePlain];
        
        _smallTableView.delegate = self;
        _smallTableView.dataSource = self;
    }
    return _smallTableView;
}



- (NSArray *)chooseArr
{
    if(!_chooseArr){
        _chooseArr = @[@"暴力",@"血腥",@"黄色淫秽",@"虚假信息",@"传销",@"其他"];
    }
    return _chooseArr;
}


#pragma mark - Networking




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

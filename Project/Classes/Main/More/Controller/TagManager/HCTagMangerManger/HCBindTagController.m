//
//  HCBindTagController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCBindTagController.h"
#import "HCNewTagInfo.h"
#import "HCObjectListApi.h"
#import "HCTagActivateApi.h"

@interface HCBindTagController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray * objectArr;
@property (nonatomic,assign) NSInteger  index;
@property (nonatomic,strong) HCNewTagInfo *seletedInfo;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *nomalLabel;


@end

@implementation HCBindTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定标签";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    
    self.index = 0;
    
    [self requestObjectData]; // 获得所有的对象
    
    self.tableView.tableHeaderView =HCTabelHeadView(0.1);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonClick:)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 220;
    }
    else
    {
        return 290;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"bindTagID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
    
    if (indexPath.row == 0)
    {
        UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-40), 50, 80, 80)];
        imageView.image = IMG(@"2Dbarcode");
        [cell addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 145, SCREEN_WIDTH, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"ID:%@",@"12345678"];
        [cell addSubview:label];
        
    }
    else if (indexPath.row ==1)
    {
        
        for (int i  = 0;i<self.objectArr.count;i++) {
            
            HCNewTagInfo *info = self.objectArr[i];
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 230)];
            view.backgroundColor = kHCNavBarColor;
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 210)];
            NSURL *url = [readUserInfo originUrl:info.imageName :kkUser];
            [imageView sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
            
            [view addSubview:imageView];
            
            [self.scrollView addSubview:view];
            
        }
        
        [cell addSubview:self.scrollView];
        self.nameLabel.text = self.seletedInfo.trueName;
        [cell addSubview:self.nameLabel];
        [cell addSubview:self.nomalLabel];
    }
    
    return cell;

 
}

#pragma mark --- UIScrollViewDelegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    NSLog(@"%f",offset);

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    CGFloat offset = scrollView.contentOffset.x;
    NSLog(@"%f",offset);
    self.index = offset/SCREEN_WIDTH;
    
    NSLog(@"%ld",self.index);
    
    self.seletedInfo = self.objectArr[self.index];
    self.nameLabel.text = self.seletedInfo.trueName;
    
}

#pragma mark --- provite mothods
// 点击了确定按钮
-(void)sureButtonClick:(UIBarButtonItem *)right
{
    HCTagActivateApi *api = [[HCTagActivateApi alloc]init];
    
    api.labelGuid = @"8f0a-4aed-0000";
    api.imageName = self.seletedInfo.imageName;
    api.labelTitle = @"儿子";
    api.objectId = self.seletedInfo.objectId;
    api.contactorId1 = self.seletedInfo.contactorId1;
    api.contactorId2 = self.seletedInfo.contactorId2;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self showHUDSuccess:@"激活成功"];
        }
        
    }];
    
 
}



- (UIScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    
    }
    return _scrollView;
}


- (NSMutableArray *)objectArr
{
    if(!_objectArr){
        _objectArr = [NSMutableArray array];
    }
    return _objectArr;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, 20)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}


- (UILabel *)nomalLabel
{
    if(!_nomalLabel){
        _nomalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, SCREEN_WIDTH, 20)];
        _nomalLabel.textColor = [UIColor blackColor];
        _nomalLabel.textAlignment = NSTextAlignmentCenter;
        _nomalLabel.text = @"选择绑定为标签试用者";
    }
    return _nomalLabel;
}


#pragma mark --- network
// 获得所有的对象
-(void)requestObjectData
{
    HCObjectListApi *api = [[HCObjectListApi alloc]init];

    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSArray *array =respone[@"Data"][@"rows"];
            for (NSDictionary *dic in array) {
                HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues: dic];
                [self.objectArr addObject:info];
            }
            
            self.seletedInfo = self.objectArr[0];
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.objectArr.count), 230);
            NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end

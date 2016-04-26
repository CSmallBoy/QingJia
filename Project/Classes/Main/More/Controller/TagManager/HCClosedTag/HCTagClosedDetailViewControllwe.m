//
//  HCTagClosedDetailViewControllwe.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//已停用标签详情

#import "HCTagClosedDetailViewControllwe.h"


#import "HCTagManagerInfo.h"

#import "HCTagDetailHeaderView.h"
#import "HCTagDetailTableViewCell.h"
#import "HCHeathViewController.h"
#define TagManagerDetailCell @"TagManagerDetailCell"

@interface HCTagClosedDetailViewControllwe (){
    BOOL ool;
    UIButton *button;
    UIButton *button2;
    UIView *view_all;
}

@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) HCNewTagInfo *info;


@end

@implementation HCTagClosedDetailViewControllwe

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    UIBarButtonItem  *rightItem = [[UIBarButtonItem alloc]
                                   initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    _info = self.data[@"data"];
    
    self.tableView.tableHeaderView = self.headerView;
    self.title = @"停用标签详情";
    [self.tableView registerClass:[HCTagDetailTableViewCell class] forCellReuseIdentifier:TagManagerDetailCell];
    

}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCTagDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TagManagerDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.info = self.info;
    cell.indexPath = indexPath;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//选中事件 停用标签信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HCHeathViewController *heath_vc = [[HCHeathViewController alloc]init];
    
    [self.navigationController pushViewController:heath_vc animated:YES];
}
#pragma mark---private methods

-(NSMutableAttributedString *)changeStringColorAndFontWithStart:(NSString *)start smallString:(NSString *)smallStr end:(NSString *)end
{
    NSMutableAttributedString *startString = [[NSMutableAttributedString alloc] initWithString:start];
    
    NSMutableAttributedString *smallString = [[NSMutableAttributedString alloc] initWithString:smallStr];
    [smallString addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, smallStr.length)];
    
    
    NSMutableAttributedString *endString= [[NSMutableAttributedString alloc] initWithString:end];
    
    [startString appendAttributedString:smallString];
    [startString appendAttributedString:endString];
    return startString;
}


#pragma mark --Setter Or Getter

-(UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,210)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
//        HCTagDetailHeaderView *view1 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
//        
//        view1.tagIMGView.image = OrigIMG(_info.imgArr[_index]);
//       view1.tagNameLab.attributedText = [self changeStringColorAndFontWithStart:_info.tagNameArr[_index] smallString:@"已停用" end:@""];
//        view1.tagIDLab.text = _info.tagIDArr[_index];
//        view1.tagIMGView.frame = CGRectMake(10, 10, 100, 100);
//        view1.tagNameLab.frame = CGRectMake(120, 10, SCREEN_WIDTH-130, 60);
//        view1.tagIDLab.frame = CGRectMake(120, 70, SCREEN_WIDTH-130, 40);
//        
//        [self.headerView addSubview:view1];
//        
//        HCTagDetailHeaderView *view2 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH/2, 100)];
//        
//        view2.tagIMGView.image = OrigIMG(_info.contactImgArr[0]);
//        view2.tagNameLab.text = [NSString stringWithFormat:@"%@(紧急联系人)",_info.contactNameArr[0]];
//        view2.tagNameLab.numberOfLines = 0;
//        view2.tagIDLab.text = [NSString stringWithFormat:@"电话：\n%@",_info.contactPhoneArr[0]];
//        view2.tagIMGView.frame = CGRectMake(10, 10, 60, 60);
//        view2.tagNameLab.frame = CGRectMake(75, 0, view2.bounds.size.width-75, 50);
//        view2.tagNameLab.font = [UIFont systemFontOfSize:14];
//        view2.tagIDLab.frame = CGRectMake(75, 50, view2.bounds.size.width-75, 50);
//        view2.tagIDLab.font = [UIFont systemFontOfSize:12];
//        view2.tagIDLab.numberOfLines = 0;
//        [self.headerView addSubview:view2];
//        
//        if (_info.contactImgArr.count  != 1 )
//        {
//            HCTagDetailHeaderView *view3 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 110, SCREEN_WIDTH/2, 100)];
//            view3.tagIMGView.image = OrigIMG(_info.contactImgArr[1]);
//            view3.tagNameLab.text = [NSString stringWithFormat:@"%@(紧急联系人)",_info.contactNameArr[1]];
//            view3.tagNameLab.numberOfLines = 0;
//            view3.tagIDLab.text = [NSString stringWithFormat:@"电话：\n%@",_info.contactPhoneArr[1]];
//            view3.tagIMGView.frame = CGRectMake(10, 10, 60, 60);
//            view3.tagNameLab.frame = CGRectMake(75, 0, view2.bounds.size.width-75, 50);
//            view3.tagNameLab.font = [UIFont systemFontOfSize:14];
//            view3.tagIDLab.frame = CGRectMake(75, 50, view2.bounds.size.width-75, 50);
//            view3.tagIDLab.font = [UIFont systemFontOfSize:12];
//            view3.tagIDLab.numberOfLines = 0;
//            [self.headerView addSubview:view3];
//            
//        }
//
        UIImageView *image_head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
//        image_head.image = OrigIMG(_info.imgArr[_index]);
        [self.headerView addSubview:image_head];
        
        UILabel *idLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 140, 110, 20)];
        idLabel.text = @"ID:123456789";
        idLabel.adjustsFontSizeToFitWidth = YES;
        idLabel.textColor = [UIColor blackColor];
        [self.headerView addSubview:idLabel];
        
        NSArray *arr =@[@"父亲(紧急联系人)",@"母亲(紧急联系人)"];
        UIView *view2 = [[UIView  alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 50)];
        for (int i = 0 ; i < 2; i ++) {
            UIImageView *image_phone = [[UIImageView alloc]initWithFrame:CGRectMake(100 + i * 130, 15, 20, 20)];
            image_phone.image = [UIImage imageNamed:@"PHONE-2"];
            UILabel *phone_num = [[UILabel alloc]initWithFrame:CGRectMake(130 + i * 130, 12, 100, 30)];
            phone_num.font = [UIFont systemFontOfSize:13];
            phone_num.text = arr[i];
            [view2 addSubview:image_phone];
            [view2 addSubview:phone_num];
        }
        [self.headerView addSubview:view2];
    }
    UIButton *header_button = [UIButton buttonWithType:UIButtonTypeCustom];
    header_button.frame = CGRectMake(10, 130, 70, 70);
    header_button.layer.masksToBounds = YES;
    header_button.layer.cornerRadius = 35;
    [header_button setImage:[UIImage imageNamed:@"image_hea.jpg"] forState:UIControlStateNormal];
    [_headerView addSubview:header_button];
    
    return _headerView;

}


@end

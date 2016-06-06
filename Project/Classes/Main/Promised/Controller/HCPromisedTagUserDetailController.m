//
//  HCTagUserDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTagUserDetailController.h"
#import "HCTagEditContractPersonController.h"
#import "HCPromiedTagWhenMissController.h"

#import "HCNewTagInfo.h"
#import "HCTagUserDetailCell.h"
#import "HCPickerView.h"
#import "HCAvatarMgr.h"

#import "HCTagAddObjectApi.h"
#import "HCInitSendMessageApi.h"
#import "HCContractPersonListApi.h"
#import "HCTagChangeObjectApi.h"

#import "HCTagContactInfo.h"// 联系人模型
#import "HCPromisedMissMessageControll.h"


@interface HCPromisedTagUserDetailController ()<HCPickerViewDelegate>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic,strong) HCPickerView *datePicker;//选择生日
@property (nonatomic,strong) HCNewTagInfo *info;//存储该对象的所有信息
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIView *medicalView;//区头,医疗急救卡
@property (nonatomic,strong) UIButton *relBtn;// 关系按钮
@property (nonatomic,strong) UIImageView *smallIV;
@property (nonatomic,strong) UIScrollView *scrollView;//展示绑定联系人

@property (nonatomic,strong)UIView*blackView;;
@property (nonatomic,strong)UIView *whiteView;

@property (nonatomic,assign) NSInteger index;
//@property (nonatomic,strong) NSMutableArray *contactArr;//该对象绑定的联系人数组
@property (nonatomic,strong) NSMutableArray *selectArr;
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic,strong) NSArray *relativeArr;//关系列表
@property (nonatomic,strong) NSMutableArray *tagArr;//该对象绑定的标签数组

@property (nonatomic, strong)HCTagContactInfo *contactInfo1;//紧急联系人1
@property (nonatomic, strong)HCTagContactInfo *contactInfo2;//紧急联系人2

@property (nonatomic,strong) UISwitch *sw;//医疗急救卡开关
@property (nonatomic, strong)UIButton *nextStepBtn;//下一步


@end

@implementation HCPromisedTagUserDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //对象信息页面
    [self setupBackItem];
    [self.view addSubview:self.tableview];
    if (self.isObj)//允许编辑
    {
        UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemClick:)];
        self.navigationItem.rightBarButtonItem = editItem;
        if (self.isNextStep)
        {
            self.tableview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-50-64);
            [self.view addSubview:self.nextStepBtn];
        }
        else
        {
            self.tableview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        }
    }
    else//不允许编辑
    {
        if (self.isNextStep)
        {
            self.tableview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-50-64);
            [self.view addSubview:self.nextStepBtn];
        }
        else
        {
            self.tableview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        }
    }
    
    //请求到紧急联系人列表
//    [self requestContactData];
    //根据该对象ID请求对象信息
    [self requestData];

}

#pragma mark - lazyLoading

- (UITableView *)tableview
{
    if (_tableview == nil)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-50-64) style:UITableViewStyleGrouped];
        _tableview.tableHeaderView = HCTabelHeadView(0.1);
        _tableview.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (UIButton *)nextStepBtn
{
    if (_nextStepBtn == nil)
    {
        _nextStepBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 50, SCREEN_WIDTH-20, 40)];
        _nextStepBtn.backgroundColor = kHCNavBarColor;
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewRadius(_nextStepBtn, 5);
        [_nextStepBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableview) {
         return 3;
    }
    else
    {
        return 1;
    }
    
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.tableview)
    {
        if (section == 0)
        {
            return 6;
        }
        else if (section == 1)
        {
            if ([self.info.openHealthCard isEqualToString:@"0"])
            {
                return 0;
            }
            else
            {
                return 6;
            }
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 12;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableview)
    {
        if (section == 0)
        {
            return 0.1;
        }
        else
        {
            return 40;
        }
    }
    else
    {
        return 0.1;
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableview)
    {
        if ((indexPath.section == 1 && indexPath.row == 3)||
            (indexPath.section == 1 && indexPath.row == 4)||
            (indexPath.section == 1 && indexPath.row == 5))
        {
            return 88;
        }
        else if (indexPath.section == 2)
        {
            return 150;
        }
        else
        {
            return 44;
        }
    }else
    {
        return 30;
    }
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableview)
    {
        //添加紧急联系人
        if (indexPath.section == 2)
        {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

            UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 93, 150)];
            // 头像
            UIImageView *imageIV1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 73, 73)];
            NSURL *url1 = [readUserInfo originUrl:self.contactInfo1.imageName :@"contactor"];
            [imageIV1 sd_setImageWithURL:url1 placeholderImage:IMG(@"Head-Portraits")];
            ViewRadius(imageIV1, 73/2);
            [view1 addSubview:imageIV1];
                    
            // 姓名label
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 93, 20)];
            label1.textColor = [UIColor blackColor];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.text = self.contactInfo1.trueName;
            [view1 addSubview:label1];
            
            [self.scrollView addSubview:view1];
            
            UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(93, 0, 93, 150)];
            // 头像
            UIImageView *imageIV2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 73, 73)];
            NSURL *url2 = [readUserInfo originUrl:self.contactInfo2.imageName :@"contactor"];
            [imageIV2 sd_setImageWithURL:url2 placeholderImage:IMG(@"Head-Portraits")];
            ViewRadius(imageIV2, 73/2);
            [view2 addSubview:imageIV2];
            
            // 姓名label
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 93, 20)];
            label2.textColor = [UIColor blackColor];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.text = self.contactInfo2.trueName;
            [view2 addSubview:label2];
            
            [ self.scrollView addSubview:view2];
            [cell addSubview:self.scrollView];
            return cell;
        }
        else
        {
            HCTagUserDetailCell *cell = [HCTagUserDetailCell cellWithTableView:tableView];
            cell.info = self.info;
            cell.image = self.image;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.indexPath = indexPath;
            cell.userInteractionEnabled = NO;
            return cell;
        }
    }
    else
    {
        static NSString *ID  = @"relativeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        }
        cell.textLabel.text = self.relativeArr[indexPath.row];
        return cell;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableview) {
        if (section == 1)
        {
            if ([self.info.openHealthCard isEqualToString:@"0"])
            {
                _sw.on = NO;
            }
            else
            {
                _sw.on = YES;
            }
            return self.medicalView;
        }
        else if (section ==2)
        {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            view.backgroundColor = kHCBackgroundColor;
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
            label.textColor = [UIColor blackColor];
            label.text = @"紧急联系人";
            label.adjustsFontSizeToFitWidth = YES;
            [view addSubview:label];
            return view;
        }
    }
    return nil;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableview) {
        if (indexPath.section == 0 && indexPath.row == 3) {
            
            [self.view endEditing:NO];
            [self.datePicker show];
            
        }
        else  if (indexPath.section == 0  && indexPath.row == 0)
        {
            [self.datePicker removeFromSuperview];
            [self showAlbums];
        }
        else
        {
            [self.datePicker removeFromSuperview];
        }
    }else
    {
         NSString *str = self.relativeArr[indexPath.row];
        [self.relBtn setTitle:str forState:UIControlStateNormal];
        
        [tableView removeFromSuperview];
    }
 
    
}

#pragma mark --- HCPickerViewDelegate

-(void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
    self.info.birthDay = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

}

#pragma mark --- private  mothods

/*
// 点击了选中联系人按钮
-(void)selectBtnClick:(UIButton *)button
{
    if (!button.selected)
    {
        if (self.selectArr.count == 2)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能绑定两个紧急联系人" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            NSInteger index = button.tag-100;
             HCTagContactInfo *info = self.contactArr[index];
            [self addSmallView:info index:index];
            self.index = index;
            button.selected = !button.selected;
        }
    }
    else
    {
        NSInteger index = button.tag-100;
        HCNewTagInfo *info = self.contactArr[index];
        [self.selectArr removeObject:info];
        button.selected = !button.selected;
    }

    
}


// 添加小视图
-(void)addSmallView:(HCTagContactInfo *)info index:(NSInteger)index
{
    // 黑色
    _blackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:_blackView];
    
    // 白色
    CGFloat viewW = 325/375.0*SCREEN_WIDTH;
    CGFloat viewH = 290/667.0*SCREEN_HEIGHT;
    CGFloat viewY = 200/667.0*SCREEN_HEIGHT;
     _whiteView= [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-viewW)/2,viewY, viewW,viewH)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    ViewRadius(_whiteView, 5);
    [_blackView addSubview:_whiteView];
    
    // 头像
    CGFloat imgW = 115/375.0*SCREEN_WIDTH;
    CGFloat imgY = 18/667.0*SCREEN_HEIGHT;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((viewW-imgW)/2, imgY, imgW, imgW)];
    imageView.image = self.imgArr[index];

    ViewRadius(imageView, imgW/2);
    [_whiteView addSubview:imageView];
    
    // 姓名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,imgY + imgW +5,viewW, 20)];
    nameLabel.text = info.trueName;
    nameLabel.adjustsFontSizeToFitWidth  = YES;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:nameLabel];
    
    // 请选择关系按钮;
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(viewW/2-100,imgY + imgW +30 , 200, 30)];
    
    button1.layer.borderColor = kHCBackgroundColor.CGColor;
    button1.layer.borderWidth = 1;
    [button1 setTitle:@"点击选择关系" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.relBtn = button1;
    
    _smallIV = [[UIImageView alloc]initWithFrame:CGRectMake(175, 7, 15, 15)];
    _smallIV.image = IMG(@"list_close");
    [self.relBtn addSubview:_smallIV];
    [self.relBtn addTarget:self action:@selector(relBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_whiteView addSubview:self.relBtn];
    
     // 确定
    CGFloat btnH = 40/667.0 *SCREEN_HEIGHT;
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,viewH-btnH,viewW , btnH);
    button.backgroundColor = kHCNavBarColor;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_whiteView addSubview:button];
    

}

-(void)relBtnClick:(UIButton *)button
{
    _smallIV.image = IMG(@"list_open");
    
    
    CGRect rect = [button convertRect:button.bounds toView:self.view];
    
    UITableView *smallTB = [[UITableView alloc]initWithFrame:CGRectMake(rect.origin.x,rect.origin.y, 200, 200) style:UITableViewStyleGrouped];
    smallTB.delegate = self;
    smallTB.dataSource = self;
    [self.view addSubview:smallTB];
    
}

// 点击了确定按钮

-(void)shoreBtnClick:(UIButton *)button
{
    if ([self.relBtn.titleLabel.text isEqualToString:@"点击选择关系"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择关系" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        HCTagContactInfo *info = self.contactArr[self.index];
        info.relative = self.relBtn.titleLabel.text;
        [self.selectArr addObject:info];
        [self.whiteView removeFromSuperview];
        [self.blackView removeFromSuperview];
    }
}
 

// 跳转到 新增紧急联系人界面
-(void)addContactPerson:(UIButton *)buton
{
    HCTagEditContractPersonController *editVC = [[HCTagEditContractPersonController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}
 */

//点击编辑进入新增标签使用者
- (void)editItemClick:(UIBarButtonItem *)sender
{
    
}


// 展示相册
-(void)showAlbums
{
    [self.datePicker remove];
    [self.view endEditing:YES];

    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}


// 点击医疗急救卡的
-(void)swClick:(UISwitch *)sw
{
    if (sw.on) {
        self.info.openHealthCard = @"1";
        [self.tableview reloadData];
    }
    else
    {
        self.info.openHealthCard = @"0";
        [self.tableview reloadData];
    }
}

// 点击了下一步按钮

-(void)nextBtnClick
{
    if (IsEmpty(self.info.trueName)) {
        [self showHUDText:@"请输入姓名"];
        return;
    }
    if (IsEmpty(self.info.sex)) {
        [self showHUDText:@"请输入生日"];
        return;
    }
    if (IsEmpty(self.info.homeAddress)) {
        [self showHUDText:@"请输入住址"];
        return;
    }
    if (IsEmpty(self.info.school)) {
        [self showHUDText:@"请输入学校"];
        return;
    }
    
    if ([self.info.openHealthCard isEqualToString:@"1"]) {
        
        if (IsEmpty(self.info.height)) {
            [self showHUDText:@"请输入身高"];
            return;
        }
        if (IsEmpty(self.info.weight)) {
            [self showHUDText:@"请输入体重"];
            return;
        }
        if (IsEmpty(self.info.bloodType)) {
            [self showHUDText:@"请输入血型"];
            return;
        }
        if (IsEmpty(self.info.allergic)) {
            [self showHUDText:@"请输入过敏史"];
            return;
        }
        if (IsEmpty(self.info.cureCondition)) {
            [self showHUDText:@"请输入医疗状况"];
            return;
        }
        if (IsEmpty(self.info.cureNote)) {
            [self showHUDText:@"请输入医疗笔记"];
            return;
        }
    }
    
    self.info.openHomeAddress = @"1";

    if (self.tagArr.count>0)
    {
        //跳转到走失时佩戴标签页面
        HCPromiedTagWhenMissController *vc = [[HCPromiedTagWhenMissController alloc]init];
        vc.info = self.info;
        vc.contactArr = self.selectArr;
        vc.dataArr = self.tagArr;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        //跳转到走失信息填写页面
        HCPromisedMissMessageControll*vc = [[HCPromisedMissMessageControll alloc]init];
        vc.info = self.info;
        vc.tagArr = self.tagArr;
        vc.contactArr = self.selectArr;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark--- setter Or getter

- (HCPickerView *)datePicker
{
    if (_datePicker == nil)
    {
        _datePicker = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                                  datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        _datePicker.datePicker.maximumDate = [NSDate date];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

- (UIScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (NSMutableArray *)selectArr
{
    if(!_selectArr){
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

- (NSMutableArray *)imgArr
{
    if(!_imgArr){
        _imgArr = [NSMutableArray array];
        [_imgArr addObject:@"1"];
    }
    return _imgArr;
}

- (NSArray *)relativeArr
{
    if(!_relativeArr){
        _relativeArr = @[@"曾祖父",@"曾祖母",@"祖父",@"祖母",@"父亲",@"母亲",@"兄弟",@"姐妹",@"儿子",@"女儿",@"孙女",@"孙子"];
    }
    return _relativeArr;
}


- (NSMutableArray *)tagArr
{
    if(!_tagArr){
        _tagArr = [NSMutableArray array];
    }
    return _tagArr;
}



- (UIView *)medicalView
{
    if(!_medicalView){
        _medicalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _medicalView.backgroundColor = kHCBackgroundColor;
        _medicalView.userInteractionEnabled = NO;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
        label.textColor = [UIColor blackColor];
        label.text = @"医疗急救卡";
        label.adjustsFontSizeToFitWidth = YES;
        [_medicalView addSubview:label];
        
        _sw = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 5, 40, 30)];
        [_sw addTarget:self action:@selector(swClick:) forControlEvents:UIControlEventValueChanged];
        [_medicalView addSubview:_sw];
    }
    return _medicalView;
}


#pragma mark --- network
/*
// 请求联系人数组
-(void)requestContactData
{
    [self showHUDView:nil];
    HCContractPersonListApi *api = [[HCContractPersonListApi alloc]init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            [self.contactArr removeAllObjects];
            NSArray *array = respone[@"Data"][@"rows"];
            
            for (NSDictionary *dic in array) {
                HCTagContactInfo *info = [HCTagContactInfo  mj_objectWithKeyValues:dic];
                [self.contactArr addObject:info];
                
                NSURL *url = [readUserInfo originUrl:info.imageName :@"contactor"];
                UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
                if (imgFromUrl == nil) {
                    imgFromUrl = IMG(@"Head-Portraits");
                }
                [self.imgArr addObject:imgFromUrl];
                
            }
            HCTagContactInfo *info = [[HCTagContactInfo alloc]init];
            info.trueName = @"添加联系人";
            [self.contactArr insertObject:info atIndex:0];
            self.scrollView.contentSize = CGSizeMake(93 * self.contactArr.count, 120);
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:2];
            [self hideHUDView];
            [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }];

}
 */

-(void)requestData
{
    HCInitSendMessageApi *api = [[HCInitSendMessageApi alloc]init];
    api.objectId = self.objId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSDictionary *dic = respone[@"Data"][@"objectInf"];
            self.info = [HCNewTagInfo mj_objectWithKeyValues:dic];
            self.title = [NSString stringWithFormat:@"%@的标签",self.info.trueName];
            
            //紧急联系人1
            self.contactInfo1 = [[HCTagContactInfo alloc] init];
            self.contactInfo1.trueName = self.info.contactorTrueName1;
            self.contactInfo1.phoneNo = self.info.contactorPhoneNo1;
            self.contactInfo1.imageName = self.info.imageName1;
            self.contactInfo1.relative = self.info.relation1;
            self.contactInfo1.contactorId = self.info.contactorId1;
            //紧急联系人2
            self.contactInfo2 = [[HCTagContactInfo alloc] init];
            self.contactInfo2.trueName = self.info.contactorTrueName2;
            self.contactInfo2.phoneNo = self.info.contactorPhoneNo2;
            self.contactInfo2.imageName = self.info.imageName2;
            self.contactInfo2.relative = self.info.relation2;
            self.contactInfo2.contactorId = self.info.contactorId2;
            
            [self.selectArr addObject:self.contactInfo1];
            [self.selectArr addObject:self.contactInfo2];
            
            //如果total为0,代表该对象没有绑定标签
            NSNumber *total = respone[@"Data"][@"total"];
            if ([total integerValue] != 0)
            {
                NSArray *array = respone[@"Data"][@"rows"];
                for (NSDictionary *dic in array)
                {
                    HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues:dic];
                    [self.tagArr addObject:info];
                }
            }
            [self.tableview reloadData];
            
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end

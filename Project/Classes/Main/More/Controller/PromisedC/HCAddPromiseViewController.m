//
//  HCAddPromiseViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAddPromiseViewController.h"
#import "HCPromisedHeaderIVCell.h"
#import "HCPromisedNormalCell.h"
#import "HCpromisedNormalImageCell.h"
#import "HCPromisedTextViewCell.h"
#import "HCPromisedAddCallMessageAPI.h"

#import "HCPromisedDetailInfo.h"

#import "HCAvatarMgr.h"
#import "HCPickerView.h"
@interface HCAddPromiseViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL   _isFive;
}

@property (nonatomic, strong) HCPickerView *datePicker;
@property(nonatomic,strong)NSMutableArray *TextViewCells;

@property(nonatomic,strong)NSMutableArray   *BigTitleArr;  // 标题数组
@property(nonatomic,strong)NSMutableArray   *BigDetailTitleArr; //详情标题数组
@property(nonatomic,strong)NSMutableArray   *BigDetailDetailArr;// 详情 后面数组
@property(nonatomic,strong)UITableView      *DetaileTableview;
@property(nonatomic,strong)NSMutableDictionary *textDic;
@property(nonatomic,strong) HCPromisedDetailInfo *promisedDetailInfo;

@end

@implementation HCAddPromiseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"一呼百应";
    self.tableView.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (_isEdit) {
    }
    else
    {
        [self requestCallDetailData];    
    }
    [self createUI];
}

#pragma mark UiTableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger  missIndex = 0;
    NSInteger  HospotilIndex = 0;
    if (_isFive)
    {
        missIndex = 3;
        HospotilIndex = 4;
    }
    else
    {
        missIndex = 2;
        HospotilIndex = 3;
    }
    if(indexPath.section == 0 && indexPath.row ==0 )
    {
        HCPromisedHeaderIVCell  *cell= [HCPromisedHeaderIVCell CustomCellWithTableView:tableView];
        cell.isBlack = !_isEdit;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        cell.selectImageblock = ^{
            [self addUserHeaderIMG];
        };
        return cell;
    }else  if   ((indexPath.section == 0 &&(indexPath.row ==3 || indexPath.row ==4)) ||(indexPath.section == missIndex && indexPath.row == 0))
        
    {
        HCpromisedNormalImageCell *cell = [HCpromisedNormalImageCell CustomCellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isBlack = !_isEdit;
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.text = self.textDic[indexPath];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        cell.textFieldBlock = ^(NSString  *text,NSIndexPath  *index){
            
            [self.textDic setObject:text forKey:indexPath];
            
        };
        return cell;
        
    }else  if  ((indexPath.section == missIndex &&(indexPath.row == 1)) ||(indexPath.section == HospotilIndex && indexPath.row == 1))
    
    {
        HCPromisedTextViewCell  *cell = [HCPromisedTextViewCell CustomCellWithTableView:tableView];
        cell.isBlack = !_isEdit;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.text = self.textDic[indexPath];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];
        cell.textFieldBlock = ^(NSString  *text,NSIndexPath  *index){
          
            [self.textDic setObject:text forKey:indexPath];
            
        };
        [self.TextViewCells addObject:cell];
        
        return cell;
    }
    else  if (indexPath.section == HospotilIndex && indexPath.row == 2)
    {
        static NSString *finishedCellID = @"finishedCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:finishedCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:finishedCellID];
            cell.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self  addSubviews : cell];
           
        }
        return cell;
    }else
    {
        HCPromisedNormalCell  *cell = [HCPromisedNormalCell CustomCellWithTableView:tableView];
        cell.isBlack = !_isEdit;
        cell.indexPath = indexPath;
        cell.text = self.textDic[indexPath];
        cell.textFieldBlock = ^(NSString *textFIeldtext,NSIndexPath  *indexPath1){
            
            [self.textDic setObject:textFIeldtext forKey:indexPath];
        };
      
        cell.title = self.BigDetailTitleArr[indexPath.section][indexPath.row];
        cell.detail = self.BigDetailDetailArr[indexPath.section][indexPath.row];

        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    { //姓名cell
        return 88;
    }
    else  if  (_isFive)
    { //2个了紧急联系人
        if (((indexPath.section == 3 &&(indexPath.row == 1)) ||(indexPath.section == 4 && indexPath.row == 1) ))
        { //添加了textView
              return 88;
        }
    }
    else  if  ((indexPath.section == 2 &&(indexPath.row == 1)) ||(indexPath.section == 3 && indexPath.row == 1))
    { // 1个紧急联系人
        return 88;
    }if(_isEdit)
    { //可以编辑
    
        if (_isFive)
        { //可以编辑而且5个
            if ((indexPath.section == 4 && indexPath.row == 2)  )
            {
                return 120;
            }
        }
        else
        { //可以编辑   4个
            if ((indexPath.section == 3 && indexPath.row == 2))
            {
                return 120;
            }
            
        }
    }
    else
    {//不可编辑
        if (_isFive)
        {  //不可编辑5个
            if ((indexPath.section == 4 && indexPath.row == 2)  )
            {
                return 0;
            }
        }
        else
        { //不可编辑  4个
            if ((indexPath.section == 3 && indexPath.row == 2))
            {
                return 0;
            }
            
        }
       
    }
    return 44;

   }

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isFive) {
        return 5;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self headerViewAddSubviews:view index:1];
        return view;
    }
    else  if (section == 2 && _isFive)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self headerViewAddSubviews2:view index:2];
        return view;

    }else
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self headerViewAddSubviewsElse:view index:section];
        
        return view;
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFive)
    {
        switch (section)
        {
        case 0:
            return  5;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 3;
                break;

        default:
            break;
    }
        return 0;
    }else
    {
        switch (section)
        {
            case 0:
                return  5;
                break;
            case 1:
                return 3;
                break;
            case 2:
                return 2;
                break;
            case 3:
                return 3;
                break;
            default:
                break;
        }
        return 0;
    }
}

#pragma mark --- private method
//添加完成按钮
-(void)addSubviews : (UITableViewCell  *)cell
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 40, SCREEN_WIDTH-20, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(FinishedClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ViewRadius(button , 5);
    button.backgroundColor = RGB(222, 35, 46);
    if (!_isEdit) {
        cell.hidden  = YES;
        button.hidden = YES;
    }
    [cell addSubview:button];
}
//添加紧急联系人得头视图
-(void)headerViewAddSubviews:(UIView *)view index:(NSInteger )index
{
    

    UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.textColor = [UIColor blackColor];
    label.text = self.BigTitleArr[index];
    [view addSubview:label];
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =  CGRectMake(110, 10, 20, 20);
    button.enabled = _isEdit;
    [button addTarget:self action:@selector(AddPersonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (index == 1) {
        
        [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_Plus"] forState:UIControlStateNormal];
    }
    else
    {
        [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_reduce"] forState:UIControlStateNormal];
    }
    view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    if (!_isEdit) {
        button.hidden  = YES;
    }
    [view addSubview:button];

}
// 删除紧急联系人的头视图
-(void)headerViewAddSubviews2:(UIView *)view index:(NSInteger )index
{
    UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    label.textColor = [UIColor blackColor];
    label.text = self.BigTitleArr[index];
    [view addSubview:label];
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =  CGRectMake(110, 10, 20, 20);
    button.enabled = _isEdit;
    if (!_isEdit) {
        button.hidden = YES;
    }
    [button addTarget:self action:@selector(MovePersonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (index == 1) {
        
        [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_Plus"] forState:UIControlStateNormal];
    }
    else
    {
        [button setBackgroundImage: [UIImage imageNamed:@"yihubaiying_but_reduce"] forState:UIControlStateNormal];
    }
    view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    [view addSubview:button];

}
//其他组的头视图
-(void)headerViewAddSubviewsElse :(UIView *)view index:(NSInteger)index
{
    UILabel  *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 40)];
    lable.text = self.BigTitleArr[index];
    lable.textColor = [UIColor blackColor];
    lable.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    [view addSubview:lable];
    view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
}

-(void)createUI
{
    [self.view addSubview:self.DetaileTableview];
}

//点击了添加紧急联系人
-(void)AddPersonClick :(UIButton *)button
{
    
    for (HCPromisedTextViewCell *cell in self.TextViewCells) {
        
        [cell.textView endEditing:YES];
    }
    
    if (_isFive) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能添加两个联系人" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    _isFive = YES;
    
    [self.BigTitleArr insertObject:@"紧急联系人" atIndex:1];
    [self.BigDetailTitleArr insertObject:@[@"姓名",@"关系",@"手机号"] atIndex:1];
    [self.BigDetailDetailArr insertObject:@[@"点击输入紧急联系人真实姓名",@"输入紧急联系人与走失者联系，如父子",@"点击输入紧急联系人的手机号码"] atIndex:1];
    
    for (int i = 0; i<2; i++) {
        NSIndexPath  *indexPath2 = [NSIndexPath indexPathForRow:i inSection:2];
        NSIndexPath  *indexPath3 = [NSIndexPath indexPathForRow:i inSection:3];
         NSIndexPath  *indexPath4 = [NSIndexPath indexPathForRow:i  inSection:4];
        
        if (self.textDic[indexPath3] == nil) {
            
            [self.textDic setObject:@"" forKey:indexPath4];
        }
        else
        {
           [self.textDic setObject:self.textDic[indexPath3] forKey:indexPath4];
        }
        
        if (self.textDic[indexPath2] == nil) {
            
            [self.textDic setObject:@"" forKey:indexPath3];
        }
        else
        {
            [self.textDic setObject:self.textDic[indexPath2] forKey:indexPath3];
        }
 
    }
    for (int i = 0; i<3; i++) {
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:2];
         [self.textDic setObject:@"" forKey:indexPath];
    }
    [self.DetaileTableview reloadData];

}
//点击了删除紧急联系人
-(void)MovePersonClick : (UIButton *)button
{
    
    for (HCPromisedTextViewCell *cell in self.TextViewCells) {
        
        [cell.textView endEditing:YES];
    }
    _isFive = NO;
    
    [self.BigTitleArr removeObjectAtIndex:2];
    [self.BigDetailTitleArr removeObjectAtIndex:2];
    [self.BigDetailDetailArr removeObjectAtIndex:2];
    
    for (int i = 0; i<2; i++) {
        NSIndexPath  *indexPath2 = [NSIndexPath indexPathForRow:i inSection:2];
        NSIndexPath  *indexPath3 = [NSIndexPath indexPathForRow:i inSection:3];
        NSIndexPath  *indexPath4 = [NSIndexPath indexPathForRow:i  inSection:4];
        [self.textDic setObject:self.textDic[indexPath3] forKey:indexPath2];
        [self.textDic setObject:self.textDic[indexPath4] forKey:indexPath3];
    }
    
    [self.DetaileTableview reloadData];
  
}
//点击了完成
-(void)FinishedClick
{
//    [self updateData];
}

-(void)addUserHeaderIMG
{
    [self.datePicker remove];
    [self.view endEditing:YES];
    
    [HCAvatarMgr manager].isUploadImage = YES;
    [HCAvatarMgr manager].noUploadImage = NO;
    //上传个人头像
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg)
     {
         if (!result)
         {
             [self showHUDText:msg];
             [HCAvatarMgr manager].isUploadImage = NO;
             [HCAvatarMgr manager].noUploadImage = NO;
         }
         else
         {
             [[SDImageCache sharedImageCache] clearMemory];
             [[SDImageCache sharedImageCache] clearDisk];
             [self.tableView reloadData];
         }
     }];
}

#pragma mark ---Setter  Or Getter

-(NSMutableArray *)BigDetailTitleArr
{
    if (!_BigDetailTitleArr)
    {
         _BigDetailTitleArr = [NSMutableArray array];
        //基本信息
        NSArray   *arrJiben = @[@"姓名",@"性别",@"年龄",@"住址",@"学校"];
        [_BigDetailTitleArr addObject:arrJiben];
        // 紧急联系人1
        NSArray   *arrLianxi = @[@"姓名",@"关系",@"手机号"];
        [_BigDetailTitleArr addObject:arrLianxi];
        // 走失信息
        NSArray  *arrZoushi = @[@"地点",@"描述"];
        [_BigDetailTitleArr addObject:arrZoushi];
        // 医疗救助信息
        NSArray  *arrYiLiao =  @[@"血型",@"过敏史",@""];
        [_BigDetailTitleArr addObject:arrYiLiao];
       
    }
    return _BigDetailTitleArr;
}
// 组头标题
-(NSMutableArray *)BigTitleArr
{
    if (!_BigTitleArr)
    {
        NSArray   *arrTitile = @[@"基本信息",@"紧急联系人",@"走失信息",@"医疗救助信息"];
        _BigTitleArr = [NSMutableArray arrayWithArray:arrTitile];
    }
    return _BigTitleArr;
}

-(NSMutableArray *)BigDetailDetailArr
{
    if (!_BigDetailDetailArr)
    {
        if (_isEdit) {
            _BigDetailDetailArr = [NSMutableArray array];
            // 基本信息的detail数组
            NSArray  *arrJiibenDetail = @[@"点击输入走失者真实姓名",@"X",@"XXXX-XX-XX",@"点击输入走失者的学校",@"点击输入走失者学校名称"];
            [_BigDetailDetailArr addObject:arrJiibenDetail];
            // 紧急联系人 detail 数组
            NSArray  *arrJinjiDetail = @[@"点击输入紧急联系人真实姓名",@"输入紧急联系人与走失者联系，如父子",@"点击输入紧急联系人的手机号码"];
            [_BigDetailDetailArr addObject:arrJinjiDetail];
            // 走失信息 detaile数组
            NSArray *arrZoushiDetail = @[@"点击输入走失地点",@"点击输入走失时的一些特点，比如：相貌特征，身高，所传衣物"];
            [_BigDetailDetailArr addObject:arrZoushiDetail];
            // 医疗救助detail 数组
            NSArray  *arrYiLiaoDetail = @[@"点击输入走失者的血型",@"如果走时者有药物过敏历史,点击输入过敏药物名称",@""];
            [_BigDetailDetailArr addObject:arrYiLiaoDetail];
        }
        else
        {
          
            _BigDetailDetailArr = [NSMutableArray array];
        }
    }

    return _BigDetailDetailArr;
}

-(UITableView *)DetaileTableview
{
    if (!_DetaileTableview) {
        
        CGRect  frame = CGRectMake(0, 64,SCREEN_WIDTH , SCREEN_HEIGHT-64);
        _DetaileTableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _DetaileTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _DetaileTableview.delegate = self;
        _DetaileTableview.dataSource = self;
        _DetaileTableview.showsVerticalScrollIndicator = NO;
    }
    return _DetaileTableview;
}

-(HCPromisedDetailInfo *)promisedDetailInfo
{
    if (!_promisedDetailInfo) {
        _promisedDetailInfo  = [[HCPromisedDetailInfo alloc]init];
    }
     return _promisedDetailInfo;
}



- (NSMutableDictionary *)textDic
{
    if(!_textDic){
        _textDic = [[NSMutableDictionary alloc]init];
    }
    return _textDic;
}


- (NSMutableArray *)TextViewCells
{
    if(!_TextViewCells){
        _TextViewCells = [[NSMutableArray alloc]init];
    }
    return _TextViewCells;
}


#pragma mark --- network

-(void)updateData
{
    HCPromisedAddCallMessageAPI  *api = [[HCPromisedAddCallMessageAPI alloc]init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            NSLog(@"%@",responseObject);
        }
        
    }];
}

-(void)requestCallDetailData
{
    NSArray  *arrJiibenDetail = @[@"小明",@"男",@"1992-11-08",@"集心路",@"汪家小学"];
    [self.BigDetailDetailArr addObject:arrJiibenDetail];
    // 紧急联系人 detail 数组
    NSArray  *arrJinjiDetail = @[@"张三",@"父子",@"1111"];
    [self.BigDetailDetailArr addObject:arrJinjiDetail];
    [self.BigDetailDetailArr addObject:arrJinjiDetail];
    // 走失信息 detaile数组
    NSArray *arrZoushiDetail = @[@"集心路",@"…………………………"];
    [self.BigDetailDetailArr addObject:arrZoushiDetail];
    // 医疗救助detail 数组
    NSArray  *arrYiLiaoDetail = @[@"AB",@"没有",@""];
    [self.BigDetailDetailArr addObject:arrYiLiaoDetail];
    
    if (self.BigDetailDetailArr.count == 5) {
        _isFive = YES;
       [self.BigDetailTitleArr insertObject:@[@"姓名",@"关系",@"手机号"] atIndex:1];
       [self.BigTitleArr insertObject:@"紧急联系人" atIndex:1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     [self setupBackItem];
}


@end

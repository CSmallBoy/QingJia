//
//  HCGradeManagerViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//
#import "HCDeleteFamilyMember.h"
#import "HCEditFamilyApi.h"
#import "HCCreateAllFamily.h"
#import "GetAllFamily.h"
#import "HCDeleteMember.h"
#import "AddFamilyMemberViewController.h"
#import "HCGradeManagerViewController.h"
#import "HCCodeLookViewController.h"
#import "HCCheckViewController.h"
#import "HCGradeManagerTableViewCell.h"
#import "HCFriendMessageInfo.h"
#import "HCAddFriendViewController.h"
#import "UIImageView+WebCache.h"
#import "HCFriendMessageApi.h"
#import "HCCreateGradeInfo.h"
#import "sigleFamilyMessage.h"
//个人 家庭 头像
#import "HCHomeUserPhotoViewController.h"
//修改家庭的api
#import "NHCEditingFamilyApi.h"
//家庭的图片
#import "NHCGetFamilyImageApi.h"
//家庭的编辑图片修改
#import "NHCEditingFamilyImageApi.h"
//家庭成员查看
#import "HCFamilyUserInfoViewController.h"


static NSString * const reuseIdentifier = @"FriendCell";

@interface HCGradeManagerViewController ()<HCGradeManagerTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    BOOL isTure;
    BOOL isEditing;
    UIImagePickerController *_myPK;
    UIImagePickerController *_picker;
    UIImage *choose;
    
    BOOL isOpen;
    
    NSMutableArray *AllFamilyArr;
    
    UIImageView *list_isOpen;
    
    UILabel *section_label;
    
    
    NSInteger  kSection;
    
    BOOL isDelete; //是否处于删除状态
    BOOL is_Editing;
    
    UITextField *familtNickName_tf;
    UITextField *familyDescription_tf;
    UIButton* backButton;
}

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic,strong) HCCreateGradeInfo *info;
@property (nonatomic, strong) HCCreateAllFamily *familyInfo;
@property (nonatomic, strong)NSMutableArray<NSNumber *> *isExpland;//是否展开

@end

@implementation HCGradeManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AllFamilyArr = [[NSMutableArray alloc]init];
    if (!self.isExpland) {
        self.isExpland = [NSMutableArray array];
    }
    isOpen = NO;
    isDelete = NO;
    is_Editing = NO;
    kSection = 0;
    
    
    
    //自定义编辑按钮
    CGRect backframe = CGRectMake(SCREEN_WIDTH - 100,0,54,30);
    backButton= [[UIButton alloc] initWithFrame:backframe];
    //[backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setTitle:@"编辑" forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [backButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = leftBarButtonItem;
    
    
    //家庭名称
    NSString *familyName = [[NSUserDefaults standardUserDefaults]objectForKey:@"familyName"];
    self.title = @"家庭信息";
    [self setupBackItem];
    self.tableView.tableHeaderView = self.headImageView;
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    //长按手势
    //    UILongPressGestureRecognizer *long_press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
    self.headImageView.userInteractionEnabled = YES;
    //[self.headImageView addGestureRecognizer:long_press];
    [self.headImageView addGestureRecognizer:tap];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self requestGradeManager];
    
    [self requeatAllFamily];
    self.navigationController.navigationBar.hidden = NO;
    
}
//编辑完成
-(void)finish
{
    if ([backButton.titleLabel.text isEqualToString:@"完成"]) {
        
        familtNickName_tf.enabled = NO;
        familyDescription_tf.enabled = NO;
        [backButton setTitle:@"编辑" forState:UIControlStateNormal];
        HCEditFamilyApi *api = [[HCEditFamilyApi alloc]init];
        api.familyId = [HCAccountMgr manager].loginInfo.createFamilyId;
        api.familyNickName = familtNickName_tf.text;
        api.familyDescription = familyDescription_tf.text;
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
            
            NSLog(@"%@",respone);
            [[NSUserDefaults standardUserDefaults]setObject:familtNickName_tf.text forKey:@"familyName"];
            self.title = familtNickName_tf.text;
        }];
    }
    else
    {
        
        [backButton setTitle:@"完成" forState:UIControlStateNormal];
        familtNickName_tf.enabled = YES;
        familyDescription_tf.enabled = YES;
        
        
    }
    
    
}


//添加成员
-(void)addMember
{
    [self.navigationController pushViewController:[AddFamilyMemberViewController new] animated:YES];
}


//删除成员
-(void)deleteMember
{
    
    
    if (isDelete == NO) {
        
        for (int i =0; i< self.dataSource.count; i++) {
            
            UIButton *view = (UIButton*)[self.view viewWithTag:12315 +i];
            // view.backgroundColor = [UIColor redColor];
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"add-members-1"];
            imageView.tag = 10121 +i;
            [view addSubview:imageView];
            
        }
        isDelete = YES;
    }
    else
    {
        //        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        //
        //        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        for (int i =0; i< self.dataSource.count; i++) {
            
            UIImageView *view = (UIImageView *)[self.view viewWithTag:10121 +i];
            [view removeFromSuperview];
            
        }
        
        isDelete = NO;
    }
    
    
    
    NSLog(@"点了删除成员");
    //    HCDeleteMember *api =[[HCDeleteMember alloc]init];
    //    api.memberUserId = @"";
    //    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
    //
    //        NSLog(@"%@",data);
    //    }];
}
#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCGradeManagerTableViewCell *cell = [[HCGradeManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.array = self.dataSource;
    
    cell.info = _info;
    cell.indexPath = indexPath;
    cell.textField.delegate = self;
    
    if (indexPath.section ==0) {
        
        if (indexPath.row == 0) {
            
            familtNickName_tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100, 44)];
            familtNickName_tf.enabled = NO;
            [cell.contentView addSubview:familtNickName_tf];
            cell.textLabel.text = @"家庭昵称";
            familtNickName_tf.text = _info.familyNickName;
            cell.textLabel.textColor = DarkGrayColor;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        
        else if (indexPath.row == 2)
        {
            familyDescription_tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100, 44)];
            familyDescription_tf.enabled = NO;
            [cell.contentView addSubview:familyDescription_tf];
            cell.textLabel.text = @"个性签名";
            familyDescription_tf.text = _info.familyDescription;
            cell.textLabel.textColor = DarkGrayColor;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        scrollView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:scrollView];
        
        for (int i = 0; i< self.dataSource.count +2 ; i++) {
            
            NSLog(@"--------%@",self.dataSource);
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake( i * 100, 0, 100, 100);
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            btn.tag = 12315+i;
            [scrollView addSubview:btn];
            
            
            if (self.dataSource.count ==0) {
                
                scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 100);
                
            }
            
            else
            {
                scrollView.contentSize = CGSizeMake((self.dataSource.count +2) * 100, 100);
            }
            
            
            UIImageView *headImage = [[UIImageView alloc]init];
            headImage.frame = CGRectMake(i * 100, 0, SCREEN_WIDTH*0.17, SCREEN_WIDTH*0.17);
            headImage.center = CGPointMake(btn.center.x, 40);
            headImage.layer.cornerRadius = WIDTH(headImage)/2;
            headImage.image = [UIImage imageNamed:@"1"];
            [headImage.layer masksToBounds];
            // [ima sd_setImageWithURL:[readUserInfo url:info.imageName :kkUser]];
            
            ViewRadius(headImage, WIDTH(headImage)/2);
            [scrollView addSubview:headImage];
            
            UILabel *name = [[UILabel alloc]init];
            name.frame = CGRectMake(i * 100, MaxY(headImage) + 10, 100, 10);
            
            name.textAlignment = NSTextAlignmentCenter;
            [scrollView addSubview:name];
            name.font = [UIFont systemFontOfSize:13];
            list_isOpen.image = [UIImage imageNamed:@"list_open"];
            
            HCFriendMessageInfo *info;
            if (self.dataSource.count >0 && i < self.dataSource.count) {
                
                
                info = self.dataSource[i];
                NSString *url = [NSString stringWithFormat:@"%@",info.imageName];
                
                // NSLog(@"%@",url);
                // [headImage sd_setImageWithURL:[NSURL URLWithString:url]];
                [headImage sd_setImageWithURL:[readUserInfo url:url :kkUser]];
                name.text = info.nickName;
                
                //[btn addTarget: self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
                [btn addTarget:self action:@selector(headPress:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            
            if (i == self.dataSource.count) {
                
                headImage.image = [UIImage imageNamed:@"add-members"];
                name.text = @"添加成员";
                
                [btn addTarget:self action:@selector(addMember) forControlEvents:UIControlEventTouchUpInside];
                
            }
            else if (i == self.dataSource.count +1)
            {
                headImage.image = [UIImage imageNamed:@"add-members-1"];
                name.text = @"删除成员";
                
                [btn addTarget:self action:@selector(deleteMember) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
    }
    
    if ((indexPath.section >= 2) && indexPath.row == 0) {
        
        //  cell.textLabel.text = @"快乐家庭";
        list_isOpen =[[UIImageView alloc]init];
        list_isOpen.frame = CGRectMake(10, 0, 12, 12);
        list_isOpen.image = [UIImage imageNamed:@"list_close"];
        list_isOpen.center = CGPointMake(list_isOpen.center.x, 20);
        [cell.contentView addSubview:list_isOpen];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        section_label = [[UILabel alloc]init];
        section_label.frame = CGRectMake(30, 0, 200, 40);
        //section_label.text = @"快乐家庭";
        section_label.textColor = [UIColor blackColor];
        section_label.font = [UIFont systemFontOfSize:15];
        HCCreateAllFamily *info = AllFamilyArr[indexPath.section - 2];
        section_label.text = info.familyNickName;
        [cell.contentView addSubview:section_label];
        
        
    }
    else if (indexPath.section >= 2 && indexPath.row == 1)
    {
        // cell.backgroundColor = [UIColor yellowColor];
        NSArray *memberarr;
        if (AllFamilyArr.count !=0) {
            HCCreateAllFamily *info = AllFamilyArr[indexPath.section - 2];
            section_label.text = info.familyNickName;
            memberarr = info.members;
            
            if (isOpen == YES) {
                UIScrollView *scrollView = [[UIScrollView alloc]init];
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
                scrollView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:scrollView];
                
                for (int i = 0; i< memberarr.count; i++) {
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake( i * 100, 0, 100, 100);
                    [scrollView addSubview:btn];
                    [btn addTarget: self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
                    btn.tag = 666 + i;
                    
                    scrollView.contentSize = CGSizeMake(10000, 100);
                    
                    UIImageView *headImage = [[UIImageView alloc]init];
                    headImage.frame = CGRectMake(i * 100, 0, SCREEN_WIDTH*0.17, SCREEN_WIDTH*0.17);
                    headImage.center = CGPointMake(btn.center.x, 40);
                    headImage.layer.cornerRadius = WIDTH(headImage)/2;
                    headImage.image = [UIImage imageNamed:@"1"];
                    [headImage.layer masksToBounds];
                    // [ima sd_setImageWithURL:[readUserInfo url:info.imageName :kkUser]];
                    NSString *url = [NSString stringWithFormat:@"%@",[memberarr[i] objectForKey:@"imageName"]];
                    
                    NSLog(@"%@",url);
                    // [headImage sd_setImageWithURL:[NSURL URLWithString:url]];
                    [headImage sd_setImageWithURL:[readUserInfo url:url :kkUser]];
                    ViewRadius(headImage, WIDTH(headImage)/2);
                    [scrollView addSubview:headImage];
                    
                    UILabel *name = [[UILabel alloc]init];
                    name.frame = CGRectMake(i * 100, MaxY(headImage) + 10, 100, 10);
                    name.text = [memberarr[i] objectForKey:@"nickName"]    ;
                    name.textAlignment = NSTextAlignmentCenter;
                    [scrollView addSubview:name];
                    name.font = [UIFont systemFontOfSize:13];
                    list_isOpen.image = [UIImage imageNamed:@"list_open"];
                }
                
            }
            else if (![self.isExpland[indexPath.section] isEqual:@0])
            {
                UIScrollView *scrollView = [[UIScrollView alloc]init];
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
                scrollView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:scrollView];
                
                for (int i = 0; i< memberarr.count; i++) {
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake( i * 100, 0, 100, 100);
                    [scrollView addSubview:btn];
                    btn.tag = 666 + (indexPath.section * indexPath.row +1);
                    [btn addTarget: self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
                    scrollView.contentSize = CGSizeMake(10000, 100);
                    
                    UIImageView *headImage = [[UIImageView alloc]init];
                    headImage.frame = CGRectMake(i * 100, 0, SCREEN_WIDTH*0.17, SCREEN_WIDTH*0.17);
                    headImage.center = CGPointMake(btn.center.x, 40);
                    headImage.layer.cornerRadius = WIDTH(headImage)/2;
                    headImage.image = [UIImage imageNamed:@"1"];
                    [headImage.layer masksToBounds];
                    // [ima sd_setImageWithURL:[readUserInfo url:info.imageName :kkUser]];
                    NSString *url = [NSString stringWithFormat:@"%@",[memberarr[i] objectForKey:@"imageName"]];
                    
                    NSLog(@"%@",url);
                    // [headImage sd_setImageWithURL:[NSURL URLWithString:url]];
                    [headImage sd_setImageWithURL:[readUserInfo url:url :kkUser]];
                    ViewRadius(headImage, WIDTH(headImage)/2);
                    [scrollView addSubview:headImage];
                    
                    UILabel *name = [[UILabel alloc]init];
                    name.frame = CGRectMake(i * 100, MaxY(headImage) + 10, 100, 10);
                    name.text = [memberarr[i] objectForKey:@"nickName"]    ;
                    name.textAlignment = NSTextAlignmentCenter;
                    [scrollView addSubview:name];
                    name.font = [UIFont systemFontOfSize:13];
                    list_isOpen.image = [UIImage imageNamed:@"list_open"];
                }
                
            }
            
        }
        
        
        else if (indexPath.section >2 && indexPath.row == 1)
        {
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(10, 10, 100, 100);
            btn.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:btn];
            
            
        }
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCViewController *vc = nil;
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        vc = [[HCCodeLookViewController alloc] init];
        NSURL *url = [readUserInfo originUrl:self.info.imageName :kkFamail];
        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        if (image == nil) {
            
            image = IMG(@"head.jpg");
        }
        vc.data = @{@"info":self.info,@"image":image};
        vc.Fam_image = self.headImageView.image;
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        vc = [[HCCheckViewController alloc] init];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"audit_num" object:nil];
    }
    
    else if(indexPath. section == 2)
    {
        NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
        NSLog(@"点击的第%@行",str);
        
        isDelete = NO;
        if(indexPath.row ==0)
        {
            //newHeight是展开的高度
            if (isOpen == YES) {
                
                isOpen = NO;
            }
            else
            {
                
                isOpen = YES;
            }
            
            //刷新当前被点击的行
            //            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView reloadData];
        }
    }
    else if (indexPath.section > 2)
    {
        isDelete = NO;
        if (kSection > 2) {
            
            kSection = 0;
        }
        else
        {
            kSection = indexPath.section;
            
        }
        self.isExpland[indexPath.section] = [self.isExpland[indexPath.section] isEqual:@0]?@1:@0;
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
        
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return AllFamilyArr.count +2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return (section) ? 2 : 3;
    
    if (section == 0) {
        return 3;
    }
    else if (section == 1)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 2;
    }
    else if (section > 2)
    {
        
        //        NSLog(@"%@",self.isExpland);
        //        return 2;
        if ([self.isExpland[section] boolValue]) {
            
            return 2;
        }
        else {
            
            return 1;
            
        }
        
    }
    else
    {
        return 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section && indexPath.row && indexPath.section < 2)
    {
        NSInteger row = self.dataSource.count/4;
        if (self.dataSource.count%4)
        {
            row++;
        }
        return row*(WIDTH(self.view)*0.2+30);
        
    }
    else if (indexPath.section == 2)
    {
        
        if(isOpen== YES && indexPath.row == 1)
            
        {
            return 100;
        }
        else if (isOpen == NO   && indexPath.row ==1)
            
        {
            return 0;
        }
        else
        {
            return 40;
        }
    }
    
    else if (indexPath.section > 2 && indexPath.row ==1)
    {
        return 100;
        
    }
    
    
    else
    {
        return 44;
    }
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    isTure = YES;
    NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell*)textField.superview.superview];
    if (index.section==0) {
        switch (index.row) {
            case 1:
                _nickName = textField.text;
                break;
            case 2:
                _miaoshu = textField.text;
                break;
                
            default:
                break;
        }
    }
    
}
#pragma mark - HCGradeManagerTableViewCellDelegate

- (void)HCGradeManagerTableViewCellSelectedTag:(NSInteger)tag
{
    if (tag == self.dataSource.count)
    {
        DLog(@"添加了添加按钮");
        [self.navigationController pushViewController:[AddFamilyMemberViewController new] animated:YES];
    }
    else if (tag == self.dataSource.count +1)
    {
        NSLog(@"删除按钮");
    }
    else
    {
        HCFriendMessageInfo *info = self.dataSource[tag];
        DLog(@"点击了某个人---%@", info.nickName);
        HCFamilyUserInfoViewController *vc = [[HCFamilyUserInfoViewController alloc]init];
        vc.info = info;
        vc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - private methods


#pragma mark - setter or getter

- (UIImageView *)headImageView
{
    if (!_headImageView)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), WIDTH(self.view)*0.5)];
        [_headImageView addSubview:self.signatureLabel];
    }
    return _headImageView;
}

//去掉签名
- (UILabel *)signatureLabel
{
    if (!_signatureLabel)
    {
        _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT(self.headImageView)-30, WIDTH(self.view), 30)];
        _signatureLabel.textAlignment = NSTextAlignmentCenter;
        _signatureLabel.font = [UIFont systemFontOfSize:15];
        _signatureLabel.numberOfLines = 0;
        _signatureLabel.text = @"我们的家庭签名~！";
        _signatureLabel.textColor = [UIColor whiteColor];
    }
    return nil;
}

#pragma mark - network

- (void)requestGradeManager
{
    
    sigleFamilyMessage *api = [[sigleFamilyMessage alloc]init];
    api.familyId = [HCAccountMgr manager].loginInfo.createFamilyId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSDictionary *dic = respone[@"Data"][@"FamilyInf"];
            self.info = [HCCreateGradeInfo  mj_objectWithKeyValues:dic];
            //相当于个性签名   这个有问题  一会在解决
            if (isTure) {
                
            }else{
                _miaoshu=  self.info.ancestralHome;
                _nickName= self.info.familyNickName;
                _PhotoName= self.info.familyPhoto;
            }
            _creatFamilyID = [HCAccountMgr manager].loginInfo.createFamilyId;
        }
        NSArray *array = respone[@"Data"][@"row"];
        [self.dataSource removeAllObjects];
        for (NSDictionary *dic in array)
        {
            HCFriendMessageInfo *friendInfo = [[HCFriendMessageInfo alloc]init];
            friendInfo.userId = dic[@"userId"];
            friendInfo.nickName = dic[@"nickName"];
            friendInfo.imageName = dic[@"imageName"];
            [self.dataSource addObject:friendInfo];
        }
        self.signatureLabel.text = self.info.familyDescription;
        [self.tableView reloadData];
        NSURL *url = [readUserInfo originUrl:self.info.imageName :kkFamail];
        if (isEditing) {
            self.headImageView.image = choose;
        }else{
            [self.headImageView sd_setImageWithURL:url placeholderImage:IMG(@"head.jpg")];
            NHCGetFamilyImageApi *Api = [[NHCGetFamilyImageApi alloc]init];
            [Api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
                NSString *str = responseObject[@"Data"][@"imageName"];
                NSURL *url = [readUserInfo originUrl:str:kkFamail];
                [self.headImageView sd_setImageWithURL:url placeholderImage:IMG(@"1")];
                
            }];
        }
        self.headImageView.clipsToBounds = YES;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
}

-(void)requeatAllFamily
{
    GetAllFamily *api = [[GetAllFamily alloc]init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        NSLog(@"requestStatus : %ld ----- message: %@ ------- respone:%@",(long)requestStatus,message,respone);
        
        if (requestStatus == HCRequestStatusSuccess) {
            
            NSArray *array = respone[@"Data"][@"rows"];
            [AllFamilyArr removeAllObjects];
            for (NSDictionary *dic in array)
            {
                HCCreateAllFamily *familyInfo = [[HCCreateAllFamily alloc]init];
                familyInfo.familyId = dic[@"familyId"];
                familyInfo.isCreator = dic[@"isCreator"];
                familyInfo.ancestralHome = dic[@"ancestralHome"];
                familyInfo.familyNickName = dic[@"familyNickName"];
                familyInfo.familyDescription = dic[@"familyDescription"];
                familyInfo.contactAddr = dic[@"contactAddr"];
                familyInfo.memberCount = dic[@"memberCount"];
                familyInfo.members = dic[@"members"];
                [AllFamilyArr addObject:familyInfo];
                
            }
            
            for (int i = 0; i < AllFamilyArr.count +2; i++) {
                
                [self.isExpland addObject:@0];
                
            }
            [self.tableView reloadData];
            
        }
    }];
    
}
- (void)tapGesture:(UIGestureRecognizer*)recognizer{
    //弹框选择家庭照片
    if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        UIAlertController *myalert =[UIAlertController alertControllerWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *xiangce = [UIAlertAction actionWithTitle:@"从相册里选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            _myPK = [[UIImagePickerController alloc]init];
            _myPK.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //是否允许编辑图片
            _myPK.allowsEditing = YES;
            _myPK.delegate = self;
            [self presentViewController:_myPK animated:YES completion:nil];
        }];
        UIAlertAction *paizhao = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //打开相机
            _picker = [[UIImagePickerController alloc]init];
            _picker.delegate = self;
            _picker.allowsEditing = YES;
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_picker animated:YES completion:nil];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [myalert addAction:xiangce];
        [myalert addAction:paizhao];
        [myalert addAction:cancel];
        [self presentViewController:myalert animated:YES completion:nil];
    }else{
        //        HCHomeUserPhotoViewController *VC = [[HCHomeUserPhotoViewController alloc]init];
        //        VC.head_image = self.headImageView.image;
        //        VC.from = @"家庭";
        //        [self.navigationController pushViewController:VC animated:YES];
        
        UIAlertController *myalert =[UIAlertController alertControllerWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *xiangce = [UIAlertAction actionWithTitle:@"从相册里选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            _myPK = [[UIImagePickerController alloc]init];
            _myPK.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //是否允许编辑图片
            _myPK.allowsEditing = YES;
            _myPK.delegate = self;
            [self presentViewController:_myPK animated:YES completion:nil];
        }];
        UIAlertAction *paizhao = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //打开相机
            _picker = [[UIImagePickerController alloc]init];
            _picker.delegate = self;
            _picker.allowsEditing = YES;
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_picker animated:YES completion:nil];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [myalert addAction:xiangce];
        [myalert addAction:paizhao];
        [myalert addAction:cancel];
        [self presentViewController:myalert animated:YES completion:nil];
    }
    //个人 家庭 头像
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    isEditing = YES;
    if (picker==_myPK)
    {
        choose = [info objectForKey:UIImagePickerControllerEditedImage];
        [_myPK dismissViewControllerAnimated:YES completion:nil];
    }else{
        choose = [info objectForKey:UIImagePickerControllerEditedImage];
        [_picker dismissViewControllerAnimated:YES completion:nil];
    }
    [self.tableView reloadData];
    //选择完即上传
    [KLHttpTool uploadImageWithUrl:[readUserInfo url:kkFamail] image:choose success:^(id responseObject) {
        _PhotoName = responseObject[@"Data"][@"files"][0];
        NSDictionary *dict = @{@"photo":_PhotoName};
        NHCEditingFamilyImageApi *api = [[NHCEditingFamilyImageApi alloc]init];
        api.Fmaily_photo = dict[@"photo"];
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            if (requestStatus == HCRequestStatusSuccess) {
                [self showHUDSuccess:@"您已经成功修改了家庭图片"];
            }
        }];
        //
        [[NSNotificationCenter defaultCenter] postNotificationName:@"修改家庭图片" object:nil userInfo:dict];
        NHCEditingFamilyApi *API = [[NHCEditingFamilyApi alloc]init];
        //上传修修改的编辑信息
        API.familyNickName = _nickName;
        API.familyId = _creatFamilyID;
        //祖籍改成签名
        API.ancestralHome = _miaoshu;
        //没有imagename了
        API.imageName = _PhotoName;
        API.contactAddr = self.info.contactAddr;
        [API startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            
        }];
    } failure:^(NSError *error) {
        [self showHUDError:@"图片上传失败"];
    }];
    
}

//点击头像
-(void)clickHead:(UIButton *)btn
{
    
    UITableViewCell *cell = (UITableViewCell *)btn.superview.superview.superview;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"%d---------%d",indexPath.row,indexPath.section);
    NSLog(@"%@",AllFamilyArr);
    
    NSArray *members = [[NSArray alloc]init];
    if (indexPath.section >=2) {
        HCCreateAllFamily *allFamily = AllFamilyArr[indexPath.section - 2];
        members = allFamily.members;
        
    }
    
    HCFamilyUserInfoViewController *vc = [[HCFamilyUserInfoViewController alloc]init];
    vc.memberId = [members[btn.tag - 666] objectForKey:@"userId"];
    
    // vc.info = info;
    vc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)headPress:(UIButton *)btn
{
//    if (isDelete == NO) {
//        
//        NSLog(@"%@",self.dataSource);
//        
//        HCFriendMessageInfo *info=self.dataSource[btn.tag - 12315];
//        HCFamilyUserInfoViewController *vc = [[HCFamilyUserInfoViewController alloc]init];
//        // vc.info = info;
//        vc.memberId = info.userId;
//        vc.hidesBottomBarWhenPushed  = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else
//    {
//        [self showHint:@"删除好友"];
//        
//        HCFriendMessageInfo *info=self.dataSource[btn.tag - 12315];
//        HCDeleteFamilyMember *delete = [[HCDeleteFamilyMember alloc]init];
//        delete.memberId = info.userId;
//        [delete startRequest:^(HCRequestStatus requestStatus, NSString *message, id response) {
//            
//            NSLog(@"%@",response);
//            if (requestStatus == HCRequestStatusSuccess) {
//                
//                [self showHint:@"删除成功"];
//                [self.tableView reloadData];
//            }
//            else
//            {
//                [self showHint:@"对不起,你没有这个权限"];
//            }
//        }];
//        
//    }
    
}

@end

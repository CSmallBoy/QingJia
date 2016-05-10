//
//  HCLeftGradeView.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCLeftGradeView.h"
#import "UIButton+WebCache.h"
#import "MyFamilyViewController.h"
#import "HCCreateGradeViewController.h"

#import "NHCDownloadImageApi.h"

#import "findFamilyMessage.h"
#import "FamilyDownLoadImage.h"

#import "HCCreateGradeInfo.h"

//下载头像
#import "NHCDownloadImageApi.h"
@interface HCLeftGradeView(){
    NSDictionary *dicting;
}

@property (nonatomic, strong) UIButton *sofewareSetBtn;
@property (nonatomic, strong) UIImageView *setImgView;
@property (nonatomic, strong) UIImageView *setImgView2;
@property (nonatomic,strong)  UIView *smallView;
@property (nonatomic,strong)  UIButton *joinFamilyBtn;

@property (nonatomic,strong) HCCreateGradeInfo *info;

@end

@implementation HCLeftGradeView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserPhoto:) name:@"changeUserPhoto" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserPhoto2:) name:@"修改家庭图片" object:nil];
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = RGB(34, 35, 37);
        [self addSubview:self.gradeHeadButton];
        [self addSubview:self.gradeName];
        [self addSubview:self.headButton];
        [self addSubview:self.nickName];
        [self addSubview:self.sofewareSetBtn];
        [self addSubview:self.familyButton];
        
        //家庭
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestFamilyMessage) name:@"showFamilyMessage" object:nil];
        
        NSString *str = [HCAccountMgr manager].loginInfo.createFamilyId;
        NSString *frist_str = [str substringToIndex:1];
        NSDictionary *dic = [readUserInfo getFaimilyDic];
        NSString *strFamilyId = [readUserInfo getFaimilyDic][@"familyId"];
        NSString *frist_FamilyId = [str substringToIndex:1];
        
        if ((IsEmpty(str) || [str isKindOfClass:[NSNull class]])&& IsEmpty(strFamilyId))
        {
            // 显示没有创建家庭的侧边 （gradeHeadButton 显示用户头像）
            
            self.gradeName.text =[HCAccountMgr manager].loginInfo.TrueName;
            self.nickName.hidden = YES;
            self.familyButton.hidden = NO;
            self.headButton.hidden = YES;
            [self addSubview:self.smallView];
            
            self.gradeHeadButton.frame = CGRectMake(WIDTH(self)*0.2, 60, WIDTH(self)*0.3, WIDTH(self)*0.3);
            ViewRadius(self.gradeHeadButton,WIDTH(self)*0.3/2);
            
            NSDictionary *dict = [readUserInfo getReadDic];
            NSString *imgStr = dict[@"imageName"];
            NSString *imgStrLogin = dict[@"UserInf"][@"imageName"];
            if (IsEmpty(imgStr) && IsEmpty(imgStrLogin)&&IsEmpty(dict[@"PhotoStr"])) {
                
                [_gradeHeadButton setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
                
            }else{
                
                if (!IsEmpty(imgStr)) {
                    NSURL *url = [readUserInfo originUrl:imgStr :kkUser];
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                    [_gradeHeadButton setBackgroundImage:image forState:UIControlStateNormal];
                }
                else if (!IsEmpty(dict[@"PhotoStr"]))
                {
                    NSURL *url = [readUserInfo originUrl:dict[@"PhotoStr"] :kkUser];
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                    [_gradeHeadButton  setBackgroundImage:image forState:UIControlStateNormal];
                }
                else
                {
                    NSURL *url = [readUserInfo originUrl:imgStrLogin :kkUser];
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                    [_gradeHeadButton setBackgroundImage:image forState:UIControlStateNormal];
                    
                }
            }
        }
        else
        {
            if ([frist_str isEqualToString:@"F"]||[frist_FamilyId isEqualToString:@"F"])
            {
                // 显示创建过家庭的侧边
                [self requestFamilyMessage];
                //[self addSubview:self.joinFamilyBtn];
            }
            else
            {
                // 显示没有创建家庭的侧边
                self.gradeName.text =[HCAccountMgr manager].loginInfo.NickName;
                self.nickName.hidden = YES;
                self.familyButton.hidden = YES;
                self.headButton.hidden = YES;
                [self addSubview:self.smallView];
                
                
                NSDictionary *dict = [readUserInfo getReadDic];
                
                self.gradeHeadButton.frame = CGRectMake(WIDTH(self)*0.2, 60, WIDTH(self)*0.3, WIDTH(self)*0.3);
                ViewRadius(self.gradeHeadButton, WIDTH(self)*0.3/2);
                
                if (dict[@"PhotoStr"]==nil) {
                    //没有图片的时候显示的默认头像
                    [_gradeHeadButton  setBackgroundImage:IMG(@"1") forState:UIControlStateNormal];
                }else{
                    
                    NSURL *url =[readUserInfo url:dict[@"PhotoStr"] :kkUser];
                    UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
                    
                    [_gradeHeadButton setBackgroundImage:image forState:UIControlStateNormal];
                }
            }
        }
    }
    return self;
}

#pragma mark - private methods
- (void)changeUserPhoto2:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    UIImage*image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[readUserInfo url:dic[@"photo"] :kkFamail]]];
    [self.gradeHeadButton setBackgroundImage:image forState:UIControlStateNormal];
}
// 改变用户头像
-(void)changeUserPhoto:(NSNotification *)noti
{
    NSString *str = [HCAccountMgr manager].loginInfo.createFamilyId;
    NSString *strFamilyId = [readUserInfo getFaimilyDic][@"familyId"];
    NSString *frist_str = [str substringToIndex:1];
    NSDictionary *dic = noti.userInfo;
    UIImage*image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[readUserInfo url:dic[@"photo"] :kkUser]]];
    if ((IsEmpty(str) || [str isKindOfClass:[NSURL class]])&& IsEmpty(strFamilyId))
    {
        
        [self.gradeHeadButton setBackgroundImage:image forState:UIControlStateNormal];
        
    }else
    {
        if ([frist_str isEqualToString:@"F"])
        {
            [self.headButton setBackgroundImage: image forState:UIControlStateNormal];
        }
        else
        {
            [self.gradeHeadButton setBackgroundImage: image forState:UIControlStateNormal];
        }
        
    }
    
}
//家庭
-(void)requestFamilyMessage
{
    findFamilyMessage *api = [[findFamilyMessage alloc]init];
    FamilyDownLoadImage *downLoadApi = [[FamilyDownLoadImage alloc]init];
    NSString *str =[readUserInfo getFaimilyDic][@"familyId"];
    
    
    if (IsEmpty(str)) {
        api.familyId =[HCAccountMgr manager].loginInfo.createFamilyId;
        downLoadApi.familyId = [HCAccountMgr manager].loginInfo.createFamilyId;
    }
    else
    {
        api.familyId = str;
        downLoadApi.familyId = str;
    }
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            NSDictionary *dic = respone[@"Data"][@"FamilyInf"];
            
            _info = [HCCreateGradeInfo mj_objectWithKeyValues:dic];
            [HCAccountMgr manager].familyInfo = _info;
            self.gradeName.text = _info.familyNickName;
            self.nickName.text = [HCAccountMgr manager].loginInfo.TrueName;
            
            self.nickName.hidden = NO;
            self.familyButton.hidden = NO;
            self.headButton.hidden = NO;
            
            self.smallView.hidden = YES;
            
            
            ViewRadius(_gradeHeadButton, 5);
            if ([HCAccountMgr manager].familyInfo.imageName==nil) {
                //没有图片的时候显示的默认头像
                [_gradeHeadButton  setBackgroundImage: IMG(@"1")forState:UIControlStateNormal];
            }else{
                
                NSURL *url = [readUserInfo url:[HCAccountMgr manager].familyInfo.imageName :kkFamail];
                UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
                [_gradeHeadButton setBackgroundImage:image forState:UIControlStateNormal];
                
            }
            
            NSDictionary *dict = [readUserInfo getReadDic];
            NSString *imgStr = dict[@"imageName"];
            NSString *imgStrLogin = dict[@"UserInf"][@"imageName"];
            if (IsEmpty(imgStr) && IsEmpty(imgStrLogin)&&IsEmpty(dict[@"PhotoStr"])) {
                
                [_headButton setBackgroundImage: IMG(@"Head-Portraits") forState:UIControlStateNormal];
                
            }else{
                
                if (!IsEmpty(imgStr)) {
                    NSURL *url = [readUserInfo originUrl:imgStr :kkUser];
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                    [_headButton setBackgroundImage:image forState:UIControlStateNormal];
                }
                else if (!IsEmpty(dict[@"PhotoStr"]))
                {
                    NSURL *url = [readUserInfo originUrl:dict[@"PhotoStr"] :kkUser];
                    
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                    [_headButton setBackgroundImage:image forState:UIControlStateNormal];
                }
                else
                {
                    NSURL *url = [readUserInfo originUrl:imgStrLogin :kkUser];
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                    [_headButton setBackgroundImage:image forState:UIControlStateNormal];
                    
                }
            }
        }
    }];
}

- (UIButton *)gradeHeadButton
{
    if (!_gradeHeadButton)
    {
        _gradeHeadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _gradeHeadButton.tag = HCLeftGradeViewButtonTypeGradeButton;
        _gradeHeadButton.frame = CGRectMake(30, 60, WIDTH(self)*0.7-60, WIDTH(self)*0.3);
        [_gradeHeadButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_gradeHeadButton, 5);
        [_gradeHeadButton setBackgroundImage:OrigIMG(@"publish_picture") forState:UIControlStateNormal];
    }
    return _gradeHeadButton;
}

- (UILabel *)gradeName
{
    if (!_gradeName)
    {
        _gradeName = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.gradeHeadButton)+20, WIDTH(self)*0.7, 20)];
        _gradeName.textAlignment = NSTextAlignmentCenter;
        _gradeName.textColor = [UIColor whiteColor];
    }
    return _gradeName;
}

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcleftGradeViewSelectedButtonType:)])
    {
        [self.delegate hcleftGradeViewSelectedButtonType:(HCLeftGradeViewButtonType)button.tag];
    }
}

#pragma mark - setter or getter

// 点击了创建家庭按钮
-(void)createFamily
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toCreateFamilyVC" object:nil];
    
}
//点击了加入家庭按钮
-(void)toJoinFamily
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toJoinFamilyVC" object:nil];
}

//我的家族
- (UIButton *)familyButton{
    if (!_familyButton) {
        _familyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //家族时间[_familyButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_familyButton addTarget:self action:@selector(toJoinFamily) forControlEvents:UIControlEventTouchUpInside];
        //[_familyButton setTitle:@"我的家族" forState:UIControlStateNormal];
        //加入家庭
        [_familyButton setTitle:@"加入家庭" forState:UIControlStateNormal];
        _familyButton.frame = CGRectMake(self.nickName.frame.origin.x+10, HEIGHT(self)-130+30, WIDTH(self)*0.7, 40);
        [_familyButton addSubview:self.setImgView2];
        _familyButton.tag = HCLeftGradeViewFamily;
    }
    return _familyButton;
}
//把图片 下载在赋值
- (UIButton *)headButton
{
    if (!_headButton)
    {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.tag = HCLeftGradeViewButtonTypeHead;
        [_headButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _headButton.frame = CGRectMake(WIDTH(self)*0.2, 0, WIDTH(self)*0.3, WIDTH(self)*0.3);//WIDTH(self)*0.2, 0, 100, 100);//30, 60, WIDTH(self)*0.7-60, WIDTH(self)*0.3
        ViewRadius(_headButton, WIDTH(self)*0.15);
        _headButton.center = CGPointMake(_headButton.center.x, self.center.y+30);
        [_headButton setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
    }
    return _headButton;
}

- (UILabel *)nickName
{
    if (!_nickName)
    {
        _nickName = [[UILabel alloc] init];
        _nickName.textColor = [UIColor whiteColor];
        _nickName.frame = CGRectMake(0, MaxY(self.headButton)+10, WIDTH(self)*0.7, 20);
        _nickName.textAlignment = NSTextAlignmentCenter;
        dicting =[readUserInfo getReadDic];
        if (IsEmpty(dicting[@"UserInf"][@"nickName"])) {
            _nickName.text = @"用户昵称";
        }else{
            _nickName.text = dicting[@"UserInf"][@"nickName"];
        }
        
    }
    return _nickName;
}

- (UIButton *)sofewareSetBtn
{
    if (!_sofewareSetBtn)
    {
        _sofewareSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sofewareSetBtn.tag = HCLeftGradeViewButtonTypeSoftwareSet;
        [_sofewareSetBtn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_sofewareSetBtn setTitle:@"软件设置" forState:UIControlStateNormal];
        _sofewareSetBtn.frame = CGRectMake(self.nickName.frame.origin.x+10, HEIGHT(self)-70, WIDTH(self)*0.7, 40);
        [_sofewareSetBtn addSubview:self.setImgView];
    }
    return _sofewareSetBtn;
}

- (UIImageView *)setImgView
{
    if (!_setImgView)
    {
        _setImgView = [[UIImageView alloc] initWithImage:OrigIMG(@"Settings")];
        _setImgView.frame = CGRectMake(WIDTH(self)*0.7/2-60, 10, 20, 20);
    }
    return _setImgView;
}
- (UIImageView *)setImgView2
{
    if (!_setImgView2)
    {
        _setImgView2 = [[UIImageView alloc] initWithImage:OrigIMG(@"Home")];
        _setImgView2.frame = CGRectMake(WIDTH(self)*0.7/2-60, 10, 20, 20);
    }
    return _setImgView2;
}


- (UIView *)smallView
{
    if(!_smallView){
        _smallView = [[UIView alloc]initWithFrame:CGRectMake((WIDTH(self)*0.7-100)/2, 320/667.0*SCREEN_HEIGHT, 100, 100)];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0, 0, 100, 20) ;
        [button1 setTitle:@"创建家庭" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(createFamily) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
//        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        button2.frame = CGRectMake(0, 60, 100, 20);
//        [button2 setTitle:@"加入家庭" forState:UIControlStateNormal];
//        [button2 addTarget:self action:@selector(toJoinFamily) forControlEvents:UIControlEventTouchUpInside];
//        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
        [_smallView  addSubview:button1];
        //[_smallView addSubview:button2];
    }
    return _smallView;
}


- (UIButton *)joinFamilyBtn
{
    if(!_joinFamilyBtn){
        _joinFamilyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinFamilyBtn.frame = CGRectMake(self.nickName.frame.origin.x, self.nickName.frame.origin.y + 20, WIDTH(self)*0.7,20);
        [_joinFamilyBtn setTitle:@"加入家庭" forState:UIControlStateNormal];
        [_joinFamilyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_joinFamilyBtn addTarget:self action:@selector(toJoinFamily) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinFamilyBtn;
}


@end

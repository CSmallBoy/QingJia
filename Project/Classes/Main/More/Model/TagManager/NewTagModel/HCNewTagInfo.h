//
//  HCNewTagInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface HCNewTagInfo : HCRequest

@property (nonatomic,strong) NSString *trueName; //姓名
@property (nonatomic,strong) NSString *imageName; //图片
@property (nonatomic,strong) NSString *sex;  // 性别
@property (nonatomic,strong) NSString *birthDay; // 生日
@property (nonatomic,strong) NSString *homeAddress; // 家庭住址
@property (nonatomic,strong) NSString *school;   // 学校

@property (nonatomic,strong) NSString *age;//年龄

@property (nonatomic,strong) NSString *openHealthCard; // 是否公开医疗卡
@property (nonatomic,strong) NSString *openHomeAddress;// 是否公开家庭住址

@property (nonatomic,strong) NSString *height;   // 身高
@property (nonatomic,strong) NSString *weight;   // 体重
@property (nonatomic,strong) NSString *bloodType; //血型
@property (nonatomic,strong) NSString *allergic;  // 过敏史
@property (nonatomic,strong) NSString *cureCondition; // 医疗状况
@property (nonatomic,strong) NSString *cureNote;  // 医疗笔记

@property (nonatomic,strong) NSString *relation1;   // 关系1
@property (nonatomic,strong) NSString *contactorId1;   // 联系人1 ID
@property (nonatomic,strong) NSString *contactorTrueName1; //联系人1 ID
@property (nonatomic,strong) NSString *contactorPhoneNo1;  //联系人1 手机号
@property (nonatomic,strong) NSString *imageName1;

@property (nonatomic,strong) NSString *relation2; // 关系2
@property (nonatomic,strong) NSString *contactorId2;  // 联系人2ID
@property (nonatomic,strong) NSString *contactorTrueName2; // 联系人2 ID
@property (nonatomic,strong) NSString *contactorPhoneNo2;  //联系人2 手机号
@property (nonatomic,strong) NSString *imageName2;

@property (nonatomic,strong) NSString *labelImageName; // 标签图片

@property (nonatomic, strong)UIImage *headImage;//头像

@property (nonatomic,strong) NSString *objectId;

@property (nonatomic, copy)NSString *status;


@property (nonatomic,strong) NSString *labelTitle;//标签描述
@property (nonatomic,strong) NSString *labelId;//标签ID

@property (nonatomic,assign) BOOL  isBlack;

@property (nonatomic,strong) NSString *lossTime;
@property (nonatomic,strong) NSString *callId;
@property (nonatomic,strong) NSString *lossAddress;
@property (nonatomic,strong) NSString *lossImageName;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *lossDesciption;

@property (nonatomic,copy)NSString *hasCall;//是否发呼

@end

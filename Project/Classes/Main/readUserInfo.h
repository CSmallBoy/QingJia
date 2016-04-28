//
//  readUserInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/3/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyselfInfoModel.h"
typedef void (^NHCReadBack)(NSString *str);

@interface readUserInfo : NSObject
+(void)creatDic:(NSDictionary*)dic;
+(NSDictionary *)getReadDic;
+(void)Dicdelete;
+(void)familyDicdelete;
//图片转64
+(NSString*)imageString:(UIImage*)image64;
//64转图片
+ (UIImage*)image64:(NSString*)imagestr;
//获取uuid
+ (NSString *)GetUUID;
//获取版本信息
+ (NSString *)GetPlatForm;

// 将家庭信息存到本地
+(void)createFamileDic:(NSDictionary *)dic;

+(NSDictionary *)getFaimilyDic;

//读取导数据库后的回调方法
/*
 *读取
 */
- (void)queryLastUserInfo:(NHCReadBack)accountInfo;

+ (UIImage*)creatQrCode:(NSString*)CodeInfo;
+ (BOOL)JudgmentInformation:(NSString *)ture;
//获取单张图片的方法

+ (NSURL *)url:(NSString*)imageName:(NSString *)pathName;


// 获取单张图片原图URl
+ (NSURL *)originUrl:(NSString *)imageName :(NSString *)pathName;

//上传图片
+ (NSString *)url:(NSString*)theType;
/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
//转成date
+(NSDate*)dateDetail: (NSString*)datesting;
//获取到一个字典 环信个人用户
+(NSDictionary*)userInfo: (NSString*)datesting;
@end

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
@interface readUserInfo : NSObject
+(void)creatDic:(NSDictionary*)dic;
+(NSDictionary *)getReadDic;
+(void)Dicdelete;
//图片转64
+(NSString*)imageString:(UIImage*)image64;
//64转图片
+ (UIImage*)image64:(NSString*)imagestr;
@end

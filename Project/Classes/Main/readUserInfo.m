//
//  readUserInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/3/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "readUserInfo.h"

@implementation readUserInfo
//创建
+(void)creatDic:(NSDictionary*)dic{
    NSMutableData *data =[NSMutableData data];
    //初始化归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //设置归档
    [archiver encodeObject:dic forKey:@"peson"];
    //归档结束
    [archiver finishEncoding];
    //写文件  需要先找到写的路径
    //先获取基本路径
    NSString * temp =NSTemporaryDirectory();
    //在获取文件路径
    NSString *filePath = [temp stringByAppendingString:@"acchiver.plist"];
    [data writeToFile:filePath atomically:YES];
    

}
+(NSDictionary*)getReadDic{
    //获取本地路径
    NSString *temp =NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingString:@"acchiver.plist"];
    //读文件
    NSLog(@"%@",filePath);
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //初始化解档对象
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //获取person对象
    NSDictionary *dict = [unarchiver decodeObjectForKey:@"peson"];
    return dict;
    
}
//删除
+(void)Dicdelete{
    //获取本地路径
    NSString *temp =NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingString:@"acchiver.plist"];
    //创建管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:filePath error:nil];
    
}
//图片zhuan64
+ (NSString*)imageString:(UIImage*)imagestr{
    UIImage *_originImage = [[UIImage alloc]init];
    _originImage = imagestr;
    NSData *_data = UIImageJPEGRepresentation(_originImage, 0.1f);
    NSString *_encodedImageStr = [_data base64Encoding];
    return _encodedImageStr;
    
}
//64转图片
+ (UIImage*)image64:(NSString *)imagestr{
    NSData *data =[[NSData alloc]initWithBase64Encoding:imagestr];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
+ (NSString *)GetUUID{
    
    NSString *uuid = [[NSUUID UUID]UUIDString];
    return uuid;
}
+ (NSString *)GetPlatForm{
    NSString * strModel = [UIDevice currentDevice].model;
    return strModel;
}
-(void)queryLastUserInfo:(NHCReadBack)accountInfo{
    NSDictionary *dict = [readUserInfo getReadDic];
    if ([dict[@"userName"] isEqualToString:@""]) {
        
    }else{
        
    }
    return;
}
@end

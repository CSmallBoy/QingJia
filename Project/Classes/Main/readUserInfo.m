//
//  readUserInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/3/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "readUserInfo.h"
#import "KMQRCode.h"
#import "UIImage+RoundedRectImage.h"
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
    NSData *_data = UIImageJPEGRepresentation(_originImage, 0.2f);
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
    return [[UIDevice currentDevice] name];
    //return deviceString;
}

+ (UIImage*)creatQrCode:(NSString *)CodeInfo{
   // NSString *source = @"http://baidu.com";
    
    //使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
    CIImage *imgQRCode = [KMQRCode createQRCodeImage:CodeInfo];
    
    //使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
    UIImage *imgAdaptiveQRCode = [KMQRCode resizeQRCodeImage:imgQRCode
                                                    withSize:SCREEN_WIDTH];
    
    //默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片，例如：蓝白色的二维码图片
    imgAdaptiveQRCode = [KMQRCode specialColorImage:imgAdaptiveQRCode
                                            withRed:0
                                              green:0
                                               blue:0]; //0~255
    
    //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
    UIImage *imgIcon = [UIImage createRoundedRectImage:[UIImage imageNamed:@"mtalklogo"]
                                              withSize:CGSizeMake(60.0, 60.0)
                                            withRadius:10];
    
    //使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
    imgAdaptiveQRCode = [KMQRCode addIconToQRCodeImage:imgAdaptiveQRCode
                                              withIcon:imgIcon
                                          withIconSize:imgIcon.size];
    return imgAdaptiveQRCode;
}
-(void)queryLastUserInfo:(NHCReadBack)accountInfo{
    NSDictionary *dict = [readUserInfo getReadDic];
    if ([dict[@"userName"] isEqualToString:@""]) {
        
    }else{
        
    }
    return;
}


+(void)createFamileDic:(NSDictionary *)dic
{
    NSMutableData *data =[NSMutableData data];
    //初始化归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //设置归档
    [archiver encodeObject:dic forKey:@"family"];
    //归档结束
    [archiver finishEncoding];
    //写文件  需要先找到写的路径
    //先获取基本路径
    NSString * temp =NSTemporaryDirectory();
    //在获取文件路径
    NSString *filePath = [temp stringByAppendingString:@"acchiver.plist"];
    [data writeToFile:filePath atomically:YES];

}

+(NSDictionary *)getFaimilyDic
{
    //获取本地路径
    NSString *temp =NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingString:@"acchiver.plist"];
    //读文件
    NSLog(@"%@",filePath);
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //初始化解档对象
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //获取person对象
    NSDictionary *dict = [unarchiver decodeObjectForKey:@"family"];
    return dict;


}

+ (NSURL *)url:(NSString *)imageName :(NSString *)pathName{
    NSString * string = [kDWloadImageUrl stringByAppendingString:[NSString stringWithFormat:@"%@/%@",pathName,imageName]];
    NSURL *url = [NSURL URLWithString:string];
    return url;
}

+ (NSURL *)originUrl:(NSString *)imageName :(NSString *)pathName{
    NSString * string = [kOriginImageUrl stringByAppendingString:[NSString stringWithFormat:@"%@/%@",pathName,imageName]];
    NSURL *url = [NSURL URLWithString:string];
    return url;
}
@end

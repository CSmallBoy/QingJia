//
//  HCVenderMgr.h
//  HealthCloud
//
//  Created by Vincent on 15/9/9.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCAvatarMgr : NSObject

@property (nonatomic, strong) UIImage  *headImage;
@property (nonatomic, assign) BOOL isUploadImage;
@property (nonatomic, assign) BOOL noUploadImage;

- (void)modifyAvatarWithController:(UIViewController *)vc
                        completion:(void (^)(BOOL result, UIImage *image, NSString *msg))completion;
- (void)modifyPhotoWithController:(UIViewController *)vc
                        completion:(void (^)(BOOL result, NSDictionary *data, NSString *msg))completion;
//创建单例
+ (instancetype)manager;


@end

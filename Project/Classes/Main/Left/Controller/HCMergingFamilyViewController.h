//
//  HCMergingFamilyViewController.h
//  Project
//
//  Created by 朱宗汉 on 16/2/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCViewController.h"
//#import <UIKit/UIKit.h>
typedef void (^click) (int i);
@interface HCMergingFamilyViewController : HCViewController
//图片名数组
@property(nonatomic,weak)NSArray *imageNames;
//图片数组
@property(nonatomic,weak)NSArray *images;
//回调单击方法
@property(nonatomic,strong)click click;
@end

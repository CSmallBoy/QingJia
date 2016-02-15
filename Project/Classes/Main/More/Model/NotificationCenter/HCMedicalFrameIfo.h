//
//  HCMedicalFrameIfo.h
//  Project
//
//  Created by 朱宗汉 on 16/2/3.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HCMedicalInfo;
@interface HCMedicalFrameIfo : NSObject

@property (nonatomic,strong) NSIndexPath  *indexPath;
@property (nonatomic,strong) HCMedicalInfo *info;

@property (nonatomic,strong) NSString  *title;

@property (nonatomic,assign) CGRect  titleFrame;
@property (nonatomic,assign) CGRect  contentFrame;

@property (nonatomic,assign) CGFloat   cellHeight;
@end

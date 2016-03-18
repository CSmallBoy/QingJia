//
//  HCMyOrderDetailInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCMyOrderDetailInfo : NSObject

@property (nonatomic,strong) NSString *orderNum;
@property (nonatomic,strong) NSString  *name;
@property (nonatomic,strong) NSString  *telNum;
@property (nonatomic,strong) NSString  *address;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *buyTime;
@property (nonatomic,strong) NSString *sendTime;
@property (nonatomic,strong) NSString *allPrice;

@property (nonatomic,strong) NSString *factPrice;


@end

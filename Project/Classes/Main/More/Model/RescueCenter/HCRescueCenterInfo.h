//
//  HCRescueCenterInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCRescueCenterInfo : NSObject
/**
 *头部图片
 */
@property (nonatomic,strong) NSString *headerImageStr;

/**
 *新闻标题
 */
@property (nonatomic,strong) NSString *newsTitle;

/**
 *具体新闻信息
 */
@property (nonatomic,strong) NSString *detailNews;

/**
 *网址
 */
@property (nonatomic,strong) NSString *urlStr;

/**
 *KeyId
 */
@property (nonatomic,strong) NSString *KeyId;
/**
 *CTitle
 */
@property (nonatomic,strong) NSString *CTitle;
/**
 *CImage
 */
@property (nonatomic,strong) NSString *CImage;
/**
 *ActTime
 */
@property (nonatomic,strong) NSString *ActTime;

@end

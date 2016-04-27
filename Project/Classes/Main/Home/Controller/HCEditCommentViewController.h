//
//  HCEditCommentViewController.h
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCViewController.h"
@class HCHomeInfo;
@interface HCEditCommentViewController : HCViewController
@property (nonatomic ,copy)NSString *single;
@property (nonatomic ,copy)NSString *all_coment_to;
//**num_P 代表第几个*//
@property (nonatomic ,copy)NSString *num_P;
//图片的第几个
@property (nonatomic,copy)NSString *image_number;
// 是时光id
@property (nonatomic,copy)NSString *time_id;
//  图片名字
@property (nonatomic,copy)NSString *image_name;

@property (nonatomic ,strong) HCHomeInfo *infomodel;
//评论的id
@property (nonatomic,copy) NSString *commentId;

@property (nonatomic,copy) NSString *touser;
@end

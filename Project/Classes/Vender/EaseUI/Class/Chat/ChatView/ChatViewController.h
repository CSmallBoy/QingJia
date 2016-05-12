//
//  ChatViewController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"

@interface ChatViewController : EaseMessageViewController
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,strong) UIImage *imageUserPh;
@property (nonatomic,strong) NSMutableDictionary *image_dict;
@end

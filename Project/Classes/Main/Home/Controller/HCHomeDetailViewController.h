//
//  HCHomeDetailViewController.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"

@interface HCHomeDetailViewController : HCTableViewController
@property (nonatomic,copy)NSString *timeID;
@property (nonatomic,copy)NSString *likeStr;
@property (nonatomic,strong) NSArray *islikeArr;
@property (nonatomic,copy) NSString *MySelf;
@end

//
//  HCChangeBounleTelNumberCell.h
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCChangeBounleTelNumberCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath   *indexPath;
@property (nonatomic,assign) BOOL    isSure;
@property (nonatomic,strong) UITextField   *textField;
@property (nonatomic,copy) NSString * twoPhone;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) NSString  *codeNum;

@end

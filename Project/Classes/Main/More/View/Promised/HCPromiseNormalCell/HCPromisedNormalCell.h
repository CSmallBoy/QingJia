//
//  HCPromisedNormalCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCPromisedNormalCell : UITableViewCell

//@property(nonatomic,assign)  BOOL  hasImage;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * detail;
@property(nonatomic,assign)BOOL   isBlack;

+(instancetype)CustomCellWithTableView:(UITableView *)tableView;


@end

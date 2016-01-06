//
//  HCPromisedHeaderIVCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCPromisedHeaderIVCell : UITableViewCell

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;

+(instancetype)CustomCellWithTableView:(UITableView *)tableView;


@end

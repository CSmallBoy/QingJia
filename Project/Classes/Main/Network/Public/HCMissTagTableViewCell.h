//
//  HCMissTagTableViewCell.h
//  钦家
//
//  Created by Tony on 16/5/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HCNewTagInfo.h"

@interface HCMissTagTableViewCell : UITableViewCell

@property (nonatomic,strong)UIButton *selectedButton;//选择按钮
@property (nonatomic,strong)UIImageView *clothingImage;//标签图片
@property (nonatomic,strong)UILabel *titleLabel;//衣服类型
@property (nonatomic,strong)UILabel *idLabel;//对象id
@property (nonatomic,strong)UILabel *remarkLabel;//备注

+(instancetype)customCellWithTable:(UITableView *)tableView;

@end

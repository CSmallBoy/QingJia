//
//  HCLogisticsInfoTableViewCellSecond.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCLogisticsInfoTableViewCellSecond.h"
#import "HCLogisticsInfo.h"
@implementation HCLogisticsInfoTableViewCellSecond


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        self.imageView.image = OrigIMG(_info.imageName);
        self.textLabel.text = _info.titleText;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor redColor];
        self.detailTextLabel.text = _info.detailText;
        self.detailTextLabel.textColor = [UIColor redColor];
    }else
    {
        self.imageView.image = OrigIMG(_info.imageName);
        self.textLabel.text = _info.titleText;
        self.detailTextLabel.text = _info.detailText;
        self.textLabel.font = [UIFont systemFontOfSize:14];
  
    }
}
@end

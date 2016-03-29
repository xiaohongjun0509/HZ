//
//  HZResumeExperienceCell.h
//  HZ
//
//  Created by hongjunxiao on 16/3/29.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZResumeModel.h"
@interface HZResumeExperienceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *xueliLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuanyeLabel;
@property (nonatomic, strong) HZResumeExperienceModel *model;
@property (nonatomic, strong) HZResumeBusinessModel *bussModel;
+ (CGFloat)cellHeight;
@end

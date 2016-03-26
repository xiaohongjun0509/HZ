//
//  HZJobHuntCell.h
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZJobModel.h"
#import "HZResumeModel.h"
static NSString * const kHZJobHuntCell = @"HZJobHuntCell";

@interface HZJobHuntCell : UITableViewCell

@property (nonatomic, strong) HZJobModel *model;

@property (nonatomic, strong) HZResumeModel *resumeModel;


+ (CGFloat)cellHeight;

@end

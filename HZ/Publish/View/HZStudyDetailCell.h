//
//  HZStudyDetailCell.h
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZEditDetailStudyModel.h"
@interface HZStudyDetailCell : UITableViewCell
@property (nonatomic, strong) HZEditDetailStudyModel *model;
@property (nonatomic, assign) BOOL isStudy;// 是不是教育经历
@end

//
//  HZResumeEditCell.h
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZEditResumeItemModel.h"
@interface HZResumeEditCell : UITableViewCell

@property (nonatomic, strong) HZEditResumeItemModel* model;
@property (nonatomic, copy) void (^showSelectionView)(NSInteger );
@end

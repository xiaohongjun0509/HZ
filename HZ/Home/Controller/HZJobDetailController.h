//
//  HZJobDetailController.h
//  HZ
//
//  Created by hongjunxiao on 16/4/4.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZJobModel.h"
@interface HZJobDetailController : UIViewController
@property (nonatomic, strong) HZJobModel *model;
@property (nonatomic, copy) NSString *cityName;
@end

//
//  HZEducationalExperienceViewController.h
//  Recruitment
//
//  Created by tusm on 15/12/4.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZResumeEditViewController.h"
#import "HZEditResumeItemModel.h"
@interface HZEducationalExperienceViewController : UIViewController
//@property(nonatomic,weak)HZResumeEditViewController* resumeVC;//添加简历信息页
@property (nonatomic, strong) HZEditResumeItemModel *item;
@end

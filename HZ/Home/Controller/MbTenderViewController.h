//
//  MbTenderViewController.h
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbZhaoBiaoViewController.h"
#import "MbZhongBiaoViewController.h"
@interface MbTenderViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic) MbZhaoBiaoViewController* zhaobiaoVC;
@property (strong, nonatomic) MbZhongBiaoViewController* zhongbiaoVC;

@end

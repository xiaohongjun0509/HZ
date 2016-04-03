//
//  HZResumeEditViewController.h
//  HZ
//
//  Created by hongjunxiao on 16/3/30.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZResumeEditViewController : UIViewController

@property(nonatomic,strong)NSMutableArray* addeduArray;
@property(nonatomic,strong)NSMutableArray* addworkArray;
@property(nonatomic,strong)NSMutableArray* addeduArrayStr;
@property(nonatomic,strong)NSMutableArray* addworkArrayStr;
@property(nonatomic,strong)NSString* str1;            //教育经历
@property(nonatomic,strong)NSString* str2;            //工作经历
@property(nonatomic,strong)NSMutableDictionary* mutDic;
@property(nonatomic,strong)NSString* jsonString1;
@property(nonatomic,strong)NSString* jsonString2;
@property(nonatomic,strong)NSMutableDictionary* workDic;
@property(nonatomic,strong)NSString* cityName;

@end

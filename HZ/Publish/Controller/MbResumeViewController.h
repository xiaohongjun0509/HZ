//
//  MbResumeViewController.h
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbUserInfo.h"
#import "MbPaser.h"
@interface MbResumeViewController : UIViewController
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
//@property (nonatomic, strong) NSMutableArray *workArray;
@property (nonatomic, strong) NSMutableArray *eduArray;
@end

//
//  HZResumeModel.h
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZResumeExperienceModel.h"
#import "HZResumeBusinessModel.h"
@interface HZResumeModel : NSObject
@property (nonatomic, copy) NSString *resumeid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *wages;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *diploma;
@property (nonatomic, copy) NSString *experience;
@property (nonatomic, copy) NSString *intruduction;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *restime;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSArray *experienced;
@property (nonatomic, copy) NSArray *business;
@property (nonatomic, copy) NSString *linkman;
@end



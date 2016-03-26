//
//  PreHeader.h
//  MissU
//
//  Created by hongjunxiao on 16/2/7.
//  Copyright © 2016年 ihj. All rights reserved.
//




#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define RGB(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]

#define REDCOLOR [UIColor colorWithRed:228 / 255.0 green:46 / 255.0 blue:21 / 255.0 alpha:1]
#define BLACKCOLOR [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]
#define BGCOLOR [UIColor colorWithRed:219 / 255.0 green:219 / 255.0 blue:219 / 255.0 alpha:1]
#define WORDCOLOR [UIColor colorWithRed:123 / 255.0 green:123 / 255.0 blue:123 / 255.0 alpha:1]
#define WEAKSELF   typeof(self)     __weak weakSelf = self;
#define labelText [UIScreen mainScreen].bounds.size.height/40


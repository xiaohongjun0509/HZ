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
#import "NetworkManager.h"
#import "UIImageView+Extension.h"
#import "UIViewController+AttachBack.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define RGB(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]

#define REDCOLOR [UIColor colorWithRed:228 / 255.0 green:46 / 255.0 blue:21 / 255.0 alpha:1]
#define BLACKCOLOR [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]
#define BGCOLOR [UIColor colorWithRed:219 / 255.0 green:219 / 255.0 blue:219 / 255.0 alpha:1]
#define WORDCOLOR [UIColor colorWithRed:123 / 255.0 green:123 / 255.0 blue:123 / 255.0 alpha:1]
#define WEAKSELF   typeof(self)     __weak weakSelf = self;
#define labelText [UIScreen mainScreen].bounds.size.height/40






//banner
#define banner @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_index"
//验证码
#define CODE @"http://haozhu.shiliuyun.net/index.php/Home/Login/hz_message?"
//注册
#define regist @"http://haozhu.shiliuyun.net/index.php/Home/Login/hz_register?"
//找回密码
#define fingpassword @"http://haozhu.shiliuyun.net/index.php/Home/Login/hz_reget_password?"
//修改密码
#define modifypassword @"http://haozhu.shiliuyun.net/index.php/Home/Login/hz_modify_password?"

//登录
#define login @"http://haozhu.shiliuyun.net/index.php/Home/Login/hz_login?"
//发布简历
#define sendjianli @"http://haozhu.shiliuyun.net/index.php/Home/Release/hz_info_release?"
//发布招聘信息
#define sendzhaopin @"http://haozhu.shiliuyun.net/index.php/Home/Release/hz_info_recruit?"
//发布企业信息
#define sendqiye @"http://haozhu.shiliuyun.net/index.php/Home/Release/hz_info_company?"
//找工作
#define findwork @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_recruitmen"
//工作收藏
#define collectionwork @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_recruitmen_collect?"
//看简历
#define seeresume @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_resume"

//简历收藏
#define collectionresum @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_resume_collect"
//企业通列表
#define enterpriseList @"http://haozhu.shiliuyun.net/index.php/Home/index/hz_company"
//企业通收藏
#define collectionenterprise @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_company_collect"

//我的发布  找工作
#define myfindwork @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_recruitmen_list?"
//#define myfindwork @"http://www.bruli.cn/index.php/Home/Distributelist/hz_recruitmen_list?"

//我的发布  看简历
#define myseeresume @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_resume_list?"

//我的发布  企业通列表
#define myenterpriseList @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_company_list?"

//城市列表
#define citylist @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_city"


//地区
#define hopeplace @"http://haozhu.shiliuyun.net/index.php/Home/Options/hz_resume_area"

//三级联动地区
#define threeplace @"http://haozhu.shiliuyun.net/index.php/Home/Release/hz_company_area?"

//学历
#define hopeeducation @"http://haozhu.shiliuyun.net/index.php/Home/Options/hz_resume_diploma"
//工作经验
#define hopeexperience @"http://haozhu.shiliuyun.net/index.php/Home/Options/hz_resume_experience"
//应聘职位
#define hopeposition1 @"http://haozhu.shiliuyun.net/index.php/Home/Options/hz_resume_position1"
//应聘职位
#define hopeposition @"http://haozhu.shiliuyun.net/index.php/Home/Options/hz_resume_position"
//期望薪资
#define hopesalary @"http://haozhu.shiliuyun.net/index.php/Home/Options/hz_resume_wages"

//找工作收藏
#define workCollect @"http://haozhu.shiliuyun.net/index.php/Home/Myfavorite/hz_recruitmen_favorite?"
//简历收藏
#define jianliCollect @"http://haozhu.shiliuyun.net/index.php/Home/Myfavorite/hz_resume_collect?"
//企业收藏
#define qiyeCollect @"http://haozhu.shiliuyun.net/index.php/Home/Myfavorite/hz_company_favorite?"

//取消工作收藏
#define cancleWorkCollect @"http://haozhu.shiliuyun.net/index.php/Home/Myfavorite/hz_recruitmen_delete?"

//取消简历收藏
#define cancleJianliCollect @"http://haozhu.shiliuyun.net/index.php/Home/Myfavorite/hz_resume_delete?"

//取消企业通收藏
#define cancleQiyeCollect @"http://haozhu.shiliuyun.net/index.php/Home/Myfavorite/hz_company_delete?"
//我的发布 找工作删除
#define fabushanchu1 @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_recruitmen_delete?"
//我的发布 看简历删除
#define fabushanchu2 @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_resume_delete?"
//我的发布 企业通删除
#define fabushanchu3 @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_company_delete?"

//判断工作是否收藏
#define judge1 @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_recruitmen_whether_collection?"
//判断简历是否收藏
#define judge2 @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_resume_whether_collection?"
//判断企业是否收藏
#define judge3 @"http://haozhu.shiliuyun.net/index.php/Home/Index/hz_company_whether_collection?"
//招聘信息刷新
#define zhaopinRefresh @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_recruitmen_break?"

//简历刷新
#define jianliRefresh @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_resume_break?"

//企业通刷新
#define qiyeRefresh @"http://haozhu.shiliuyun.net/index.php/Home/Distributelist/hz_company_break?"





//
//  MbUserInfo.h
//  好筑
//
//  Created by tusm on 15/12/14.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MbUserInfo : NSObject
@property(nonatomic,assign)int turn;                  //返回码
@property(nonatomic,assign)int state;
@property(nonatomic,strong)NSString* msg;             //返回消息
@property(nonatomic,strong)NSString* code;            //验证码
@property(nonatomic,assign)int userId;                //用户id
@property(nonatomic,strong)NSString* telephone;       //电话号码
@property(nonatomic,strong)NSString* password;        //密码
@property(nonatomic,strong)NSString* imageString;     //轮播图地址
@property(nonatomic,strong)NSString* imageUrl;
@property(nonatomic,strong)NSString* recruitmenid;    //招聘信息id
@property(nonatomic,strong)NSString* area;            //地区名称
@property(nonatomic,strong)NSString* position;        //招聘职位
@property(nonatomic,strong)NSArray* positionArray;    //职位数组
@property(nonatomic,strong)NSString* address;         //工作地址
@property(nonatomic,strong)NSString* wages;           //薪水
@property(nonatomic,strong)NSString* company;         //企业名称
@property(nonatomic,strong)NSString* companyid;
@property(nonatomic,strong)NSString* title;           //招聘标题
@property(nonatomic,strong)NSString* rectime;         //招聘时间
@property(nonatomic,strong)NSString* ways;            //招聘方式
@property(nonatomic,strong)NSString* diploma;         //要求学历
@property(nonatomic,strong)NSString* experience;      //要求工作经验
@property(nonatomic,strong)NSString* demand;          //任职要求
@property(nonatomic,strong)NSString* linkman;         //联系人
@property(nonatomic,strong)NSString* phone;           //联系电话
@property(nonatomic,strong)NSString* aboutus;         //公司简介

@property(nonatomic,strong)NSString* resumeid;        //简历id值
@property(nonatomic,strong)NSString* positioname;     //职位
@property(nonatomic,strong)NSString* suffer;          //工作经验
@property(nonatomic,strong)NSString* pay;             //薪资
@property(nonatomic,strong)NSString* username;        //姓名
@property(nonatomic,assign)int sex;                   //性别
@property(nonatomic,assign)int age;                   //年龄
@property(nonatomic,strong)NSArray* business;         //工作经历数组
@property(nonatomic,strong)NSArray* experienced;      //教育经历数组
@property(nonatomic,strong)NSString* intruduction;    //自我介绍
@property(nonatomic,strong)NSString* restime;         //添加时间
@property(nonatomic,strong)NSString* school;          //学校
@property(nonatomic,strong)NSString* intervalstart;   //入学时间
@property(nonatomic,strong)NSString* intervalstop;    //毕业时间
@property(nonatomic,strong)NSString* level;           //受教育水平
@property(nonatomic,strong)NSString* specialty;       //专业
@property(nonatomic,strong)NSString* synopsis;
@property(nonatomic,assign)int businessid;
@property(nonatomic,strong)NSString* corporate;       //公司名称
@property(nonatomic,strong)NSString* content;         //工作内容
@property(nonatomic,strong)NSString* timestart;       //开始时间
@property(nonatomic,strong)NSString* timestop;        //结束时间
@property(nonatomic,strong)NSString* comtime;
@property(nonatomic,strong)NSString* contact;
@property(nonatomic,strong)NSArray* intelligence;     //资质数组
@property(nonatomic,strong)NSString* range;
@property(nonatomic,strong)NSString* tedail;          //详情介绍
@property(nonatomic,strong)NSString* name;            //地区名字
@property(nonatomic,assign)int areaid;                //城市id
@end

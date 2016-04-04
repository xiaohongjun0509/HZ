//
//  MbPaser.h
//  好筑
//
//  Created by tusm on 15/12/14.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CommonActionStatus.h"

@interface MbPaser : NSObject
//轮播图
+(NSMutableArray*)paserBannerByDic:(NSDictionary*)dic;
//发布简历
+(void)sendResumeInformationByUserid:(NSString*)userId area:(NSString*)area introduces:(NSString* )introduces name:(NSString* )name sex:(int)sex age:(int)age education:(NSString*)education experience:(NSString*)experience position:(NSString*)position salary:(NSString*)salary telephone:(NSString*)telephone addeduArray:(NSString*)addeduArray addworkArray:(NSString*)addworkArray jieshao:(NSString*)jieshao result:(void(^)(ResumeSaveResponse *response, NSError *error))result;
//发布招聘信息
+(void)sendResumeRecruitByUserid:(NSString*)userId title:(NSString*)title company:(NSString* )company ways:(NSString* )ways position:(NSString*)position area:(NSString*)area address:(NSString*)address experience:(NSString*)experience diploma:(NSString*)diploma wages:(NSString*)wages demand:(NSString*)demand aboutus:(NSString*)aboutus linkman:(NSString*)linkman phone:(NSString*)phone result:(void(^)(RecruitSaveResponse *response, NSError *error))result;
//发布企业信息
+(void)sendInfoCompanyByUserid:(NSString*)userid company:(NSString*)company aptitude:(NSString*)aptitude range:(NSString*)range area:(NSString*)area address:(NSString*)address contact:(NSString*)contact phone:(NSString*)phone result:(void(^)(InfoCompanySaveResponse *response, NSError *error))result;
//找工作列表
+(NSMutableArray*)paserFindWorkByDic:(NSDictionary*)dic;
//工作收藏
+(void)sendRecruitmenCollectByUserid:(NSString*)userid recruitmenid:(NSString*)recruitmenid result:(void(^)(RecruitmenCollectResponse *response, NSError *error))result;
//看简历列表
+(NSMutableArray*)paserSeeResumeByDic:(NSDictionary*)dic;
//简历收藏
+(void)sendResumeCollectByUserid:(NSString*)userid resumeid:(NSString*)resumeid result:(void(^)(ResumeidCollectResponse *response, NSError *error))result;
//企业通列表
+(NSMutableArray*)paserEnterpriseByDic:(NSDictionary*)dic;
//企业通收藏
+(void)sendEnterpriseCollectByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(EnterpriseCollectResponse *response, NSError *error))result;
//我的发布   工作
+(NSMutableArray*)paserMyFindWorkByDic:(NSDictionary*)dic;
//我的发布   简历
+(NSMutableArray*)paserMySeeResumeByDic:(NSDictionary*)dic;
//我的发布   企业通
+(NSMutableArray*)paserMyEnterpriseByDic:(NSDictionary*)dic;
//地区
+(NSMutableArray*)paserPlaceByDic:(NSDictionary*)dic;
//教育
+(NSMutableArray*)paserEducationByDic:(NSDictionary*)dic;
//经验
+(NSMutableArray*)paserExperienceByDic:(NSDictionary*)dic;
//职位
+(NSMutableArray*)paserPositionByDic:(NSDictionary*)dic;
//薪资
+(NSMutableArray*)paserSalaryByDic:(NSDictionary*)dic;
//城市列表
+(NSMutableArray*)paserCityListByDic:(NSDictionary*)dic;
//取消工作收藏
+(void)sendCancleRecruitmenCollectByUserid:(NSString*)userid recruitmencollid:(NSString*)recruitmencollid result:(void(^)(CancleRecruitmenCollectResponse *response, NSError *error))result;
//取消简历收藏
+(void)sendCancleResumecollCollectByUserid:(NSString*)userid resumecollid:(NSString*)resumecollid result:(void(^)(CancleResumecollCollectResponse *response, NSError *error))result;
//取消企业通收藏
+(void)sendCancleCompanycollCollectByUserid:(NSString*)userid companycollid:(NSString*)companycollid result:(void(^)(CancleCompanycollCollectResponse *response, NSError *error))result;
//我的发布 招聘信息删除
+(void)sendMyReleaseRecruitDeleteByUserid:(NSString*)userid recruitmenid:(NSString*)recruitmenid result:(void(^)(MyReleaseRecruitDeleteResponse *response, NSError *error))result;
//我的发布 简历删除
+(void)sendMyReleaseResumeDeleteByUserid:(NSString*)userid resumeid:(NSString*)resumeid result:(void(^)(MyReleaseResumeDeleteResponse *response, NSError *error))result;
//我的发布 企业通删除
+(void)sendMyReleaseEnterpriseDeleteByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(MyReleaseEnterpriseDeleteResponse *response, NSError *error))result;


//我的发布 招聘信息刷新
+(void)sendMyReleaseRecruitRefreshByRecruitmenid:(NSString*)recruitmenid result:(void(^)(MyReleaseRecruitRefreshResponse *response, NSError *error))result;
//我的发布 简历刷新
+(void)sendMyReleaseResumeRefreshByResumeid:(NSString*)resumeid result:(void(^)(MyReleaseResumeRefreshResponse *response, NSError *error))result;
//我的发布 企业通刷新
+(void)sendMyReleaseEnterpriseRefreshByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(MyReleaseEnterpriseRefreshResponse *response, NSError *error))result;
//修改密码
+(void)modifyPassWordByPhone:(NSString*)telePhone oldWord:(NSString*)oldWord newWordOne:(NSString*)newWordOne newWordTwo:(NSString*)newWordTwo result:(void(^)(ModifyPassWordResponse *response, NSError *error))result;
@end

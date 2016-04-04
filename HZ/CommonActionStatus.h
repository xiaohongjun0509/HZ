//
//  CommonActionStatus.h
//  shouxinzhihui
//
//  Created by yaokaige on 14-5-7.
//  Copyright (c) 2014年 Beijing Gan Servant Software Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  通用响应状态信息
 */
@interface CommonActionStatus : NSObject <NSCoding>

- (id)initWithJSONObject:(id)jsonObject;

@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id data;
@property (nonatomic, assign) int turn;
@end





/**
 *  发布简历
 */
@interface ResumeSaveResponse : CommonActionStatus

@end

/**
 *  发布招聘信息
 */
@interface RecruitSaveResponse : CommonActionStatus

@end
/**
 *  发布企业信息
 */
@interface InfoCompanySaveResponse : CommonActionStatus

@end


/**
 *  工作收藏
 */
@interface RecruitmenCollectResponse : CommonActionStatus

@end
/**
 *  简历收藏
 */
@interface ResumeidCollectResponse : CommonActionStatus

@end
/**
 *  企业通收藏
 */
@interface EnterpriseCollectResponse : CommonActionStatus

@end
/**
 *  取消工作收藏
 */
@interface CancleRecruitmenCollectResponse : CommonActionStatus

@end

/**
 *  取消简历收藏
 */
@interface CancleResumecollCollectResponse : CommonActionStatus

@end

/**
 *  取消企业通收藏
 */
@interface CancleCompanycollCollectResponse : CommonActionStatus

@end

/**
 *  我的发布 删除招聘信息
 */
@interface MyReleaseRecruitDeleteResponse : CommonActionStatus

@end


/**
 *  我的发布 删除简历
 */
@interface MyReleaseResumeDeleteResponse : CommonActionStatus

@end


/**
 *  我的发布 删除企业通
 */
@interface MyReleaseEnterpriseDeleteResponse : CommonActionStatus

@end

/**
 *  我的发布 刷新招聘信息
 */
@interface MyReleaseRecruitRefreshResponse : CommonActionStatus

@end


/**
 *  我的发布 刷新简历
 */
@interface MyReleaseResumeRefreshResponse : CommonActionStatus

@end


/**
 *  我的发布 刷新企业通
 */
@interface MyReleaseEnterpriseRefreshResponse : CommonActionStatus

@end

/**
 *  修改密码
 */
@interface ModifyPassWordResponse : CommonActionStatus

@end



//
//  CommonActionStatus.m
//  shouxinzhihui
//
//  Created by yaokaige on 14-5-7.
//  Copyright (c) 2014年 Beijing Gan Servant Software Co., Ltd. All rights reserved.
//

#import "CommonActionStatus.h"

#define kEncodedObjectPath_Login ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"login"])

@implementation CommonActionStatus

- (id)initWithJSONObject:(id)jsonObject
{
    self = [super init];
    if(self)
    {
        NSNumber *status = [jsonObject objectForKey:@"status"];
        _status = status.boolValue;
        _message = [jsonObject objectForKey:@"msg"];
        _data = jsonObject;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.status = [aDecoder decodeBoolForKey:@"status"];
        self.message = [aDecoder decodeObjectForKey:@"msg"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.status forKey:@"status"];
    [aCoder encodeObject:self.message forKey:@"msg"];
    [aCoder encodeObject:self.data forKey:@"data"];
}

@end

@implementation ResumeSaveResponse

@end



@implementation RecruitSaveResponse

@end

@implementation RecruitmenCollectResponse

@end
@implementation ResumeidCollectResponse

@end
@implementation InfoCompanySaveResponse

@end
@implementation EnterpriseCollectResponse

@end
@implementation CancleRecruitmenCollectResponse

@end
@implementation CancleResumecollCollectResponse

@end
@implementation CancleCompanycollCollectResponse

@end

@implementation MyReleaseRecruitDeleteResponse

@end

@implementation MyReleaseResumeDeleteResponse

@end

@implementation MyReleaseEnterpriseDeleteResponse

@end

@implementation MyReleaseRecruitRefreshResponse

@end

@implementation MyReleaseResumeRefreshResponse

@end

@implementation MyReleaseEnterpriseRefreshResponse

@end
@implementation ModifyPassWordResponse

@end

//
//  MbPaser.m
//  好筑
//
//  Created by tusm on 15/12/14.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbPaser.h"
#import "AFNetworking.h"
@implementation MbPaser



//eduArray:(NSMutableArray*)eduArray workArray:(NSMutableArray*)workArray
+(void)sendResumeInformationByUserid:(NSString*)userId area:(NSString*)area introduces:(NSString* )introduces name:(NSString* )name sex:(int)sex age:(int)age education:(NSString*)education experience:(NSString*)experience position:(NSString*)position salary:(NSString*)salary telephone:(NSString*)telephone addeduArray:(NSString*)addeduArray addworkArray:(NSString*)addworkArray jieshao:(NSString*)jieshao result:(void(^)(ResumeSaveResponse *response, NSError *error))result{


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.设置登录参数
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
  
  //dict = @{@"userid":userId,@"title":introduces,@"username":name,@"age":[NSNumber numberWithInt:age],@"sex":[NSNumber numberWithInt:sex],@"diploma":education,@"experience":experience,@"position":position,@"wages":salary,@"phone":telephone,@"intruduction":jieshao};

    [dict setObject:userId forKey:@"userid"];
    [dict setObject:area forKey:@"area"];
    [dict setObject:introduces forKey:@"title"];
    [dict setObject:name forKey:@"username"];
    [dict setObject:[NSNumber numberWithInteger:age] forKey:@"age"];
    [dict setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    [dict setObject:education forKey:@"diploma"];
    [dict setObject:experience forKey:@"experience"];
    [dict setObject:position forKey:@"position"];
    [dict setObject:salary forKey:@"wages"];
    [dict setObject:telephone forKey:@"phone"];
    if (addeduArray.length==0||addworkArray.length==0) {
        
    }else{
        [dict setObject:addeduArray forKey:@"education"];
        [dict setObject:addworkArray forKey:@"business"];
    }
  
    [dict setObject:jieshao forKey:@"intruduction"];


    
    //3.请求
    [manager POST:sendjianli parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
 
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];

        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
      
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        NSLog(@"%@===%d",response.message,response.turn);
        result(response, nil);

        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败: %@", error);
    }];

}


//发布招聘信息
+(void)sendResumeRecruitByUserid:(NSString*)userId title:(NSString*)title company:(NSString* )company ways:(NSString* )ways position:(NSString*)position area:(NSString*)area address:(NSString*)address experience:(NSString*)experience diploma:(NSString*)diploma wages:(NSString*)wages demand:(NSString*)demand aboutus:(NSString*)aboutus linkman:(NSString*)linkman phone:(NSString*)phone result:(void(^)(RecruitSaveResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.设置登录参数
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

    
    [dict setObject:userId forKey:@"userid"];
    [dict setObject:title forKey:@"title"];
    [dict setObject:company forKey:@"company"];
    [dict setObject:ways forKey:@"ways"];
    [dict setObject:position forKey:@"position"];
    [dict setObject:area forKey:@"area"];
    [dict setObject:address forKey:@"address"];
    [dict setObject:experience forKey:@"experience"];
    [dict setObject:diploma forKey:@"diploma"];
    [dict setObject:wages forKey:@"wages"];
    [dict setObject:demand forKey:@"demand"];
    [dict setObject:aboutus forKey:@"aboutus"];
    [dict setObject:linkman forKey:@"linkman"];
    [dict setObject:phone forKey:@"phone"];

    //3.请求
    [manager POST:sendzhaopin parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        NSLog(@"%@===%d",response.message,response.turn);
        result(response, nil);
        
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败: %@", error);
    }];



}

//发布企业信息
+(void)sendInfoCompanyByUserid:(NSString*)userid company:(NSString*)company aptitude:(NSString*)aptitude range:(NSString*)range area:(NSString*)area address:(NSString*)address contact:(NSString*)contact phone:(NSString*)phone result:(void(^)(InfoCompanySaveResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.设置登录参数
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    
    
    [dict setObject:userid forKey:@"userid"];
    [dict setObject:company forKey:@"company"];
    [dict setObject:aptitude forKey:@"aptitude"];
    [dict setObject:range forKey:@"tedail"];
    [dict setObject:area forKey:@"area"];
    [dict setObject:address forKey:@"address"];
    [dict setObject:contact forKey:@"contact"];
    [dict setObject:phone forKey:@"phone"];

    //3.请求
    [manager POST:sendqiye parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
       
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        NSLog(@"%@===%d",response.message,response.turn);
        result(response, nil);
        
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败: %@", error);
    }];



}


//工作收藏
+(void)sendRecruitmenCollectByUserid:(NSString*)userid recruitmenid:(NSString*)recruitmenid result:(void(^)(RecruitmenCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmenid forKey:@"recruitmenid"];
    [manager POST:collectionwork parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
 
        result(response, nil);

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];
    
}


//简历收藏
+(void)sendResumeCollectByUserid:(NSString*)userid resumeid:(NSString*)resumeid result:(void(^)(ResumeidCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:resumeid forKey:@"resumeid"];
    [manager POST:collectionresum parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];

}
//企业通列表

//企业通收藏
+(void)sendEnterpriseCollectByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(EnterpriseCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companyid forKey:@"companyid"];
    [manager POST:collectionenterprise parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];

}

//我的发布   工作

//取消工作收藏
+(void)sendCancleRecruitmenCollectByUserid:(NSString*)userid recruitmencollid:(NSString*)recruitmencollid result:(void(^)(CancleRecruitmenCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmencollid forKey:@"recruitmencollid"];
    
   
    [manager POST:cancleWorkCollect parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}


//取消简历收藏
+(void)sendCancleResumecollCollectByUserid:(NSString*)userid resumecollid:(NSString*)resumecollid result:(void(^)(CancleResumecollCollectResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:resumecollid forKey:@"resumecollid"];
    [manager POST:cancleJianliCollect parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
//取消企业通收藏
+(void)sendCancleCompanycollCollectByUserid:(NSString*)userid companycollid:(NSString*)companycollid result:(void(^)(CancleCompanycollCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companycollid forKey:@"companycollid"];
    [manager POST:cancleQiyeCollect parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];



}

//我的发布 招聘信息删除
+(void)sendMyReleaseRecruitDeleteByUserid:(NSString*)userid recruitmenid:(NSString*)recruitmenid result:(void(^)(MyReleaseRecruitDeleteResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmenid forKey:@"recruitmenid"];
    [manager POST:fabushanchu1 parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];

        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];

        result(response, nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
//我的发布 简历删除
+(void)sendMyReleaseResumeDeleteByUserid:(NSString*)userid resumeid:(NSString*)resumeid result:(void(^)(MyReleaseResumeDeleteResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:resumeid forKey:@"resumeid"];
    [manager POST:fabushanchu2 parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];

        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];

        result(response, nil);
 
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
//我的发布 企业通删除
+(void)sendMyReleaseEnterpriseDeleteByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(MyReleaseEnterpriseDeleteResponse *response, NSError *error))result{
    
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companyid forKey:@"companyid"];
    [manager POST:fabushanchu3 parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];

        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];



}
//我的发布 招聘信息刷新
+(void)sendMyReleaseRecruitRefreshByRecruitmenid:(NSString*)recruitmenid result:(void(^)(MyReleaseRecruitRefreshResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    //[dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmenid forKey:@"recruitmenid"];
    [manager POST:zhaopinRefresh parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
       
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];
    




}
//我的发布 简历刷新
+(void)sendMyReleaseResumeRefreshByResumeid:(NSString*)resumeid result:(void(^)(MyReleaseResumeRefreshResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    //[dic setObject:userid forKey:@"userid"];
    [dic setObject:resumeid forKey:@"resumeid"];
    [manager POST:jianliRefresh parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];



}
+(void)sendMyReleaseEnterpriseRefreshByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(MyReleaseEnterpriseRefreshResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companyid forKey:@"companyid"];
    [manager POST:qiyeRefresh parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
      
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}


//修改密码
+(void)modifyPassWordByPhone:(NSString*)telePhone oldWord:(NSString*)oldWord newWordOne:(NSString*)newWordOne newWordTwo:(NSString*)newWordTwo result:(void(^)(ModifyPassWordResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:telePhone forKey:@"telephone"];
      [dic setObject:oldWord forKey:@"password"];
      [dic setObject:newWordOne forKey:@"newpasswordone"];
      [dic setObject:newWordTwo forKey:@"newpasswordtwo"];
    [manager POST:modifypassword parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
   
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
@end

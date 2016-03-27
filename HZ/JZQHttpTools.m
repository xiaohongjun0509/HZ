//
//  JZQHttpTools.m
//  jzq
//
//  Created by boruijie on 14/12/22.
//  Copyright (c) 2014年 FEIO_66. All rights reserved.
//

#import "JZQHttpTools.h"
#import "AFNetworking.h"

@implementation JZQHttpTools

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager new];
    AFHTTPRequestOperation *op = [manager POST:path parameters:params
                                       success:^(AFHTTPRequestOperation *operation, id responseObject)
                                  {
                                      if (success)
                                      {
                                         
                                       
                                         
                                          
                                          success(responseObject);
                                      }
                                  }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                  {
                                      if (error)
                                      {
                                          failure(error);
                                      }
                                  }];
    [op start];
    
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager new];
    AFHTTPRequestOperation *op = [manager GET:path parameters:params
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
                                  {
                                      if (success)
                                      {
                                          success(responseObject);
                                      }
                                  }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                  {
                                      if (error)
                                      {
                                          failure(error);
                                      }
                                  }];
    [op start];
}

@end

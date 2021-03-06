//
//  NetworkManager.h
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+(instancetype)manager;

-(void)startRequest:(NSString *)url completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
-(void)postRequest:(NSString *)url parameters:(id)parameters completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;

-(void)postRequest:(NSString *)url completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;

@end

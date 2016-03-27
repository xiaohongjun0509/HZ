//
//  HZUserModel.h
//  HZ
//
//  Created by hongjunxiao on 16/3/27.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZUserManager : NSObject

+(instancetype)manager;

- (void)setName:(NSString *)name;
-(NSString *)name;
-(void)setPasswd:(NSString *)passwd;
- (NSString *)passwd;

@property (nonatomic, copy) NSString *userid;


@end

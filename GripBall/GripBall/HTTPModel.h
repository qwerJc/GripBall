//
//  HTTPModel.h
//  GripBall
//
//  Created by 贾辰 on 2018/3/16.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HTTPModel : NSObject

//手机号验证
+(void)getVcodeWithTelNum:(NSString *)telNum
                                 Completion:(void (^)(void))completionBlock
                                      error:(void (^)(NSError *))errorBlock;

//注册
+(void)registerWithTelNum:(NSString *)telNum
               andVCode:(NSString *)vcode
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *))errorBlock;

//登陆
+(void)logInWithTelNum:(NSString *)telNum
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *,int))errorBlock;
//完善信息
+(void)completeInformationWithUid:(NSString *)uid
                          andName:(NSString *)name
                           andSex:(NSString *)sex
                      andBirthday:(NSString *)birthday
                        andHeight:(NSString *)height
                        andWeight:(NSString *)weight
                        andTelNum:(NSString *)telNum;
@end

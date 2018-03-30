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
+(HTTPModel *)shareHttpModel;
//手机号验证
-(void)getVcodeWithTelNum:(NSString *)telNum
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *))errorBlock;

//注册
-(void)registerWithTelNum:(NSString *)telNum
               andVCode:(NSString *)vcode
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *))errorBlock;
//设置密码
-(void)setPassWordWith:(NSString *)uid
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *))errorBlock;
//登陆
-(void)logInWithTelNum:(NSString *)telNum
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *,int))errorBlock;
//完善信息
-(void)completeInformationWithUid:(NSString *)uid
                          andName:(NSString *)name
                           andSex:(NSString *)sex
                      andBirthday:(NSString *)birthday
                        andHeight:(NSString *)height
                        andWeight:(NSString *)weight
                        andTelNum:(NSString *)telNum;

//更改信息
-(void)changeInformationWithUid:(NSString *)uid
                        andName:(NSString *)name
                         andSex:(NSString *)sex
                    andBirthday:(NSString *)birthday
                      andHeight:(NSString *)height
                      andWeight:(NSString *)weight
                      andTelNum:(NSString *)telNum;
//新建角色
-(void)addUserWithUid:(NSString *)uid
              andName:(NSString *)name
               andSex:(NSString *)sex
          andBirthday:(NSString *)birthday
            andHeight:(NSString *)height
            andWeight:(NSString *)weight;
//切换角色
-(void)changeUserWithUid:(NSString *)uid
                  andRid:(NSString *)rid;

//获取角色列表
-(void)getUserList:(NSString *)uid;
//上传练习记录
-(void)postPracticeRecordWithRid:(NSString *)rid
                     andtimecost:(NSString *)usedTime
                        andCount:(NSString *)count;
//上传测试记录
//上传爆发力记录
//上传耐力纪录
@end

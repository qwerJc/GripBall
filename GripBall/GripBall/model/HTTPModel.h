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
                    error:(void (^)(NSError *,int))errorBlock;

//01-注册 (uid)
-(void)registerWithTelNum:(NSString *)telNum
               andVCode:(NSString *)vcode
               Completion:(void (^)(NSString *))completionBlock
                    error:(void (^)(NSError *,int))errorBlock;
//06-设置密码
-(void)setPassWordWith:(NSString *)uid
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *))errorBlock;
//02-登陆 (uid,rid)
-(void)logInWithTelNum:(NSString *)telNum
                andPwd:(NSString *)pwd
            Completion:(void (^)(NSString *,NSString *))completionBlock
                 error:(void (^)(NSError *,int))errorBlock;
//03-完善信息
-(void)completeInformationWithUid:(NSString *)uid
                          andName:(NSString *)name
                           andSex:(NSString *)sex
                      andBirthday:(NSString *)birthday
                        andHeight:(NSString *)height
                        andWeight:(NSString *)weight
                        andTelNum:(NSString *)telNum
                       Completion:(void (^)(void))completionBlock
                            error:(void (^)(NSError *))errorBlock;

//03-更改信息
-(void)changeInformationWithUid:(NSString *)uid
                        andName:(NSString *)name
                         andSex:(NSString *)sex
                    andBirthday:(NSString *)birthday
                      andHeight:(NSString *)height
                      andWeight:(NSString *)weight
                      andTelNum:(NSString *)telNum
                     Completion:(void (^)(void))completionBlock
                          error:(void (^)(NSError *))errorBlock;
//04-新建角色
-(void)addUserWithUid:(NSString *)uid
              andName:(NSString *)name
               andSex:(NSString *)sex
          andBirthday:(NSString *)birthday
            andHeight:(NSString *)height
            andWeight:(NSString *)weight
           Completion:(void (^)(void))completionBlock
                error:(void (^)(NSError *))errorBlock;
//05-切换角色
-(void)changeUserWithUid:(NSString *)uid
                  andRid:(NSString *)rid
              Completion:(void (^)(NSArray *arr))completionBlock
                   error:(void (^)(NSError *))errorBlock;

//07-获取角色列表 arr:所有用户的信息
-(void)getUserList:(NSString *)uid
        Completion:(void (^)(NSArray *arr))completionBlock
             error:(void (^)(NSError *,int))errorBlock;

//08 - 上传练习记录
//usedTime - 用时
//count - 次数
//value - 平均握力
-(void)postPracticeRecordWithRid:(NSString *)rid
                     andtimecost:(NSString *)usedTime
                        andCount:(NSString *)count
                        andValue:(NSString *)value
                      Completion:(void (^)(void))completionBlock
                           error:(void (^)(NSError *,int))errorBlock;
//09 - 上传测试记录
-(void)postTestRecordWithRid:(NSString *)rid
            andLeftHandValue:(NSString *)lHandValue
            andLeftHandScore:(NSString *)lHandScore
           andRightHandValue:(NSString *)rHandValue
           andRightHandScore:(NSString *)rHandScore
                  Completion:(void (^)(void))completionBlock
                       error:(void (^)(NSError *,int))errorBlock;
//010 - 上传爆发力记录
-(void)postExplodeWithRid:(NSString *)rid
         andLeftHandValue:(NSString *)lHandValue
      andLeftHandCostTime:(NSString *)lHandCostTime
        andRightHandValue:(NSString *)rHandValue
     andRightHandCostTime:(NSString *)rHandCostTime
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *,int))errorBlock;
//011 - 上传耐力纪录
-(void)postEnduranceWithRid:(NSString *)rid
           andLeftHandValue:(NSString *)lHandValue
        andLeftHandCostTime:(NSString *)lHandCostTime
          andRightHandValue:(NSString *)rHandValue
       andRightHandCostTime:(NSString *)rHandCostTime
                 Completion:(void (^)(void))completionBlock
                      error:(void (^)(NSError *,int))errorBlock;
@end

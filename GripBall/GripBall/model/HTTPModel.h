//
//  HTTPModel.h
//  GripBall
//
//  Created by 贾辰 on 2018/3/16.
//  Copyright © 2018年 贾辰. All rights reserved.
//
// uid 8,11

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HTTPModel : NSObject
+(HTTPModel *)shareHttpModel;
//手机号验证(ok)
-(void)getVcodeWithTelNum:(NSString *)telNum
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *,int))errorBlock;

//01-注册 (set uid)
-(void)registerWithTelNum:(NSString *)telNum
               andVCode:(NSString *)vcode
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *,int))errorBlock;
//06-设置密码
-(void)setPassWordWithPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *,int))errorBlock;
//02-登陆(ok) (返回 uid,rid)
-(void)logInWithTelNum:(NSString *)telNum
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *,int))errorBlock;
//03-完善信息
-(void)completeInformationWithName:(NSString *)name
                           andSex:(NSString *)sex
                      andBirthday:(NSString *)birthday
                        andHeight:(NSString *)height
                        andWeight:(NSString *)weight
                        andTelNum:(NSString *)telNum
                       Completion:(void (^)(void))completionBlock
                            error:(void (^)(NSError *,int))errorBlock;

//03-更改信息
-(void)changeInformationWithName:(NSString *)name
                         andSex:(NSString *)sex
                    andBirthday:(NSString *)birthday
                      andHeight:(NSString *)height
                      andWeight:(NSString *)weight
                      andTelNum:(NSString *)telNum
                     Completion:(void (^)(void))completionBlock
                          error:(void (^)(NSError *,int))errorBlock;
//04-新建角色(ok)
-(void)addUserWithName:(NSString *)name
               andSex:(NSString *)sex
          andBirthday:(NSString *)birthday
            andHeight:(NSString *)height
            andWeight:(NSString *)weight
           Completion:(void (^)(void))completionBlock
                error:(void (^)(NSError *,int))errorBlock;
//05-切换角色 
-(void)changeUserWithUid:(NSString *)uid
                  andRid:(NSString *)rid
              Completion:(void (^)(void))completionBlock
                   error:(void (^)(NSError *,int))errorBlock;

//07-获取角色列表 arr:所有用户的信息(不包括测力成绩)
-(void)getUserListWithCompletion:(void (^)(NSArray *arr))completionBlock
             error:(void (^)(NSError *,int))errorBlock;

//08 - 上传练习记录
//usedTime - 用时
//count - 次数
//value - 平均握力
-(void)postPracticeRecordWithTimecost:(NSString *)usedTime
                        andCount:(NSString *)count
                        andValue:(NSString *)value
                      Completion:(void (^)(void))completionBlock
                           error:(void (^)(NSError *,int))errorBlock;
//09 - 上传测试记录
-(void)postTestRecordWithLeftHandValue:(NSString *)lHandValue
            andLeftHandScore:(NSString *)lHandScore
           andRightHandValue:(NSString *)rHandValue
           andRightHandScore:(NSString *)rHandScore
                  Completion:(void (^)(void))completionBlock
                       error:(void (^)(NSError *,int))errorBlock;
//010 - 上传爆发力记录
-(void)postExplodeWithLeftHandValue:(NSString *)lHandValue
      andLeftHandCostTime:(NSString *)lHandCostTime
        andRightHandValue:(NSString *)rHandValue
     andRightHandCostTime:(NSString *)rHandCostTime
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *,int))errorBlock;
//011 - 上传耐力纪录
-(void)postEnduranceWithLeftHandValue:(NSString *)lHandValue
        andLeftHandCostTime:(NSString *)lHandCostTime
          andRightHandValue:(NSString *)rHandValue
       andRightHandCostTime:(NSString *)rHandCostTime
                 Completion:(void (^)(void))completionBlock
                      error:(void (^)(NSError *,int))errorBlock;
//删除角色
-(void)deleteRoleWith:(NSNumber *)uid
               andRid:(NSNumber *)rid
           Completion:(void (^)(void))completionBlock
                error:(void (^)(NSError *,int))errorBlock;
//获取爆发力排行榜
-(void)getExplodeListWithCompletion:(void (^)(void))completionBlock
                              error:(void (^)(NSError *,int))errorBlock;
//获取耐力排行榜
-(void)getEnduranceListWithCompletion:(void (^)(void))completionBlock
                              error:(void (^)(NSError *,int))errorBlock;
@end

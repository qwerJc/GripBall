//
//  HTTPModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/3/16.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "HTTPModel.h"
#import "ModelLocator.h"

#define SERVER_IP @"http://120.79.133.38:8089"

@implementation HTTPModel
+(HTTPModel *)shareHttpModel{
    static dispatch_once_t onceToken;
    static HTTPModel *assistant = nil;
    if (assistant == nil) {
        dispatch_once(&onceToken, ^{
            assistant = [[HTTPModel alloc] init];
        });
    }
    return assistant;
}

-(void)getVcodeWithTelNum:(NSString *)telNum
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *,int))errorBlock{
    
    /** 获取验证码
     *  GET：
     *  code:
     *    1、注册成功
     *    2、已注册
     *    3、未知错误
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString *getVersionURL = [REACT_NATIVE_HOTUPDATE_ROOTURL stringByAppendingString:@"/ReactNatieWallPage/GetVersion.php"];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_verification_code?phone=%@", SERVER_IP, telNum];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSString *code = (NSString *)[listDic objectForKey:@"code"];
             if([code isEqualToString:@"1"]){
                 completionBlock();
             }else if([code isEqualToString:@"2"]){
                 errorBlock(error,2);
             }else{
                 errorBlock(error,3);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}


-(void)registerWithTelNum:(NSString *)telNum
               andVCode:(NSString *)vcode
             Completion:(void (^)(NSString *))completionBlock
                  error:(void (^)(NSError *,int))errorBlock{
    /** 注册
     *  地址： /stressapp/api/register?phone=’’&vcode=’’
     *  GET：
     *  code:
     *    1、注册成功
     *    2、该手机号已注册
     *    3、验证码错误
     *    4、验证码过期失效
          5、未知错误
     *  返回：
            uid
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/register?phone=%@&vcode=%@", SERVER_IP, telNum,vcode];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSString *code = (NSString *)[listDic objectForKey:@"code"];
             if([code isEqualToString:@"1"]){
                 NSString *uid = (NSString *)[listDic objectForKey:@"uid"];
                 completionBlock(uid);
             }else if([code isEqualToString:@"2"]){
                 errorBlock(error,2);
             }else if([code isEqualToString:@"3"]){
                 errorBlock(error,3);
             }else if([code isEqualToString:@"4"]){
                 errorBlock(error,4);
             }else{
                 errorBlock(error,5);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}

//mei ce
-(void)setPassWordWith:(NSString *)uid
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *))errorBlock
{
    /** 设置密码
     *  地址： /stressapp/api/reset_pwd
     *  Post：
     *  uid
     *  pwd
     *  completionBlock        请求成功的回调
     *  errorBlock             请求失败的回调
     */
    //Post
    NSDictionary *params = @{
                              @"uid" :uid,
                              @"pwd":pwd
                              };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/reset_pwd", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
    
}

//***************************【可能成功的block还需要返回四种模式的数组】*****************
-(void)logInWithTelNum:(NSString *)telNum
                andPwd:(NSString *)pwd
            Completion:(void (^)(NSString *,NSString *))completionBlock
                 error:(void (^)(NSError *,int))errorBlock{
    /** 登陆
     *  地址： /stressapp/api/login?phone=’’&pwd=’’
     *  GET：
     *  code:
     *    1、登陆成功
     *    2、账户不存在或密码错误
     *    3、未知错误
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/login?phone=%@&pwd=%@", SERVER_IP, telNum,pwd];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSLog(@"Dic :%@", listDic);
             NSString *code = (NSString *)[listDic objectForKey:@"code"];

             if ([code isEqualToString:@"1"]) {
                 NSString *uid = (NSString *)[listDic objectForKey:@"uid"];
                 NSString *rid = (NSString *)[listDic objectForKey:@"rid"];
                 completionBlock(uid,rid);
             }else if([code isEqualToString:@"2"]){
                 errorBlock(nil,2);
             }else{
                 errorBlock(nil,3);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
    
}
//03-完善信息
-(void)completeInformationWithUid:(NSString *)uid
                          andName:(NSString *)name
                           andSex:(NSString *)sex
                      andBirthday:(NSString *)birthday
                        andHeight:(NSString *)height
                        andWeight:(NSString *)weight
                        andTelNum:(NSString *)telNum
                       Completion:(void (^)(void))completionBlock
                            error:(void (^)(NSError *))errorBlock
{
    /** 完善个人信息
     *  地址： /stressapp/api/complete_roleinfo
     *  Post
     */
    //Post
    NSDictionary *params = @{
                             @"uid" :uid,
                             @"name":name,
                             @"sex":sex,
                             @"birthday":birthday,
                             @"height":height,
                             @"weight":weight,
                             @"phone":telNum,
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/complete_roleinfo", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//更改信息
-(void)changeInformationWithUid:(NSString *)uid
                        andName:(NSString *)name
                         andSex:(NSString *)sex
                    andBirthday:(NSString *)birthday
                      andHeight:(NSString *)height
                      andWeight:(NSString *)weight
                      andTelNum:(NSString *)telNum
                     Completion:(void (^)(void))completionBlock
                          error:(void (^)(NSError *))errorBlock
{
    /** 修改个人信息
     *  地址： /stressapp/api/modify_profile
     *  Post
     */
    NSDictionary *params = @{
                             @"uid" :uid,
                             @"name":name,
                             @"sex":sex,
                             @"birthday":birthday,
                             @"height":height,
                             @"weight":weight,
                             @"phone":telNum,
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/modify_profile", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//添加角色
-(void)addUserWithUid:(NSString *)uid
              andName:(NSString *)name
               andSex:(NSString *)sex
          andBirthday:(NSString *)birthday
            andHeight:(NSString *)height
            andWeight:(NSString *)weight
           Completion:(void (^)(void))completionBlock
                error:(void (^)(NSError *))errorBlock
{
    
    /** 添加角色
     *  地址： /stressapp/api/add_new_role
     *  Post
     */
    
    NSDictionary *params = @{
                             @"uid" :uid,
                             @"name":name,
                             @"sex":sex,
                             @"birthday":birthday,
                             @"height":height,
                             @"weight":weight,
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/add_new_role", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//****************************【这里应该是获取四种模式的接口】*************8
//05 - 切换角色
-(void)changeUserWithUid:(NSString *)uid
                  andRid:(NSString *)rid
              Completion:(void (^)(NSArray *))completionBlock
                   error:(void (^)(NSError *))errorBlock
{
    /** 切换角色
     *  地址： /stressapp/api/switch_role
     *  Post
     */
}

//07 - 获取角色列表 （数据中仅含用户信息列表）
-(void)getUserList:(NSString *)uid
        Completion:(void (^)(NSArray *))completionBlock
             error:(void (^)(NSError *,int))errorBlock
{
    /** 切换角色
     *  地址： /stressapp/api/get_role_list?uid=
     *  Get
     *  code:
     *    1、获取成功，返回所有用户列表
     *    2、获取失败
     *
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_role_list?uid=%@", SERVER_IP, uid];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSString *code = (NSString *)[listDic objectForKey:@"code"];
             if ([code isEqualToString:@"1"]) {
                 NSArray *arrAllRole = [listDic objectForKey:@"allrole"];
                 completionBlock(arrAllRole);
             }else{
                 errorBlock(nil,2);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             NSLog(@"%@",error);  //这里打印错误信息
         }];
}

//08 - Practice
-(void)postPracticeRecordWithRid:(NSString *)rid
                     andtimecost:(NSString *)usedTime
                        andCount:(NSString *)count
                        andValue:(NSString *)value
                      Completion:(void (^)(void))completionBlock
                           error:(void (^)(NSError *, int))errorBlock
{
    NSDictionary *params = @{
                             @"rid" :rid,
                             @"timecost":usedTime,
                             @"times":count,
                             @"meanvalue":value,
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/practice_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//09 - Test
-(void)postTestRecordWithRid:(NSString *)rid
            andLeftHandValue:(NSString *)lHandValue
            andLeftHandScore:(NSString *)lHandScore
           andRightHandValue:(NSString *)rHandValue
           andRightHandScore:(NSString *)rHandScore
                  Completion:(void (^)(void))completionBlock
                       error:(void (^)(NSError *, int))errorBlock
{
    NSDictionary *params = @{
                             @"rid" :rid,
                             @"lefthand_value":lHandValue,
                             @"lefthand_score":lHandScore,
                             @"righthand_value":rHandValue,
                             @"righthand_score":rHandScore,
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/test_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//010 - explode
-(void)postExplodeWithRid:(NSString *)rid
         andLeftHandValue:(NSString *)lHandValue
      andLeftHandCostTime:(NSString *)lHandCostTime
        andRightHandValue:(NSString *)rHandValue
     andRightHandCostTime:(NSString *)rHandCostTime
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *, int))errorBlock
{
    NSDictionary *params = @{
                             @"rid" :rid,
                             @"explosive_lefthand_val":lHandValue,
                             @"explosive_lefthand_timecost":lHandCostTime,
                             @"explosive_righthand_val":rHandValue,
                             @"explosive_righthand_timecost":rHandCostTime,
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/explosive_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//011 - endurance
-(void)postEnduranceWithRid:(NSString *)rid
           andLeftHandValue:(NSString *)lHandValue
        andLeftHandCostTime:(NSString *)lHandCostTime
          andRightHandValue:(NSString *)rHandValue andRightHandCostTime:(NSString *)rHandCostTime
                 Completion:(void (^)(void))completionBlock
                      error:(void (^)(NSError *, int))errorBlock
{
    NSDictionary *params = @{
                             @"rid" :rid,
//                             @"stamina_lefthand_val":lHandValue,
                             @"stamina_lefthand_duration":lHandCostTime,
//                             @"stamina_righthand_val":rHandValue,
                             @"stamina_righthand_duration":rHandCostTime,
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/stamina_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = (NSString *)[listDic objectForKey:@"code"];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}
@end

//
//  HTTPModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/3/16.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "HTTPModel.h"
#import "ModelLocator.h"
#import "UserInfoModel.h"

#define SERVER_IP @"http://120.79.133.38:8089"

@implementation HTTPModel
// 废弃
-(void)registerWithTelNum:(NSString *)telNum
                 andVCode:(NSString *)vcode
               Completion:(void (^)(void))completionBlock
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
             
             NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
             if([code isEqualToString:@"1"]){
                 
                 NSNumber *uid = [listDic objectForKey:@"uid"];
                 [model setUid:uid];
                 
                 completionBlock();
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
             errorBlock(error,-1);
         }];
}

// 废弃
-(void)setPassWordWithPwd:(NSString *)pwd
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *,int))errorBlock
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
                             @"uid" :[model uid],
                             @"pwd":pwd
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/reset_pwd", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);  //这里打印错误信息
        errorBlock(error,-1);
    }];
    
}
// 废弃
//03-完善信息
-(void)completeInformationWithName:(NSString *)name
                            andSex:(NSString *)sex
                       andBirthday:(NSString *)birthday
                         andHeight:(NSString *)height
                         andWeight:(NSString *)weight
                         andTelNum:(NSString *)telNum
                        Completion:(void (^)(void))completionBlock
                             error:(void (^)(NSError *,int))errorBlock
{
    /** 完善个人信息
     *  地址： /stressapp/api/complete_roleinfo
     *  Post
     */
    //Post
    NSNumber *numSex ;
    if ([sex isEqualToString:@"男"]) {
        numSex = [NSNumber numberWithInt:0];
    }else{
        numSex = [NSNumber numberWithInt:1];
    }
    
    //string 转 number的格式
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSMutableDictionary *params = [@{
                                     @"uid" :[model uid],
                                     @"name":name,
                                     @"sex":numSex,
                                     @"birthday":birthday,
                                     @"height":[numberFormatter numberFromString:height],
                                     @"weight":[numberFormatter numberFromString:weight],
                                     @"phone":telNum,
                                     @"headimg":@""
                                     } mutableCopy];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/complete_roleinfo", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

////////////////////////////////////////////////////////////////////

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
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_verification_code?phone=%@", SERVER_IP, telNum];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
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
             errorBlock(error,-1);
         }];
}

//验证 验证码
-(void)checkVcodeWithvcode:(NSString *)vcode
                  andPhone:(NSString *)phone
                Completion:(void (^)(void))completionBlock
                     error:(void (^)(NSError *, int))errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/check_vcode?phone=%@&vcode=%@", SERVER_IP, phone,vcode];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
             if([code isEqualToString:@"1"]){
                 completionBlock();
             }else {
                 errorBlock(error,2);
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             NSLog(@"%@",error);  //这里打印错误信息
             errorBlock(error,-1);
         }];
}

-(void)registerWithPhone:(NSString *)phone
                  andPwd:(NSString *)pwd
                 andName:(NSString *)name
                  andSex:(NSString *)sex
             andBirthday:(NSString *)birthday
               andHeight:(NSString *)height
               andWeight:(NSString *)weight
              Completion:(void (^)(void))completionBlock
                   error:(void (^)(NSError *, int))errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSNumber *numSex ;
    if ([sex isEqualToString:@"男"]) {
        numSex = [NSNumber numberWithInt:0];
    }else{
        numSex = [NSNumber numberWithInt:1];
    }
    //string 转 number的格式
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{@"phone" :phone,
                             @"pwd":pwd,
                             @"name":name,
                             @"sex":numSex,
                             @"birthday":birthday,
                             @"height":[numberFormatter numberFromString:height],
                             @"weight":[numberFormatter numberFromString:height],
                             @"headimg":@"",
                             @"phone_s":phone
                             };
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/register", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}


//***************************【可能成功的block还需要返回四种模式的数组】*****************
-(void)logInWithTelNum:(NSString *)telNum
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
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
             
             NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];

             if ([code isEqualToString:@"1"]) {
                 NSNumber *uid = [listDic objectForKey:@"uid"];
                 NSNumber *rid = [listDic objectForKey:@"rid"];
                 
                 [model setUid:uid];
                 [model setRid:rid];
                 
                 NSDictionary *dicUserInfo = [listDic objectForKey:@"role"];
                 UserInfoModel *userModel = [[UserInfoModel alloc] initWithDic:dicUserInfo];
                 [model setUserInfo:userModel];
                 
//                 NSArray *arrExplode = [listDic objectForKey:@"explosive"];
//                 NSArray *arrPractice = [listDic objectForKey:@"practice"];
//                 NSArray *arrEndurance = [listDic objectForKey:@"stamina"];
                 
//                 NSArray *arrTest = [listDic objectForKey:@"test"];
//                 [model setTestList:arrTest];
//                 NSLog(@"list :%@",[[[model getTestList] objectAtIndex:1] getLeftScore]);
                 
                 
                 
//                 NSString *sDay = [userInfo objectAtIndex:4];
//                 NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//                 fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
//                 NSDate *someDay = [fmt dateFromString:sDay];
//                 NSLog(@"someDay : %@", someDay);
//                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                 // 设置日期格式
//                 [formatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
//                 NSString *currentDateString = [formatter stringFromDate:someDay];
//                 NSLog(@"%@",currentDateString);
//
//                 NSLog(@"info :%@", userInfo);
                 
                 completionBlock();
             }else if([code isEqualToString:@"2"]){
                 errorBlock(nil,2);
             }else{
                 errorBlock(nil,3);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             errorBlock(error,-1);
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
    
}


//更改信息
-(void)changeInformationWithName:(NSString *)name
                         andSex:(NSString *)sex
                    andBirthday:(NSString *)birthday
                      andHeight:(NSString *)height
                      andWeight:(NSString *)weight
                     Completion:(void (^)(void))completionBlock
                          error:(void (^)(NSError *,int))errorBlock
{
    /** 修改个人信息
     *  地址： /stressapp/api/modify_profile
     *  Post
     */
    NSNumber *numSex ;
    if ([sex isEqualToString:@"男"]) {
        numSex = [NSNumber numberWithInt:0];
    }else{
        numSex = [NSNumber numberWithInt:1];
    }
    
    //string 转 number的格式
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    
    NSDictionary *params = @{@"rid" :[[model userInfo] getRid],
                             @"name":name,
                             @"sex":numSex,
                             @"birthday":birthday,
                             @"height":[numberFormatter numberFromString:height],
                             @"weight":[numberFormatter numberFromString:height],
                             @"headimg":@"",
                             @"phone":[model telephone]
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/modify_profile", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[model uid]);
        NSLog(@"%@",error);  //这里打印错误信息
        errorBlock(error,-1);
    }];
}

//添加角色
-(void)addUserWithName:(NSString *)name
               andSex:(NSString *)sex
          andBirthday:(NSString *)birthday
            andHeight:(NSString *)height
            andWeight:(NSString *)weight
           Completion:(void (^)(void))completionBlock
                error:(void (^)(NSError *,int))errorBlock
{
    
    /** 添加角色
     *  地址： /stressapp/api/add_new_role
     *  Post
     */
    NSNumber *numSex ;
    if ([sex isEqualToString:@"男"]) {
        numSex = [NSNumber numberWithInt:0];
    }else{
        numSex = [NSNumber numberWithInt:1];
    }
    
    //string 转 number的格式
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{
                             @"uid" :[[model userInfo] getUid],
                             @"name":name,
                             @"sex":numSex,
                             @"birthday":birthday,
                             @"height":[numberFormatter numberFromString:height],
                             @"weight":[numberFormatter numberFromString:height],
                             @"headimg":@"",
                             @"phone":[model telephone]
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/add_new_role", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//****************************【这里应该是获取四种模式的接口】*************8
//05 - 切换角色
-(void)changeUserWithUid:(NSString *)uid
                  andRid:(NSString *)rid
              Completion:(void (^)(void))completionBlock
                   error:(void (^)(NSError *,int))errorBlock
{
    /** 切换角色
     *  地址： /stressapp/api/switch_role
     *  Post
     */
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{
                             @"uid" :[numberFormatter numberFromString:uid],
                             @"rid":[numberFormatter numberFromString:rid],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/switch_role", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            
            NSDictionary *dicUserInfo = [listDic objectForKey:@"role"];
            UserInfoModel *userModel = [[UserInfoModel alloc] initWithDic:dicUserInfo];
            [model setUserInfo:userModel];
            
            NSNumber *uid = [listDic objectForKey:@"uid"];
            NSNumber *rid = [listDic objectForKey:@"rid"];
            
            [model setUid:uid];
            [model setRid:rid];
            
            completionBlock();
        }else if([code isEqualToString:@"2"]){
            errorBlock(error,2);
        }else{
            errorBlock(error,3);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//07 - 获取角色列表 （数据中仅含用户信息列表）
-(void)getUserListWithCompletion:(void (^)(NSArray *))completionBlock
             error:(void (^)(NSError *,int))errorBlock
{
    /** 获取角色列表
     *  地址： /stressapp/api/get_role_list?uid=
     *  Get
     *  code:
     *    1、获取成功，返回所有用户列表
     *    2、获取失败
     *
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_role_list?uid=%@", SERVER_IP,[[model userInfo] getUid]];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
             
             if ([code isEqualToString:@"1"]) {
                 NSArray *arrAllRole = [listDic objectForKey:@"roles"];
                 
                 NSLog(@"role:%@",arrAllRole);
                 
                 completionBlock(arrAllRole);
             }else{
                 errorBlock(nil,2);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             errorBlock(error,-1);
             NSLog(@"%@",error);  //这里打印错误信息
         }];
}

//08 - Practice
-(void)postPracticeRecordWithTimecost:(NSString *)usedTime
                        andCount:(NSString *)count
                        andValue:(NSString *)value
                      Completion:(void (^)(void))completionBlock
                           error:(void (^)(NSError *, int))errorBlock
{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{
                             @"rid" :[[model userInfo] getRid],
                             @"timecost":[numberFormatter numberFromString:usedTime],
                             @"times":[numberFormatter numberFromString:count],
                             @"meanvalue":[numberFormatter numberFromString:value],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/practice_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error :%@",error);
        errorBlock(error,-1);
    }];
}

//09 - Test
-(void)postTestRecordWithLeftHandValue:(NSString *)lHandValue
            andLeftHandScore:(NSString *)lHandScore
           andRightHandValue:(NSString *)rHandValue
           andRightHandScore:(NSString *)rHandScore
                  Completion:(void (^)(void))completionBlock
                       error:(void (^)(NSError *, int))errorBlock
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{
                             @"rid" :[[model userInfo] getRid],
                             @"lefthand_value":[numberFormatter numberFromString:lHandValue],
                             @"lefthand_score":[numberFormatter numberFromString:lHandScore],
                             @"righthand_value":[numberFormatter numberFromString:rHandValue],
                             @"righthand_score":[numberFormatter numberFromString:rHandScore],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/test_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
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
-(void)postExplodeWithLeftHandValue:(NSString *)lHandValue
      andLeftHandCostTime:(NSString *)lHandCostTime
        andRightHandValue:(NSString *)rHandValue
     andRightHandCostTime:(NSString *)rHandCostTime
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *, int))errorBlock
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{
                             @"rid" :[[model userInfo] getRid],
                             @"explosive_lefthand_val":[numberFormatter numberFromString:lHandValue],
                             @"explosive_lefthand_timecost":[numberFormatter numberFromString:lHandCostTime],
                             @"explosive_righthand_val":[numberFormatter numberFromString:rHandValue],
                             @"explosive_righthand_timecost":[numberFormatter numberFromString:rHandCostTime],
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/explosive_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
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
-(void)postEnduranceWithLeftHandValue:(NSString *)lHandValue
        andLeftHandCostTime:(NSString *)lHandCostTime
          andRightHandValue:(NSString *)rHandValue andRightHandCostTime:(NSString *)rHandCostTime
                 Completion:(void (^)(void))completionBlock
                      error:(void (^)(NSError *, int))errorBlock
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{
                             @"rid" :[[model userInfo] getRid],
                             @"stamina_lefthand_val":[numberFormatter numberFromString:lHandValue],
                             @"stamina_lefthand_duration":[numberFormatter numberFromString:lHandCostTime],
                             @"stamina_righthand_val":[numberFormatter numberFromString:rHandValue],
                             @"stamina_righthand_duration":[numberFormatter numberFromString:rHandCostTime],
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/upload/stamina_record", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//012-删除角色
-(void)deleteRoleWithUid:(NSString *)uid andRid:(NSString *)rid Completion:(void (^)(void))completionBlock error:(void (^)(NSError *, int))errorBlock{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDictionary *params = @{
                             @"uid" :[numberFormatter numberFromString:uid],
                             @"rid":[numberFormatter numberFromString:rid],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/delete_role", SERVER_IP];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        if([code isEqualToString:@"1"]){
            completionBlock();
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//013-获取爆发力排行榜
-(void)getExplodeListWithCompletion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *, int))errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_ranklist_explosive", SERVER_IP];
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        
        NSArray *list = [listDic objectForKey:@"list"];
        if([code isEqualToString:@"1"]){
            completionBlock(list);
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}
//014-获取耐力排行榜
-(void)getEnduranceListWithCompletion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *, int))errorBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_ranklist_stamina", SERVER_IP];
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
        NSArray *list = [listDic objectForKey:@"list"];
        
        if([code isEqualToString:@"1"]){
            completionBlock(list);
        }else{
            errorBlock(error,2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error,-1);
    }];
}

//获取最近的30条纪录
-(void)getLastestRecordWithCompletion:(void (^)(NSArray *))completionBlock
                                error:(void (^)(NSError *, int))errorBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_latest_record?rid=%@", SERVER_IP, [[model userInfo] getRid]];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSArray *arr = [listDic objectForKey:@"all_record"];
             
             NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
             if([code isEqualToString:@"1"]){
                 completionBlock(arr);
             }else {
                 errorBlock(error,2);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             errorBlock(error,-1);
         }];
}
//获取三种趋势
/*
 explosive =     (
 {
 date = "Sat, 07 Apr 2018 11:06:05 GMT";
 lcost = 5;
 lval = 10;
 rcost = 12;
 rval = 15;
 },
 {
 date = "Tue, 10 Apr 2018 15:47:15 GMT";
 lcost = 5;
 lval = 10;
 rcost = 12;
 rval = 15;
 }
 );

 ////////////
 test =     (
 {
 date = "Sat, 07 Apr 2018 10:42:31 GMT";
 lval = 10;
 rval = 15;
 },
 {
 date = "Tue, 10 Apr 2018 15:42:16 GMT";
 lval = 100;
 rval = 15;
 }
 );
/////////////////////
 {
 date = "Sat, 07 Apr 2018 11:51:23 GMT";
 lval = 5;
 rval = 12;
 },
 {
 date = "Tue, 10 Apr 2018 15:51:36 GMT";
 lval = 5;
 rval = 12;
 }
 );
 
 */
-(void)getTendencyWithCompletion:(void (^)(NSArray *testArr,NSArray *explodeArr,NSArray *enduranceArr))completion
                           error:(void (^)(NSError *, int))errorBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/get_daily_record?rid=%@", SERVER_IP, [[model userInfo] getRid]];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSArray *arrTest = [listDic objectForKey:@"test"];
             NSArray *arrExplode = [listDic objectForKey:@"explosive"];
             NSArray *arrEndutance = [listDic objectForKey:@"stamina"];
             
             
             [model setTestList:arrTest];
             [model setExplodeList:arrExplode];
             [model setEnduranceList:arrEndutance];
             
             NSLog(@"listDic:%@",listDic);
             
             NSString *code = [NSString stringWithFormat:@"%@",[listDic objectForKey:@"code"]];
             if([code isEqualToString:@"1"]){

                 completion(arrTest,arrExplode,arrEndutance);
             }else {
                 errorBlock(error,2);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             errorBlock(error,-1);
         }];
}

@end

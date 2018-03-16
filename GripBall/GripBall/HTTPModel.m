//
//  HTTPModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/3/16.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "HTTPModel.h"
#import "ModelLocator.h"


@implementation HTTPModel
+(void)getVcodeWithTelNum:(NSString *)telNum
               Completion:(void (^)(void))completionBlock
                    error:(void (^)(NSError *))errorBlock{
    
    /** 获取验证码
     *  GET：
     *  telNum                 用户手机号
     *  completionBlock        请求成功的回调
     *  errorBlock             请求失败的回调
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
             NSString *vcode = (NSString *)[listDic objectForKey:@"vcode"];
             
             NSLog(@"Vcode :%@", vcode);
             
             NSLog(@"code :%@", code);
             NSLog(@"这里打印请求成功要做的事");
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}
//Post
// NSDictionary *params = @{@"name" :telNum};
// [manager POST:url parameters:params progress:nil
//

+(void)registerWithTelNum:(NSString *)telNum
               andVCode:(NSString *)vcode
             Completion:(void (^)(void))completionBlock
                  error:(void (^)(NSError *))errorBlock{
    /** 注册
     *  地址： /stressapp/api/register?phone=’’&vcode=’’
     *  GET：
     *  telNum                 用户手机号
     *  vcode                  用户输入的验证码
     *  completionBlock        请求成功的回调
     *  errorBlock             请求失败的回调
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/stressapp/api/register?phone=%@&vcode=%@", SERVER_IP, telNum,vcode];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
             
             NSLog(@"Dic :%@", listDic);
             NSString *code = (NSString *)[listDic objectForKey:@"code"];
             NSString *uid = (NSString *)[listDic objectForKey:@"uid"];
             
             NSLog(@"Vcode :%@", uid);
             NSLog(@"code :%@", code);
             NSLog(@"这里打印请求成功要做的事");
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}

+(void)logInWithTelNum:(NSString *)telNum
                andPwd:(NSString *)pwd
            Completion:(void (^)(void))completionBlock
                 error:(void (^)(NSError *,int))errorBlock{
    /** 登陆
     *  地址： /stressapp/api/login?phone=’’&pwd=’’
     *  GET：
     *  telNum                 用户手机号
     *  vcode                  用户输入的验证码
     *  completionBlock        请求成功的回调
     *  errorBlock             请求失败的回调
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
             NSString *uid = (NSString *)[listDic objectForKey:@"uid"];
             NSString *rid = (NSString *)[listDic objectForKey:@"rid"];
             
             NSLog(@"code :%@", code);
             NSLog(@"uid :%@", uid);
             NSLog(@"rid :%@", rid);
             
             if ([code isEqualToString:@"2"]) {
                 errorBlock(nil,2);
             }else if ([code isEqualToString:@"3"]){
                 errorBlock(nil,3);
             }else{
                 completionBlock();
             }

         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
    
}


@end

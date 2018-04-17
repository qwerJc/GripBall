//
//  AppDelegate.m
//  GripBall
//
//  Created by 贾辰 on 17/9/25.
//  Copyright © 2017年 贾辰. All rights reserved.
//
//  账号：@"15755396353"
//  密码：@"666888"

#import "AppDelegate.h"
#import "LoginViewController.h"

#import "PracticeBeginViewController.h"
#import "ModelLocator.h"

#import "TendencyViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) LoginViewController *viewController;

@property (strong, nonatomic) PracticeBeginViewController     *tem;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //-----------------[del]===================
//    [self getVCode];
//    [self regist];
//    [self login];
//    [self changeInfo];
//    [model setUid:[NSNumber numberWithInt:11]];
//    [self getAllUser];
//    [self changeInfo];
    
//    // 设置日期格式
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"HH:mm:ss";
//    NSDate *someDay = [fmt dateFromString:@"00:02:59"];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"m"];
//    NSLog(@"time : %@",[formatter stringFromDate:someDay]);

//    TendencyViewController *viewController = [[TendencyViewController alloc] init];
//    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    self.navigationController.navigationBar.hidden = YES;
    //=========================================
    
    self.viewController = [[LoginViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBar.hidden = YES;
    
    self.window = [UIWindow new];
    [self.window makeKeyAndVisible];
    [self.window setFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    return YES;
}
//--------------------------------------
-(void)getVCode{
    [httpModel getVcodeWithTelNum:@"18701459239" Completion:^{
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        if (num == 2) {
            NSLog(@"已注册");
        }else if(num == 3){
            NSLog(@"未知错误");
        }else{
            NSLog(@"请检查当前网络");
        }
    }];
}
//-(void)regist{
//    [httpModel registerWithTelNum:@"18701459239" andVCode:@"60311" Completion:^() {
//        NSLog(@"成功");
//    } error:^(NSError *error, int num) {
//        if (num == 2) {
//            NSLog(@"已注册");
//        }else if(num == 3){
//            NSLog(@"验证码错误");
//        }else if(num == 4){
//            NSLog(@"验证码过期");
//        }else if (num == 5){
//            NSLog(@"未知错误");
//        }else{
//            NSLog(@"请检查当前网络");
//        }
//    }];
//}
//-(void)setPwd{
//    [httpModel setPassWordWithPwd:@"12345" Completion:^{
//        NSLog(@"成功");
//    } error:^(NSError *error, int num) {
//        if (num == 2) {
//            NSLog(@"设置失败");
//        }else{
//            NSLog(@"请检查当前网络");
//        }
//    }];
//}
-(void)login{
    [model setTelephone:@"15755396353"];
    [httpModel logInWithTelNum:[model telephone]
                        andPwd:@"666888"
                    Completion:^{
//                        [self addUser];
                        NSLog(@"登陆成功");
                    }
                         error:^(NSError *error, int num) {
                             if (num == 2 ) {
                                 NSLog(@"账户不存在或密码错误");
                             }else if(num == 3){
                                 NSLog(@"未知错误");
                             }else{
                                 NSLog(@"请检查当前网络");
                             }
                         }];
}
-(void)completeInfo{
//    [httpModel completeInformationWithName:@"try1"
//                                   andSex:@"nan"
//                              andBirthday:@"1990/01/01"
//                                andHeight:@"173"
//                                andWeight:@"83"
//                                andTelNum:@"zzz"
//                               Completion:^{
//                                   NSLog(@"成功");
//                               } error:^(NSError *error, int num) {
//                                   if (num == 2 ) {
//                                       NSLog(@"完善失败");
//                                   }else{
//                                       NSLog(@"请检查当前网络");
//                                   }
//                               }];
}
-(void)changeInfo{
    [httpModel changeInformationWithName:@"try1"
                                 andSex:@"nan"
                            andBirthday:@"1900/01/01"
                              andHeight:@"173"
                              andWeight:@"173"
                             Completion:^{
                                    NSLog(@"成功");
                                } error:^(NSError *error, int num) {
                                    if (num == 2 ) {
                                        NSLog(@"修改失败");
                                    }else{
                                        NSLog(@"请检查当前网络 changeInformation");
                                    }
                                }];
}
-(void)addUser{
    [httpModel addUserWithName:@"try1"
                        andSex:@"nan"
                   andBirthday:@"1900/01/01"
                     andHeight:@"173"
                     andWeight:@"173"
                    Completion:^{
                        NSLog(@"成功");
                    }
                         error:^(NSError *error,int num) {
                             NSLog(@"失败");
                         }];
}

-(void)getAllUser{ //ok
    [httpModel getUserListWithCompletion:^(NSArray *arr) {
        NSLog(@"获取列表成功");
    } error:^(NSError *error, int num) {
        NSLog(@"请检查当前网络");
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

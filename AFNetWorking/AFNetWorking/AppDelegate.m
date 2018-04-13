//
//  AppDelegate.m
//  AFNetWorking
//
//  Created by 贾辰 on 18/1/8.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    NSString *sDay = @"2010-02-02 00:00:00 +0000";
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
////    fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
//    fmt.dateFormat = @"yyyy-mm-dd HH:mm:ss Z";
//    NSDate *someDay = [fmt dateFromString:sDay];
//    NSLog(@"someDay : %@", someDay);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//    // 设置日期格式
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *currentDateString = [formatter stringFromDate:someDay];
//    NSLog(@"%@",currentDateString);
//
    
    return YES;
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

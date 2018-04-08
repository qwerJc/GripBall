//
//  AppDelegate.m
//  GripBall
//
//  Created by 贾辰 on 17/9/25.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#import "PracticeBeginViewController.h"
#import "HTTPModel.h"

@interface AppDelegate ()
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) LoginViewController *viewController;

@property (strong, nonatomic) PracticeBeginViewController     *tem;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //-----------------[del]===================
//    self.tem = [[PracticeBeginViewController alloc] init];
//    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.tem];
    
//    [HTTPModel getVcodeWithTelNum:@"18701459239" Completion:nil error:nil];
//    [HTTPModel registerWithTelNum:@"18701459239" andVCode:@"53686" Completion:nil error:nil];
//    [HTTPModel logInWithTelNum:@"18701459239" andPwd:@"qwer" Completion:nil error:nil];
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*10;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    NSLog(@"%@",curTime);
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

//
//  ShowAllUserViewController.h
//  GripBall
//
//  Created by 贾辰 on 18/3/12.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设置delegate
@protocol ChangeUserDelegate // 代理传值方法
- (void)reloadMainList;
@end


@interface ShowAllUserViewController : UIViewController
@property (nonatomic, weak) id delegate;        //委托代理人，代理一般需使用弱引用(weak)
-(void)setRoleList:(NSMutableArray *)arr;
@end

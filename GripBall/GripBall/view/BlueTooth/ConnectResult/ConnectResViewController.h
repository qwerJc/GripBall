//
//  ConnectResViewController.h
//  GripBall
//
//  Created by 贾辰 on 2017/11/4.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>
// 设置delegate
@protocol ConnectResultDelegate // 代理传值方法
- (void)reGetMainList;
@end


@interface ConnectResViewController : UIViewController
@property (nonatomic, weak) id delegate;        //委托代理人，代理一般需使用弱引用(weak)
-(void)setLbl2Name:(NSString *)strName;
@end

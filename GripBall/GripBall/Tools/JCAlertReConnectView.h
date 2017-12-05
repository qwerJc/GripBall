//
//  JCAlertReConnectView.h
//  GripBall
//
//  Created by 贾辰 on 2017/12/4.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCAlertReConnectView : UIView
- (instancetype)initAlert3ReConnectWithTitle:(NSString *)title;
- (void)setAlert3WaitView;  //alert3部分应用于断线重连功能，因此提供三个改变alert内容的方法
- (void)setAlert3SuccView;
- (void)setAlert3FailView;

@property (strong, nonatomic) UIButton *btnReConnectBtn1;
@property (strong, nonatomic) UIButton *btnReConnectBtn2;
@property (strong, nonatomic) UIButton *btnFailBtn1;
@property (strong, nonatomic) UIButton *btnFailBtn2;
@property (strong, nonatomic) UIButton *btnSuccBtn1;
@property (strong, nonatomic) UIButton *btnSuccBtn2;
@end

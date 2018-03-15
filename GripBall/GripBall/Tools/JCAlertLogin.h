//
//  JCAlertLogin.h
//  GripBall
//
//  Created by 贾辰 on 18/3/11.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCAlertLogin : UIView
@property (strong, nonatomic)UIButton *btnAlbum;
@property (strong, nonatomic)UIButton *btnCamera;
-(instancetype)initWithTitle:(NSString *)str1 andDetailTitle:(NSString *)str2;
-(instancetype)initWithThreeBtn;
@end

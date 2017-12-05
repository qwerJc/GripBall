//
//  JCAlertView.h
//  GripBall
//
//  Created by 贾辰 on 17/9/26.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JCAlertView : UIView
@property (nonatomic,strong)UIButton *btnOK;
@property (nonatomic,strong)UIButton *btnCancel;
- (instancetype)initWithTitle:(NSString *)title andDetailTitle:(NSString *)detailTitle andBtnTitle:(NSString *)singleBtnTitle;
- (instancetype)initAlert2TwoBtnWithTitle:(NSString *)title andBtn1Title:(NSString *)btn1Title andBtn2Title:(NSString *)btn2Title;
- (instancetype)initAlert3OneBackBtnAndOneIcon:(UIImage *)icon andOneTitle:(NSString *)title;
@end

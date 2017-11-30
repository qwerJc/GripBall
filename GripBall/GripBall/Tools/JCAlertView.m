//
//  JCAlertView.m
//  GripBall
//
//  Created by 贾辰 on 17/9/26.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "JCAlertView.h"
#import "ModelLocator.h"

@interface JCAlertView()

@end

@implementation JCAlertView

- (instancetype)initWithTitle:(NSString *)title andDetailTitle:(NSString *)detailTitle andBtnTitle:(NSString *)singleBtnTitle
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        //Create UI
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [viewBG setBackgroundColor:[UIColor blackColor]];
        [viewBG setAlpha:0.6];
        [self addSubview:viewBG];
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(45.f, 200.f, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [alertView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:alertView];
        
        UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [imgViewBG setImage:[UIImage imageNamed:@"connect_rectangle_l"]];
        [alertView addSubview:imgViewBG];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(25.f, 62.f,alertView.frame.size.width-50.f, 22.f)];
        [lblTitle setText:title];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [alertView addSubview:lblTitle];
        
        UILabel *lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(25.f, 100.f,alertView.frame.size.width-50.f, 22.f)];
        [lblSubTitle setText:detailTitle];
        [lblSubTitle setTextColor:[UIColor blackColor]];
        [lblSubTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblSubTitle setTextAlignment:NSTextAlignmentCenter];
        [alertView addSubview:lblSubTitle];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(55.f, 175.f, alertView.frame.size.width-110.f, 48.f)];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"connect_btn_black"] forState:UIControlStateNormal];
        [btnCancel setTitle:singleBtnTitle forState:UIControlStateNormal];
        [btnCancel setTintColor:[UIColor whiteColor]];
        [btnCancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:btnCancel];
        
        
    }
    return self;
}

-(void)clickCancel{
    [self removeFromSuperview];
}

-(instancetype)initWithTitle:(NSString *)title andBtn1Title:(NSString *)btn1Title andBtn2Title:(NSString *)btn2Title{
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [viewBG setBackgroundColor:[UIColor blackColor]];
        [viewBG setAlpha:0.6];
        [self addSubview:viewBG];
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(45.f, 200.f, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [alertView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:alertView];
        
        UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [imgViewBG setImage:[UIImage imageNamed:@"connect_rectangle_l"]];
        [alertView addSubview:imgViewBG];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(25.f, 62.f,alertView.frame.size.width-50.f, 22.f)];
        [lblTitle setText:title];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [alertView addSubview:lblTitle];
        
        
        _btnOK = [[UIButton alloc] initWithFrame:CGRectMake(55.f, 100.f, alertView.frame.size.width-110.f, 48.f)];
        [_btnOK setBackgroundImage:[UIImage imageNamed:@"practice_btn7"] forState:UIControlStateNormal];
        [_btnOK setTitle:btn1Title forState:UIControlStateNormal];
        [_btnOK.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [_btnOK setTintColor:[UIColor colorWithRed:72.f/255.f green:72.f/255.f blue:72.f/255.f alpha:1]];
        [_btnOK setTintColor:[UIColor whiteColor]];
        [alertView addSubview:_btnOK];
        
        _btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(55.f, 175.f, alertView.frame.size.width-110.f, 48.f)];
        [_btnCancel setBackgroundImage:[UIImage imageNamed:@"practice_btn5"] forState:UIControlStateNormal];
        [_btnCancel setTitle:btn2Title forState:UIControlStateNormal];
        [_btnCancel.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [_btnCancel setTintColor:[UIColor colorWithRed:72.f/255.f green:72.f/255.f blue:72.f/255.f alpha:1]];
        [alertView addSubview:_btnCancel];
    }
    return self;
}
-(void)setAlert2WaitView{
    [UIView animateWithDuration:5.f animations:^{
        [self.alertView setFrame:CGRectMake(20.f, 50.f, 280.f, 270.f)];
        [self.alertView setBackgroundColor:[UIColor redColor]];
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

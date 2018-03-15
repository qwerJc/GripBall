//
//  JCAlertLogin.m
//  GripBall
//
//  Created by 贾辰 on 18/3/11.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "JCAlertLogin.h"
#import "ModelLocator.h"

@implementation JCAlertLogin
- (instancetype)initWithTitle:(NSString *)str1 andDetailTitle:(NSString *)str2{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [viewBG setBackgroundColor:[UIColor blackColor]];
        [viewBG setAlpha:0.6];
        [self addSubview:viewBG];
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(45.f, 260.f, SCREEN_WIDTH-90.f, 250.f)];
        [alertView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:alertView];
        
        UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, 250.f)];
        [imgViewBG setImage:[UIImage imageNamed:@"Login_White_BG_short"]];
        [alertView addSubview:imgViewBG];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60.f, 20.f,alertView.frame.size.width-120.f, 22.f)];
        [lblTitle setText:str1];
        [lblTitle setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1]];
        [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [alertView addSubview:lblTitle];
        
        UILabel *lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(25.f, 70.f,alertView.frame.size.width-50.f, 22.f)];
        [lblSubTitle setText:str2];
        [lblSubTitle setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1]];
        [lblSubTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblSubTitle setTextAlignment:NSTextAlignmentCenter];
        [alertView addSubview:lblSubTitle];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(alertView.frame.size.width/2-85.f, 150.f,171, 45.f)];
        [btnOK setBackgroundImage:[UIImage imageNamed:@"connect_btn_black"] forState:UIControlStateNormal];
        [btnOK addTarget:self
                       action:@selector(onBenOK)
             forControlEvents:UIControlEventTouchUpInside];
        [btnOK setTitle:@"是" forState:UIControlStateNormal];
        [btnOK setTintColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1]];
        [alertView addSubview:btnOK];
        
    }
    return self;
}

-(void)onBenOK{
    [self removeFromSuperview];
}

-(instancetype)initWithThreeBtn{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [viewBG setBackgroundColor:[UIColor blackColor]];
        [viewBG setAlpha:0.6];
        [self addSubview:viewBG];
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(45.f, 330.f, SCREEN_WIDTH-90.f, 260.f)];
        [alertView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:alertView];
        
        UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, 260.f)];
        [imgViewBG setImage:[UIImage imageNamed:@"Login_white_BG_short"]];
        [alertView addSubview:imgViewBG];
        
        _btnAlbum = [[UIButton alloc] initWithFrame:CGRectMake(alertView.frame.size.width/2-85.f, 30.f,171, 45.f)];
        [_btnAlbum setBackgroundImage:[UIImage imageNamed:@"connect_btn_black"] forState:UIControlStateNormal];
        [_btnAlbum setTitle:@"从相册选择" forState:UIControlStateNormal];
        [_btnAlbum setTintColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1]];
        [alertView addSubview:_btnAlbum];
        
        _btnCamera = [[UIButton alloc] initWithFrame:CGRectMake(alertView.frame.size.width/2-85.f, 110.f,171, 45.f)];
        [_btnCamera setBackgroundImage:[UIImage imageNamed:@"connect_btn_black"] forState:UIControlStateNormal];
        [_btnCamera setTitle:@"拍照" forState:UIControlStateNormal];
        [_btnCamera setTintColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1]];
        [alertView addSubview:_btnCamera];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(alertView.frame.size.width/2-85.f, 190.f,171, 45.f)];
        [btnOK setBackgroundImage:[UIImage imageNamed:@"Login_Btn2"] forState:UIControlStateNormal];
        [btnOK addTarget:self
                  action:@selector(onBenOK)
        forControlEvents:UIControlEventTouchUpInside];
        [btnOK setTitle:@"取消" forState:UIControlStateNormal];
        [btnOK setTintColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1]];
        [alertView addSubview:btnOK];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

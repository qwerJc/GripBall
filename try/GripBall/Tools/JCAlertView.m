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
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(55.f, 175.f, alertView.frame.size.width-110.f, 48.f)];
        [btnOK setBackgroundImage:[UIImage imageNamed:@"connect_btn_black"] forState:UIControlStateNormal];
        [btnOK setTitle:singleBtnTitle forState:UIControlStateNormal];
        [btnOK setTintColor:[UIColor whiteColor]];
        [btnOK addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:btnOK];
        
        
    }
    return self;
}

-(void)clickOK{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

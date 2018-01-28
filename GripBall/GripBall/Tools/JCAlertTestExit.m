//
//  JCAlertTestExit.m
//  GripBall
//
//  Created by 贾辰 on 18/1/28.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "JCAlertTestExit.h"
#import "ModelLocator.h"
@implementation JCAlertTestExit
-(instancetype)initJCAlertTestExit{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [viewBG setBackgroundColor:[UIColor blackColor]];
        [viewBG setAlpha:0.6];
        [self addSubview:viewBG];
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(45.f, 200.f, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-300.f)];
        [alertView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:alertView];
        
        UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-300.f)];
        [imgViewBG setImage:[UIImage imageNamed:@"connect_rectangle_l"]];
        [alertView addSubview:imgViewBG];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60.f, 50.f,alertView.frame.size.width-120.f, 22.f)];
        [lblTitle setText:@"是否确认退出"];
        [lblTitle setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1]];
        [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [alertView addSubview:lblTitle];
        
        UILabel *lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(25.f, 100.f,alertView.frame.size.width-50.f, 22.f)];
        [lblSubTitle setText:@"本次测试将不记录"];
        [lblSubTitle setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1]];
        [lblSubTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblSubTitle setTextAlignment:NSTextAlignmentCenter];
        [alertView addSubview:lblSubTitle];
        
        self.btnOK = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 150.f, alertView.frame.size.width-100.f, 45.f)];
        [self.btnOK setBackgroundImage:[UIImage imageNamed:@"connect_btn_black"] forState:UIControlStateNormal];
        [self.btnOK setTitle:@"是" forState:UIControlStateNormal];
        [self.btnOK setTintColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1]];
        [alertView addSubview:self.btnOK];
        
        self.btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 225.f, alertView.frame.size.width-100.f, 45.f)];
        [self.btnCancel setBackgroundImage:[UIImage imageNamed:@"connect_btn_gray"] forState:UIControlStateNormal];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTintColor:[UIColor colorWithRed:72.f/255.f green:72.f/255.f blue:72.f/255.f alpha:1]];
        [alertView addSubview:self.btnCancel];
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

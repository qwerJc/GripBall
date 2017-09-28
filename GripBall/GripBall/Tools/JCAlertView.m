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

- (instancetype)initWithTitle:(NSString *)title andDetailTitle:(NSString *)detailTitle andBtnTitle:(NSString *)btnTitle
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        //Create UI
        [self setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.6]];
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-60.f, SCREEN_HEIGHT/2-80.f, 120, 160)];
        [alertView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:alertView];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(20, 110, 80, 40)];
        [btnOK setBackgroundColor:[UIColor grayColor]];
        [btnOK setTitle:btnTitle forState:UIControlStateNormal];
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

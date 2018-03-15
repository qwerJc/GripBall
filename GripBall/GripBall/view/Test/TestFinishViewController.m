//
//  TestFinishViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/1/3.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TestFinishViewController.h"
#import "ModelLocator.h"
#import "TestStartViewController.h"
#import "ConnectResViewController.h"

@interface TestFinishViewController ()
@property (strong, nonatomic) UILabel *lblLStrength;
@property (strong, nonatomic) UILabel *lblLScore;
@property (strong, nonatomic) UILabel *lblRStrength;
@property (strong, nonatomic) UILabel *lblRScore;
@end

@implementation TestFinishViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    // BGImage
    UIImageView *imgVPrepareBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVPrepareBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVPrepareBG];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.f,115.f, 100.f, 25.f)];
    [lblTitle setText:@"练习结果"];
    [lblTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTitle];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(75.f,160.f, SCREEN_WIDTH-150.f, 2)];
    [lblLine setBackgroundColor:[UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:1]];
    [self.view addSubview:lblLine];
    
    UILabel *lblLStrengthTitle = [[UILabel alloc] initWithFrame:CGRectMake(80.f,205.f, 80.f, 25.f)];
    [lblLStrengthTitle setText:@"左手握力"];
    [lblLStrengthTitle setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblLStrengthTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblLStrengthTitle setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblLStrengthTitle];
    
    self.lblLStrength = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-105.f,205.f, 80.f, 25.f)];
    [self.lblLStrength setText:@"0"];
    [self.lblLStrength setTextColor:[UIColor colorWithRed:85.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
    [self.lblLStrength setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [self.lblLStrength setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.lblLStrength];
    
    UILabel *lblLScoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(80.f,270.f, 80.f, 25.f)];
    [lblLScoreTitle setText:@"评分"];
    [lblLScoreTitle setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblLScoreTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblLScoreTitle setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblLScoreTitle];
    
    self.lblLScore = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-105.f,270.f, 80.f, 25.f)];
    [self.lblLScore setText:@"0"];
    [self.lblLScore setTextColor:[UIColor colorWithRed:179.f/255.f green:74.f/255.f blue:74.f/255.f alpha:1]];
    [self.lblLScore setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [self.lblLScore setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.lblLScore];
    
    UILabel *lblRStrengthTitle = [[UILabel alloc] initWithFrame:CGRectMake(80.f,335.f, 80.f, 25.f)];
    [lblRStrengthTitle setText:@"右手握力"];
    [lblRStrengthTitle setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblRStrengthTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblRStrengthTitle setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblRStrengthTitle];
    
    self.lblRStrength = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-105.f,335.f, 80.f, 25.f)];
    [self.lblRStrength setText:@"0"];
    [self.lblRStrength setTextColor:[UIColor colorWithRed:85.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
    [self.lblRStrength setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [self.lblRStrength setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.lblRStrength];
    
    UILabel *lblRScoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(80.f,400.f, 80.f, 25.f)];
    [lblRScoreTitle setText:@"评分"];
    [lblRScoreTitle setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblRScoreTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblRScoreTitle setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblRScoreTitle];
    
    self.lblRScore = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-105.f,400.f, 80.f, 25.f)];
    [self.lblRScore setText:@"0"];
    [self.lblRScore setTextColor:[UIColor colorWithRed:179.f/255.f green:74.f/255.f blue:74.f/255.f alpha:1]];
    [self.lblRScore setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [self.lblRScore setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.lblRScore];
    
    UIButton *btnEnd = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-200.f, 171, 46.f)];
    [btnEnd setTitle:@"结束" forState:UIControlStateNormal];
    btnEnd.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnEnd setBackgroundImage:[UIImage imageNamed:@"practice_btn8"] forState:UIControlStateNormal];
    [btnEnd setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnEnd addTarget:self action:@selector(clickBtnEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnd];
    
    UIButton *btnReTest = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-115.f, 171, 46.f)];
    [btnReTest setTitle:@"再测一次" forState:UIControlStateNormal];
    btnReTest.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnReTest setBackgroundImage:[UIImage imageNamed:@"test_btn_red"] forState:UIControlStateNormal];
    [btnReTest setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnReTest addTarget:self action:@selector(clickBtnReTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReTest];
}
-(void)setLeftStrength:(float)sValue{
    [self.lblLStrength setText:[NSString stringWithFormat:@"%0.1f",sValue]];
    //设置评分
    [self.lblLScore setText:@"95"];
}
-(void)setRightStrength:(float)sVlue{
    [self.lblRStrength setText:[NSString stringWithFormat:@"%0.1f",sVlue]];
    
    //设置评分
    [self.lblRScore setText:@"95"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Btn Delegate
-(void)clickBtnEnd{
    NSArray *controllers = self.navigationController.viewControllers;
    for ( id viewController in controllers) {
        if ([viewController isKindOfClass:[ConnectResViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

-(void)clickBtnReTest{
    NSArray *controllers = self.navigationController.viewControllers;
    for ( id viewController in controllers) {
        if ([viewController isKindOfClass:[TestStartViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

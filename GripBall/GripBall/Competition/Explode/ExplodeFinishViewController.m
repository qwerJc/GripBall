//
//  ExplodeFinishViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/1/29.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ExplodeFinishViewController.h"
#import "CompetitionListViewController.h"
#import "ExplodeStartViewController.h"
#import "ConnectResViewController.h"
#import "JCAlertLogin.h"

@interface ExplodeFinishViewController ()
@property (strong, nonatomic) CompetitionListViewController *viewControllerList;

@property (strong, nonatomic) UILabel *lblLHandScore;
@property (strong, nonatomic) UILabel *lblRHandScore;

@property (strong, nonatomic) JCAlertLogin              *alertLogin;
@end

@implementation ExplodeFinishViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewControllerList = [[CompetitionListViewController alloc] init];
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    // BGImage
    UIImageView *imgVBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVBG];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100.f,100.f, 200.f, 25.f)];
    [lblTitle setText:@"爆发力测试结果"];
    [lblTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTitle];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(75.f,160.f, SCREEN_WIDTH-150.f, 0.5)];
    [lblLine setBackgroundColor:[UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:1]];
    [self.view addSubview:lblLine];
    
    UILabel *lblLHandScoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(80.f,230.f, 80.f, 25.f)];
    [lblLHandScoreTitle setText:@"左手"];
    [lblLHandScoreTitle setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblLHandScoreTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblLHandScoreTitle setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblLHandScoreTitle];
    
    self.lblLHandScore = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200.f,230.f, 100.f, 25.f)];
    [self.lblLHandScore setText:@"0"];
    [self.lblLHandScore setTextColor:[UIColor colorWithRed:82.f/255.f green:152.f/255.f blue:188.f/255.f alpha:1]];
    [self.lblLHandScore setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [self.lblLHandScore setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.lblLHandScore];
    
    UILabel *lblLScoreUnit = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f,230.f, 80.f, 25.f)];
    [lblLScoreUnit setText:@"N/S"];
    [lblLScoreUnit setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblLScoreUnit setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblLScoreUnit setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblLScoreUnit];
    
    UILabel *lblRHandScoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(80.f,300.f, 80.f, 25.f)];
    [lblRHandScoreTitle setText:@"右手"];
    [lblRHandScoreTitle setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblRHandScoreTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblRHandScoreTitle setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblRHandScoreTitle];
    
    UILabel *lblRScoreUnit = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f,300.f, 80.f, 25.f)];
    [lblRScoreUnit setText:@"N/S"];
    [lblRScoreUnit setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblRScoreUnit setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblRScoreUnit setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblRScoreUnit];
    
    self.lblRHandScore = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200.f,300.f, 100.f, 25.f)];
    [self.lblRHandScore setText:@"0"];
    [self.lblRHandScore setTextColor:[UIColor colorWithRed:82.f/255.f green:152.f/255.f blue:188.f/255.f alpha:1]];
    [self.lblRHandScore setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [self.lblRHandScore setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.lblRHandScore];
    
    UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-285.f, 171, 46.f)];
    [btnList setTitle:@"排行榜" forState:UIControlStateNormal];
    btnList.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnList setBackgroundImage:[UIImage imageNamed:@"practice_btn8"] forState:UIControlStateNormal];
    [btnList setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnList addTarget:self action:@selector(clickBtnList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnList];
    
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

-(void)setLeftValue:(NSString *)lValue andLeftTime:(NSString *)lTime andRightValue:(NSString *)rValue andRightTime:(NSString *)RTime{
    [self.lblLHandScore setText:[NSString stringWithFormat:@"%@/%@",lValue,lTime]];
    [self.lblRHandScore setText:[NSString stringWithFormat:@"%@/%@",lValue,lTime]];
    
    [httpModel postExplodeWithLeftHandValue:lValue
                        andLeftHandCostTime:lTime
                          andRightHandValue:rValue
                       andRightHandCostTime:RTime
                                 Completion:^{
                                     NSLog(@"上传成功");
                                 }
                                      error:^(NSError *error, int num) {
                                          if (num == 2 ) {
                                              self.alertLogin = [[JCAlertLogin alloc] initWithTitle:@"" andDetailTitle:@"获取趋势数据失败"];
                                              UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
                                              [rootWindow addSubview:self.alertLogin];
                                          }else{
                                              self.alertLogin = [[JCAlertLogin alloc] initWithTitle:@"" andDetailTitle:@"请检查当前网络"];
                                              UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
                                              [rootWindow addSubview:self.alertLogin];
                                          }
                                      }];
}
#pragma mark - Btn Delegate
-(void)clickBtnList{
    [self.viewControllerList setTitle:@"爆发力竞技排行榜"];
    [self.viewControllerList reloadExplodeList];
    [self.navigationController pushViewController:self.viewControllerList animated:YES];
}
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
        if ([viewController isKindOfClass:[ExplodeStartViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

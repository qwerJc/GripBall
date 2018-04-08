//
//  ConnectResViewController.m
//  GripBall
//
//  Created by 贾辰 on 2017/11/4.
//  Copyright © 2017年 贾辰. All rights reserved.
//  有两个状态 一个是 连接成功 另一个是 等待两秒后

#import "ConnectResViewController.h"
#import "ModelLocator.h"
#import "PracticeBeginViewController.h"
#import "TestStartViewController.h"
#import "CompetitionStartViewController.h"

@interface ConnectResViewController ()
@property (strong, nonatomic) UIView *viewConnectSucc;
@property (strong, nonatomic) UIView *viewChoice;
@property (strong, nonatomic) UILabel *lblCSText2;

@property (assign, nonatomic) BOOL isBack;  //判断是否是从练习模式返回而来，返回的话不需要加载等待界面

//下面是三种模式对应的VC
@property (strong, nonatomic) PracticeBeginViewController   *viewControllerPractiveBegin;
@property (strong, nonatomic) TestStartViewController *viewControllerTestStart;
@property (strong, nonatomic) CompetitionStartViewController *viewControllerCompetition;
@end

@implementation ConnectResViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        self.isBack = false;
        

    }
    return self;
}
-(void)createUI
{
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //-----------------------------【SearchView】---------------------------
    self.viewConnectSucc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewConnectSucc setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.viewConnectSucc];
    
    UIImageView *imgViewCSBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
    [self.viewConnectSucc addSubview:imgViewCSBG];
    
    UILabel *lblTCSTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-48.f, 100.f, 96.f, 25.f)];
    [lblTCSTitle setText:@"连接成功"];
    [lblTCSTitle setTextColor:[UIColor colorWithRed:164.f/255.f green:164.f/255.f blue:164.f/255.f alpha:1]];
    [lblTCSTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTCSTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewConnectSucc addSubview:lblTCSTitle];
    
    UIImageView *imgVCSIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-45.f, 285.f, 90.f, 90.f)];
    [imgVCSIcon setImage:[UIImage imageNamed:@"connect_background4"]];
    [self.viewConnectSucc addSubview:imgVCSIcon];
    
    UILabel *lblCSText1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100.f, 450.f, 200.f, 16.f)];
    [lblCSText1 setText:@"已成功连接到"];
    [lblCSText1 setTextColor:[UIColor colorWithRed:221.f/255.f green:221.f/255.f blue:221.f/255.f alpha:1]];
    [lblCSText1 setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblCSText1 setTextAlignment:NSTextAlignmentCenter];
    [self.viewConnectSucc addSubview:lblCSText1];
    
    self.lblCSText2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100.f, 30+450.f, 200.f, 16.f)];
    [self.lblCSText2 setTextColor:[UIColor colorWithRed:221.f/255.f green:221.f/255.f blue:221.f/255.f alpha:1]];
    [self.lblCSText2 setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [self.lblCSText2 setTextAlignment:NSTextAlignmentCenter];
    [self.viewConnectSucc addSubview:self.lblCSText2];
    
    //-----------------------------【ChoiceView】---------------------------
    self.viewChoice = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewChoice  setBackgroundColor:[UIColor blackColor]];
    [self.viewChoice setAlpha:0];
    [self.view addSubview:self.viewChoice];
    
    UIImageView *imageViewChoiceBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
    [self.viewChoice addSubview:imageViewChoiceBG];
    
    UILabel *lblChoiceTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-48.f, 90.f, 96.f, 25.f)];
    [lblChoiceTitle setText:@"握力测试"];
    [lblChoiceTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblChoiceTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblChoiceTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewChoice addSubview:lblChoiceTitle];
    
    UIButton *btnPractice = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, 250.f, 171, 46.f)];
    [btnPractice setTitle:@"练习模式" forState:UIControlStateNormal];
    btnPractice.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnPractice setBackgroundImage:[UIImage imageNamed:@"connect_btn_gray"] forState:UIControlStateNormal];
    [btnPractice setTitleColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnPractice addTarget:self action:@selector(clickBtnPractice) forControlEvents:UIControlEventTouchUpInside];
    [self.viewChoice addSubview:btnPractice];
    
    UIButton *btnTest = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, 340.f, 171, 46.f)];
    [btnTest setTitle:@"测试模式" forState:UIControlStateNormal];
    btnTest.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnTest setBackgroundImage:[UIImage imageNamed:@"connect_btn_gray"] forState:UIControlStateNormal];
    [btnTest setTitleColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnTest addTarget:self action:@selector(clickBtnTest) forControlEvents:UIControlEventTouchUpInside];
    [self.viewChoice addSubview:btnTest];
    
    UIButton *btnMatch = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, 430.f, 171, 46.f)];
    [btnMatch setTitle:@"竞技模式" forState:UIControlStateNormal];
    btnMatch.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnMatch setBackgroundImage:[UIImage imageNamed:@"connect_btn_gray"] forState:UIControlStateNormal];
    [btnMatch setTitleColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnMatch addTarget:self action:@selector(clickBtnMatch) forControlEvents:UIControlEventTouchUpInside];
    [self.viewChoice addSubview:btnMatch];
    
    UIButton *btnBackToMain = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, 520.f, 171, 46.f)];
    [btnBackToMain setTitle:@"回到首页" forState:UIControlStateNormal];
    btnBackToMain.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnBackToMain setBackgroundImage:[UIImage imageNamed:@"connect_btn_gray"] forState:UIControlStateNormal];
    [btnBackToMain setTitleColor:[UIColor colorWithRed:213.f/255.f green:213.f/255.f blue:213.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnBackToMain addTarget:self action:@selector(clickBtnBackToMain) forControlEvents:UIControlEventTouchUpInside];
    [self.viewChoice addSubview:btnBackToMain];
}

-(void)setLbl2Name:(NSString *)strName{
    [self.lblCSText2 setText:strName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)showChoiceView{
    [UIView animateWithDuration:0.25 animations:^{
        [self.viewConnectSucc setAlpha:0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.viewChoice setAlpha:1];
        }];
    }];
}

//-----------------------------【ChoiceView】---------------------------
#pragma mark - Choise View
#pragma mark - Btn Delegate
-(void)clickBtnPractice{
    self.viewControllerPractiveBegin = [[PracticeBeginViewController alloc] init];

    [self.navigationController pushViewController:self.viewControllerPractiveBegin animated:YES];
    self.isBack = true;
}
-(void)clickBtnTest{
    self.viewControllerTestStart = [[TestStartViewController alloc] init];
    [self.navigationController pushViewController:self.viewControllerTestStart animated:YES];
    self.isBack = true;
}
-(void)clickBtnMatch{
    self.viewControllerCompetition = [[CompetitionStartViewController alloc] init];
    [self.navigationController pushViewController:self.viewControllerCompetition animated:YES];
    self.isBack = true;
    
}
-(void)clickBtnBackToMain{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 总的Delegate
-(void)viewWillAppear:(BOOL)animated{
    if (self.isBack) {
        [self.viewConnectSucc setAlpha:0];
        [self.viewChoice setAlpha:1];
    }else{
        [self performSelector:@selector(showChoiceView) withObject:nil afterDelay:2.0];
    }
    self.isBack = false;
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.viewConnectSucc setAlpha:1];
    [self.viewChoice setAlpha:0];
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

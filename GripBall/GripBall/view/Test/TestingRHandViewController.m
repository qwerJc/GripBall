//
//  TestingRHandViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/1/3.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TestingRHandViewController.h"
#import "ModelLocator.h"
#import "TestFinishViewController.h"
#import "JCManValueChart.h"
#import "JCAlertTestExit.h"
#import "ConnectResViewController.h"

@interface TestingRHandViewController ()
@property (strong, nonatomic) TestFinishViewController *viewTestFinish;
@property (strong, nonatomic) JCManValueChart *jcManChart;

@property (strong, nonatomic) UIImageView *imgvTestState1;
@property (strong, nonatomic) UIImageView *imgvTestState2;
@property (strong, nonatomic) UIImageView *imgvTestState3;

@property (strong, nonatomic) JCAlertTestExit *alert;

@property (assign, nonatomic) float      startValue;          //三段力，用来判断峰值
@property (assign, nonatomic) float      midValue;
@property (assign, nonatomic) float      endValue;

@property (assign, nonatomic) int        practiceNumber;      //练习次数

@property (assign, nonatomic) float      MaxStrengthValue;    //最大力量值

@property (assign, nonatomic) float      leftHandValue;       //左手力的最大值
@end

@implementation TestingRHandViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        
        self.practiceNumber = 0;
        
        self.viewTestFinish = [[TestFinishViewController alloc] init];
        
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
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(45.f, 62.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UILabel *lblTPrepareTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 43.f,70.f, 86.f, 25.f)];
    [lblTPrepareTitle setText:@"测验模式"];
    [lblTPrepareTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTPrepareTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTPrepareTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTPrepareTitle];
    
    UIImageView *imgVState = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-81.f, 67.f, 31.f, 31.f)];
    [imgVState setImage:[UIImage imageNamed:@"connect_state_on"]];
    [self.view addSubview:imgVState];
    
    UIImageView *imgVStrengValueMax = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40.f, 170.f, 80.f, 280.f)];
    [imgVStrengValueMax setImage:[UIImage imageNamed:@"test_strengValueMax"]];
    [self.view addSubview:imgVStrengValueMax];
    
    //此处后期设计动画
    self.jcManChart = [[JCManValueChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40.f, 170.f, 80.f, 80.f)];
    [self.view addSubview:self.jcManChart];
    
    self.imgvTestState1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-47, SCREEN_HEIGHT-200.f, 18.f, 18.f)];
    [self.imgvTestState1 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.view addSubview:self.imgvTestState1];
    
    self.imgvTestState2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-9, SCREEN_HEIGHT-200.f, 18.f, 18.f)];
    [self.imgvTestState2 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.view addSubview:self.imgvTestState2];
    
    self.imgvTestState3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+29, SCREEN_HEIGHT-200.f, 18.f, 18.f)];
    [self.imgvTestState3 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.view addSubview:self.imgvTestState3];
    
    UIButton *btnExit = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-130.f, 171, 46.f)];
    [btnExit setTitle:@"退出测试" forState:UIControlStateNormal];
    btnExit.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnExit setBackgroundImage:[UIImage imageNamed:@"test_btn_red"] forState:UIControlStateNormal];
    [btnExit setTitleColor:[UIColor colorWithRed:195.f/255.f green:195.f/255.f blue:195.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnExit addTarget:self action:@selector(clickBtnExit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExit];
    
}

-(void)setLeftHandStrengthValue:(float)sValue{
    self.leftHandValue = sValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    self.MaxStrengthValue = 0.f;
    self.practiceNumber = 0;
    
    [self.imgvTestState1 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.imgvTestState2 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.imgvTestState3 setImage:[UIImage imageNamed:@"test_unChosen"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTData:) name:@"SendTestData" object:nil];
}
//页面完全消失
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除Notification监听");
}

#pragma mark - Btn Delegate
-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickBtnExit{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除Notification监听");
    
    self.alert = [[JCAlertTestExit alloc] initJCAlertTestExit];
    [self.alert.btnOK addTarget:self action:@selector(onAlertBtnOK) forControlEvents:UIControlEventTouchUpInside];
    [self.alert.btnCancel addTarget:self action:@selector(onAlertBtnCancel) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.alert];
}
-(void)onAlertBtnOK{
    NSArray *controllers = self.navigationController.viewControllers;
    for ( id viewController in controllers) {
        if ([viewController isKindOfClass:[ConnectResViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
    [self.alert removeFromSuperview];
}
-(void)onAlertBtnCancel{
    NSLog(@"重新添加Notification监听");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTData:) name:@"SendTestData" object:nil];
    [self.alert removeFromSuperview];
}
#pragma mark - BlueTooth
-(void)getBTData:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
    float value = [noti.object floatValue];
    
    //判断， 如果value ＝＝ end的值 跳过
    if (self.startValue<0) {
        self.startValue = value;
    }else if (self.midValue<0){
        self.midValue = value;
    }else if (self.endValue<0){
        self.endValue = value;
    }else{
        //判断
        if(self.endValue != value){
            self.startValue = self.midValue;
            self.midValue = self.endValue;
            self.endValue = value;
            
            //判断是否为峰值
            if ((self.midValue>self.startValue)&&(self.midValue>self.endValue)) {
                self.practiceNumber ++ ;
                
                switch (self.practiceNumber) {
                    case 1:
                        [self.imgvTestState1 setImage:[UIImage imageNamed:@"test_Chosen"]];
                        break;
                    case 2:
                        [self.imgvTestState2 setImage:[UIImage imageNamed:@"test_Chosen"]];
                        break;
                    case 3:
                        [self.imgvTestState3 setImage:[UIImage imageNamed:@"test_Chosen"]];
                        break;
                    default:
                        break;
                }
                
                if (self.midValue > self.MaxStrengthValue) {
                    self.MaxStrengthValue = self.midValue;
                }
                
                if (self.practiceNumber == 3) {
                    
                    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
                    
                    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                        [self.viewTestFinish setLeftStrength:self.leftHandValue];
                        [self.viewTestFinish setRightStrength:self.MaxStrengthValue];
                        [self.navigationController pushViewController:self.viewTestFinish animated:YES];
                    });
                }
            }
        }
    }
    [self.jcManChart setManValue:value];
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

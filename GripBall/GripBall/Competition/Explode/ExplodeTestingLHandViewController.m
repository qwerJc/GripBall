//
//  ExplodeTestingLHandViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/1/29.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ExplodeTestingLHandViewController.h"
#import "ExplodeRHandViewController.h"
#import "ModelLocator.h"
#import "JCManValueChart.h"
#import "JCAlertTestExit.h"
#import "ConnectResViewController.h"

@interface ExplodeTestingLHandViewController ()
@property (strong, nonatomic)ExplodeRHandViewController *viewControllerRHand;
@property (strong, nonatomic) JCManValueChart *jcManChart;

@property (strong, nonatomic) UIImageView *imgvTestState1;
@property (strong, nonatomic) UIImageView *imgvTestState2;
@property (strong, nonatomic) UIImageView *imgvTestState3;

@property (assign, nonatomic) long long startTime;

@property (strong, nonatomic) JCAlertTestExit *alert;

@property (assign, nonatomic) BOOL comWillStart;    //标志着竞技模式是否开始

@property (assign, nonatomic) float      startValue;          //三段力，用来判断峰值
@property (assign, nonatomic) float      midValue;
@property (assign, nonatomic) float      endValue;

@property (assign, nonatomic) int        practiceNumber;      //练习次数
@property (assign, nonatomic) float      maxValue;          //三次中最大比值
@property (strong, nonatomic) NSString  *strMaxValue;
@property (strong, nonatomic) NSString  *strMaxValueTime;

@end

@implementation ExplodeTestingLHandViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.practiceNumber = 0;
        self.maxValue = 0.0f;
        
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
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(45.f, 62.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UILabel *lblTPrepareTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 60.f,70.f, 120.f, 25.f)];
    [lblTPrepareTitle setText:@"爆发力比拼"];
    [lblTPrepareTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTPrepareTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTPrepareTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTPrepareTitle];
        
    self.jcManChart = [[JCManValueChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40.f, 170.f, 80.f, 280.f)];
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

#pragma mark - Btn Delegate
-(void)clickBtnExit{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除Notification监听");
    
    self.alert = [[JCAlertTestExit alloc] initJCAlertTestExit];
    [self.alert.btnOK addTarget:self action:@selector(onAlertBtnOK) forControlEvents:UIControlEventTouchUpInside];
    [self.alert.btnCancel addTarget:self action:@selector(onAlertBtnCancel) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.alert];
    
//    [self.navigationController pushViewController:self.viewControllerRHand animated:YES];
}
-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTData:) name:@"SendEnduranceData" object:nil];
    [self.alert removeFromSuperview];
}

#pragma mark - 页面 Delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.practiceNumber = 0;
    self.maxValue = 0.0f;
    self.comWillStart = true;
    
    [self.imgvTestState1 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.imgvTestState2 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.imgvTestState3 setImage:[UIImage imageNamed:@"test_unChosen"]];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTData:) name:@"SendEnduranceData" object:nil];
}
//页面完全消失
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除Notification监听");
}

-(void)getBTData:(NSNotification *)noti{
    NSLog(@"爆发力 %@",noti.object);
    float value = [noti.object floatValue];
    [self.jcManChart setManValue:value];
    
    if (value >0 && self.comWillStart) {
        NSLog(@"开始测力");
        NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*10;
        _startTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
        
        _maxValue = 0;
        
        self.comWillStart = false;
        
        self.startValue = value;
        self.midValue = -1;
        self.endValue = -1;
    }else{
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
                    
                    //计算时间差
                    
                    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*10;
                    long long nowTimeStamp = [[NSNumber numberWithDouble:nowtime] longLongValue];
                    float diffTime = (nowTimeStamp - _startTime)/10;
                    if (diffTime < 0.11) {
                        diffTime = 0.1;
                    }
                    //此次的比值结果
                    float nowValue = self.midValue /diffTime;
                    
                    NSLog(@"%d此次比值%@",self.practiceNumber,[NSString stringWithFormat:@"%d/%d",(int)self.midValue,(int)diffTime]);
                    
                    //将大的比值结果赋给maxValue
                    if (nowValue > _maxValue) {
                        _maxValue = nowValue;
                        _strMaxValue = [NSString stringWithFormat:@"%d",(int)self.midValue];
                        _strMaxValueTime = [NSString stringWithFormat:@"%d",(int)diffTime];
                    }
                    
                    if (self.practiceNumber == 3) {
                        //移除监听
                        [[NSNotificationCenter defaultCenter] removeObserver:self];
                        
                        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
                        
                        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                            
                            self.viewControllerRHand = [[ExplodeRHandViewController alloc] init];
                            [self.viewControllerRHand setLeftHandValue:_strMaxValue andTime:_strMaxValueTime];
                            [self.navigationController pushViewController:self.viewControllerRHand animated:YES];
                        });
                    }else{
                        self.comWillStart = true;
                        _maxValue = 0;
                        [self.jcManChart setManValue:0];
                        
                        [[NSNotificationCenter defaultCenter] removeObserver:self];
                        NSLog(@"移除Notification监听");
                        
                        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/*延迟执行时间*/ * NSEC_PER_SEC));
                        
                        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                            NSLog(@"重新添加监听");
                            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTData:) name:@"SendEnduranceData" object:nil];
                        });
                    }
                }
            }
        }
    }
    

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

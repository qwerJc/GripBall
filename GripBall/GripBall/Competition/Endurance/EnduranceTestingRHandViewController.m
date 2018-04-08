//
//  EnduranceTestingRHandViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/3/5.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "EnduranceTestingRHandViewController.h"
#import "ModelLocator.h"
#import "EnduranceFinishViewController.h"
#import "JCManValueChart.h"
#import "JCAlertTestExit.h"
#import "ConnectResViewController.h"

@interface EnduranceTestingRHandViewController ()
@property (strong, nonatomic)EnduranceFinishViewController *viewControllerFinish;
@property (strong, nonatomic) JCManValueChart *jcManChart;

@property (strong, nonatomic) UIImageView *imgvTestState1;
@property (strong, nonatomic) UIImageView *imgvTestState2;
@property (strong, nonatomic) UIImageView *imgvTestState3;

@property (strong, nonatomic) JCAlertTestExit *alert;

@property (assign, nonatomic) long long startTime;
@property (assign, nonatomic) long long nowTime;

@property (assign, nonatomic) BOOL comWillStart;

@property (assign, nonatomic) float maxTime;
@property (assign, nonatomic) float maxValue;

@property (assign, nonatomic) int        practiceNumber;      //练习次数

@property (strong, nonatomic) NSString *lHandTime;
@end

@implementation EnduranceTestingRHandViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewControllerFinish = [[EnduranceFinishViewController alloc] init];
        
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
    [lblTPrepareTitle setText:@"耐力比拼"];
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

-(void)setLeftHandTime:(NSString *)lTime{
    _lHandTime = lTime;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTData:) name:@"SendTestData" object:nil];
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
    self.maxTime = 0;
    
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

#pragma mark - BlueTooth
-(void)getBTData:(NSNotification *)noti{
    NSLog(@"耐力测试 ： %@",noti.object);
    float value = [noti.object floatValue];
    [self.jcManChart setManValue:value];
    
    if (value >0&&self.comWillStart) {
        NSLog(@"开始测力");
        NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*10;
        _startTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
        
        _maxValue = value;
        
        self.comWillStart = false;
    }else{
        if (value>_maxValue) {
            NSLog(@"更新最大值为:%f",value);
            _maxValue = value;
        }else{
            if (_maxValue > value*1.4) {
                self.practiceNumber ++;
                NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*10;
                long long nowTimeStamp = [[NSNumber numberWithDouble:nowtime] longLongValue];
                
                float diffTime = (nowTimeStamp - _startTime)/10;
                
                NSLog(@"最大力为：%f 并且坚持最长为：%d",_maxValue,(int)diffTime);
                
                if (diffTime > _maxTime) {
                    _maxTime = diffTime;
                }
                
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
                
                if (self.practiceNumber == 3) {
                    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
                    //移除监听
                    [[NSNotificationCenter defaultCenter] removeObserver:self];
                    
                    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                        
                        self.viewControllerFinish = [[EnduranceFinishViewController alloc] init];
                        [self.viewControllerFinish setLTime:_lHandTime andRTime:[NSString stringWithFormat:@"%d",(int)self.maxTime]];
                        [self.navigationController pushViewController:self.viewControllerFinish animated:YES];
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

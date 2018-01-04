//
//  PracticeBeginViewController.m
//  GripBall
//
//  Created by 贾辰 on 2017/11/5.
//  Copyright © 2017年 贾辰. All rights reserved.
//
//  此页负责联系模式中的准备阶段以及开始测试阶段
//  Bug：当连续两次窝里一样时，不能判断出握力次数

#import "PracticeBeginViewController.h"
#import "ModelLocator.h"
#import "JCAlertView.h"
#import "PracticeFinishViewController.h"
#import "JCManChart.h"

@interface PracticeBeginViewController ()
@property (strong, nonatomic) UIView *viewPrepare;  //准备阶段
@property (strong, nonatomic) UIView *viewStart;    //开始测试

@property (strong, nonatomic) UILabel *lblStartNumber;      //当前次数标签
@property (strong, nonatomic) UILabel *lblStartTime;        //当前时间标签

@property (strong, nonatomic) NSTimer *timerSecond;         //通过计时器来累计timeCount，再转换成时间
@property (assign, nonatomic) int      timeCount;
@property (strong, nonatomic) JCAlertView *alert;

@property (assign, nonatomic) int        chartState;        //折线图当前状态：0为无，1为男，2为女
@property (strong, nonatomic) JCManChart *manChart;         //男性折线图

@property (assign, nonatomic) float      startValue;        //三段力，用来判断峰值
@property (assign, nonatomic) float      midValue;
@property (assign, nonatomic) float      endValue;

@property (assign, nonatomic) int      practiceNumber;      //练习次数
@property (assign, nonatomic) int        sumValue;          //总的测力数

@property (strong, nonatomic) PracticeFinishViewController  *viewControllerPracticeFinish;

@end

@implementation PracticeBeginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {

        
        self.viewControllerPracticeFinish = [[PracticeFinishViewController alloc] init];
        
        [self createUI];
        
    }
    return self;
}

-(void)createUI
{
    //-----------------------------【准备阶段】---------------------------
    self.viewPrepare = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewPrepare setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.viewPrepare];
    // BGImage
    UIImageView *imgVPrepareBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
    [self.viewPrepare addSubview:imgVPrepareBG];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(45.f, 62.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.viewPrepare addSubview:btnBack];
    
    UILabel *lblPrepareTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 43.f,70.f, 86.f, 25.f)];
    [lblPrepareTitle setText:@"练习模式"];
    [lblPrepareTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblPrepareTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblPrepareTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewPrepare addSubview:lblPrepareTitle];
    
    UIImageView *imgVState = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f, 67.f, 31.f, 30.f)];
    [imgVState setImage:[UIImage imageNamed:@"connect_state_on"]];
    [self.viewPrepare addSubview:imgVState];
    
    UIButton *btnStart = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90.f, 230.f, 180.f, 180.f)];
    [btnStart setBackgroundImage:[UIImage imageNamed:@"practice_icon5"] forState:UIControlStateNormal];
    [btnStart setTitle:@"开 始" forState:UIControlStateNormal];
    btnStart.titleLabel.font = [UIFont systemFontOfSize:24.0];
    [btnStart setTitleColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnStart.layer setCornerRadius:90.f];
    [btnStart.layer setMasksToBounds:YES];
    [btnStart addTarget:self action:@selector(clickBtnStart) forControlEvents:UIControlEventTouchUpInside];
    [self.viewPrepare addSubview:btnStart];
    
    UILabel *lblTPrepareText1 = [[UILabel alloc] initWithFrame:CGRectMake(50.f,SCREEN_HEIGHT - 170.f, 60.f, 20.f)];
    [lblTPrepareText1 setText:@"规则："];
    [lblTPrepareText1 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText1 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText1 setTextAlignment:NSTextAlignmentLeft];
    [self.viewPrepare addSubview:lblTPrepareText1];
    
    UILabel *lblTPrepareText2 = [[UILabel alloc] initWithFrame:CGRectMake(50.f,lblTPrepareText1.frame.origin.y + 20.f + 6.f, SCREEN_WIDTH - 80.f, 20.f)];
    [lblTPrepareText2 setText:@"自由练习握力，将记录联系时长及抓握次数。"];
    [lblTPrepareText2 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText2 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText2 setTextAlignment:NSTextAlignmentLeft];
    [self.viewPrepare addSubview:lblTPrepareText2];
    
    UILabel *lblTPrepareText3 = [[UILabel alloc] initWithFrame:CGRectMake(50.f,lblTPrepareText2.frame.origin.y + 20.f + 6.f,SCREEN_WIDTH - 100.f, 20.f)];
    [lblTPrepareText3 setText:@"点击开始后您可将与握力球断开连接"];
    [lblTPrepareText3 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText3 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText3 setTextAlignment:NSTextAlignmentLeft];
    [self.viewPrepare addSubview:lblTPrepareText3];
    
    UILabel *lblTPrepareText4 = [[UILabel alloc] initWithFrame:CGRectMake(50.f,lblTPrepareText3.frame.origin.y + 20.f + 6.f,SCREEN_WIDTH - 100.f, 20.f)];
    [lblTPrepareText4 setText:@"重新连接后数据将同步到手机"];
    [lblTPrepareText4 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText4 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText4 setTextAlignment:NSTextAlignmentLeft];
    [self.viewPrepare addSubview:lblTPrepareText4];
    
    //-----------------------------【开始测试】---------------------------
    self.viewStart = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewStart  setBackgroundColor:[UIColor blackColor]];
    [self.viewStart setAlpha:0];
    [self.view addSubview:self.viewStart];
    
    UIImageView *imgVStartBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
    [self.viewStart addSubview:imgVStartBG];
    
    UILabel *lblStartTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 43.f,70.f, 86.f, 25.f)];
    [lblStartTitle setText:@"练习模式"];
    [lblStartTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblStartTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblStartTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewStart addSubview:lblStartTitle];
    
    UIImageView *imgVState2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f, 66.f, 31.f, 31.f)];
    [imgVState2 setImage:[UIImage imageNamed:@"connect_state_on"]];
    [self.viewStart addSubview:imgVState2];
    
    UILabel *lblStartTitleSub1 = [[UILabel alloc] initWithFrame:CGRectMake(37.f,120.f, 130.f, 20.f)];
    [lblStartTitleSub1 setText:@"握力实时曲线图"];
    [lblStartTitleSub1 setTextColor:[UIColor colorWithRed:109.f/255.f green:121.f/255.f blue:132.f/255.f alpha:1]];
    [lblStartTitleSub1 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblStartTitleSub1 setTextAlignment:NSTextAlignmentLeft];
    [self.viewStart addSubview:lblStartTitleSub1];
    
    self.manChart = [[JCManChart alloc] initWithFrame:CGRectMake(35.f, 170.f, SCREEN_WIDTH-70.f, 122.f)];
    [self.viewStart addSubview:self.manChart];
    
    UILabel *lblStartTitleSub2 = [[UILabel alloc] initWithFrame:CGRectMake(37.f,315.f, 130.f, 20.f)];
    [lblStartTitleSub2 setText:@"当前次数"];
    [lblStartTitleSub2 setTextColor:[UIColor colorWithRed:109.f/255.f green:121.f/255.f blue:132.f/255.f alpha:1]];
    [lblStartTitleSub2 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblStartTitleSub2 setTextAlignment:NSTextAlignmentLeft];
    [self.viewStart addSubview:lblStartTitleSub2];
    
    _lblStartNumber = [[UILabel alloc] initWithFrame:CGRectMake(37.f,345.f, SCREEN_WIDTH - 74.f, 75.f)];
    [_lblStartNumber setTextColor:[UIColor colorWithRed:109.f/255.f green:121.f/255.f blue:132.f/255.f alpha:1]];
    [_lblStartNumber setFont:[UIFont fontWithName:@"ArialMT" size:88.f]];
    [_lblStartNumber setTextAlignment:NSTextAlignmentCenter];
    NSDictionary *dic = @{NSKernAttributeName:@16.f};       //设置字间距
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",self.practiceNumber] attributes:dic];
    [_lblStartNumber setAttributedText:attributeStr];
    [self.viewStart addSubview:_lblStartNumber];
    
    UILabel *lblStartTitleSub3 = [[UILabel alloc] initWithFrame:CGRectMake(37.f,440.f, 130.f, 20.f)];
    [lblStartTitleSub3 setText:@"时间"];
    [lblStartTitleSub3 setTextColor:[UIColor colorWithRed:109.f/255.f green:121.f/255.f blue:132.f/255.f alpha:1]];
    [lblStartTitleSub3 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblStartTitleSub3 setTextAlignment:NSTextAlignmentLeft];
    [self.viewStart addSubview:lblStartTitleSub3];
    
    _lblStartTime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100.f,475.f, 200.f, 50.f)];
    [_lblStartTime setTextColor:[UIColor colorWithRed:152.f/255.f green:163.f/255.f blue:174.f/255.f alpha:1]];
    [_lblStartTime setFont:[UIFont fontWithName:@"ArialMT" size:48.f]];
    [_lblStartTime setTextAlignment:NSTextAlignmentCenter];
    NSDictionary *dic2 = @{NSKernAttributeName:@1.5f};       //设置字间距
    NSAttributedString *attributeStr2 = [[NSAttributedString alloc] initWithString:@"00:00:00" attributes:dic2];
    [_lblStartTime setAttributedText:attributeStr2];
    [self.viewStart addSubview:_lblStartTime];
    
    UIButton *btnStartEnd = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-125.f, 171, 46.f)];
    [btnStartEnd setTitle:@"结束" forState:UIControlStateNormal];
    btnStartEnd.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnStartEnd setBackgroundImage:[UIImage imageNamed:@"practice_btn3"] forState:UIControlStateNormal];
    [btnStartEnd setTitleColor:[UIColor colorWithRed:195.f/255.f green:195.f/255.f blue:195.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnStartEnd addTarget:self action:@selector(clickBtnStartEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.viewStart addSubview:btnStartEnd];
}

#pragma mark - 准备阶段
#pragma mark - Btn
-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickBtnStart{
    _timeCount = 0;
    _timerSecond = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(addtimeCount) userInfo:nil repeats:YES];
    [UIView animateWithDuration:0.25 animations:^{
        [self.viewPrepare setAlpha:0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.viewStart setAlpha:1];
            
            //发送 ‘准备开始’通知，以接收数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PracticeModelBegin" object:nil];
        }];
    }];
}

#pragma mark - 测力阶段

-(void)addtimeCount{
    _timeCount++;
    if (_timeCount>=3600) {
        [_lblStartTime setText:[NSString stringWithFormat:@"%02d:%02d%02d",_timeCount/60,_timeCount/3600,_timeCount%3600]];
    }else{
        [_lblStartTime setText:[NSString stringWithFormat:@"00:%02d:%02d",_timeCount/60,_timeCount%60]];
    }
}

-(void)clickBtnStartEnd{
    //取消接收状态，随便加一个数使状态不为1，2即可
    self.chartState = self.chartState + 20;
    
    [_timerSecond setFireDate:[NSDate distantFuture]];
    self.alert = [[JCAlertView alloc] initAlert2TwoBtnWithTitle:@"请确认结束练习" andBtn1Title:@"确认" andBtn2Title:@"取消"];
    [self.alert.btnOK addTarget:self action:@selector(showResVC) forControlEvents:UIControlEventTouchUpInside];
    [self.alert.btnCancel addTarget:self action:@selector(cancelAlert) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.alert];
}

-(void)showResVC{
    int aveValue = self.sumValue / self.practiceNumber;
    
    [self.viewControllerPracticeFinish setTime:self.lblStartTime.text andNum: [NSString stringWithFormat:@"%d",self.practiceNumber] andAve:[NSString stringWithFormat:@"%d",aveValue]];
    [self.navigationController pushViewController:self.viewControllerPracticeFinish animated:YES];
    [self.alert removeFromSuperview];
}

-(void)cancelAlert{
    //恢复接收状态
    self.chartState = self.chartState - 20;
    
    [self.alert removeFromSuperview];
    [_timerSecond setFireDate:[NSDate date]];
}

-(void)getBTData:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
    int value = [noti.object intValue];
    
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
            
            if ((self.midValue>self.startValue)&&(self.midValue>self.endValue)) {
                self.practiceNumber ++ ;
                
                //设置次数lbl
                NSDictionary *dic = @{NSKernAttributeName:@16.f};       //设置字间距
                NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",self.practiceNumber] attributes:dic];
                [_lblStartNumber setAttributedText:attributeStr];
                
                self.sumValue += self.midValue;
            }
        }
    }
    
    //绘制折线图
    switch (self.chartState) {
        case 1: //男性
            value = 120 - value;
            [self.manChart addLine:value];
            break;
        default:
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//页面完全出现
-(void)viewDidAppear:(BOOL)animated{
    //默认chart为男性
    self.chartState = 1;
    
    //将初始值定为－1，这样来判断是否赋值过
    self.startValue = -1;
    self.midValue = -1;
    self.endValue = -1;
    
    //初始握力次数为0
    self.practiceNumber = 0;
    
    self.sumValue = 0;
    
    //监听MainVC回传的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTData:) name:@"SendPracticeData" object:nil];
}

//页面完全消失
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除Notification监听");
    
    [self.viewPrepare setAlpha:1];
    [self.viewStart setAlpha:0];
    
    [_lblStartTime setText:@"00:00:00"];
    if (_timerSecond) {
        [_timerSecond invalidate];
        _timerSecond = nil;
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

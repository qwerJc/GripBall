//
//  PracticeFinishViewController.m
//  GripBall
//
//  Created by 贾辰 on 2017/11/5.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "PracticeFinishViewController.h"
#import "ModelLocator.h"

@interface PracticeFinishViewController ()
@property (strong, nonatomic)UILabel *lblTimeValue;
@property (strong, nonatomic)UILabel *lblNumberValue;
@property (strong, nonatomic)UILabel *lblAverageValue;
@end

@implementation PracticeFinishViewController

-(void)setTime:(NSString *)time andNum:(NSString *)num andAve:(NSString *)ave{
    [self.lblTimeValue setText:time];
    [self.lblNumberValue setText:num];
    [self.lblAverageValue setText:ave];
}

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
    UIImageView *imgVBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVBG];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.f,115.f, 100.f, 25.f)];
    [lblTitle setText:@"练习结果"];
    [lblTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTitle];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(75.f,160.f, SCREEN_WIDTH-150.f, 2)];
    [lblLine setBackgroundColor:[UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:1]];
    [self.view addSubview:lblLine];
    
    UILabel *lblTime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40.f,215.f, 80.f, 25.f)];
    [lblTime setText:@"练习时长"];
    [lblTime setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblTime setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblTime setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTime];
    
    _lblTimeValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.f,250.f, 100.f, 25.f)];
    [_lblTimeValue setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
    [_lblTimeValue setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [_lblTimeValue setTextAlignment:NSTextAlignmentCenter];
    NSDictionary *temDic = @{NSKernAttributeName:@0.8f};       //设置字间距
    [_lblTimeValue setAttributedText:[[NSAttributedString alloc] initWithString:@"00:00:00" attributes:temDic]];
    [self.view addSubview:_lblTimeValue];
    
    UILabel *lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40.f,310.f, 80.f, 25.f)];
    [lblNumber setText:@"练习次数"];
    [lblNumber setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblNumber setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblNumber setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblNumber];
    
    _lblNumberValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.f,345.f, 100.f, 25.f)];
    [_lblNumberValue setText:@"0"];
    [_lblNumberValue setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
    [_lblNumberValue setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [_lblNumberValue setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_lblNumberValue];
    
    UILabel *lblAverage = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40.f,405.f, 80.f, 25.f)];
    [lblAverage setText:@"平均握力"];
    [lblAverage setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lblAverage setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblAverage setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblAverage];
    
    _lblAverageValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.f,440.f, 100.f, 25.f)];
    [_lblAverageValue setText:@"0"];
    [_lblAverageValue setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
    [_lblAverageValue setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [_lblAverageValue setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_lblAverageValue];
    
    UIButton *btnEnd = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, 500.f, 171, 46.f)];
    [btnEnd setTitle:@"结束" forState:UIControlStateNormal];
    btnEnd.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnEnd setBackgroundImage:[UIImage imageNamed:@"practice_btn8"] forState:UIControlStateNormal];
    [btnEnd setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnEnd addTarget:self action:@selector(clickBtnEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnd];
}

-(void)clickBtnEnd{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
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

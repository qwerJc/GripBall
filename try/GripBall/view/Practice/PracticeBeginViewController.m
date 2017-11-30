//
//  PracticeBeginViewController.m
//  GripBall
//
//  Created by 贾辰 on 2017/11/5.
//  Copyright © 2017年 贾辰. All rights reserved.
//
//  此页负责联系模式中的准备阶段以及开始测试阶段

#import "PracticeBeginViewController.h"
#import "ModelLocator.h"

@interface PracticeBeginViewController ()
@property (strong, nonatomic) UIView *viewPrepare;  //准备阶段
@property (strong, nonatomic) UIView *viewStart;    //开始测试
@end

@implementation PracticeBeginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        
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
    
    UILabel *lblTPrepareTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 43.f,70.f, 86.f, 25.f)];
    [lblTPrepareTitle setText:@"练习模式"];
    [lblTPrepareTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTPrepareTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTPrepareTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewPrepare addSubview:lblTPrepareTitle];
    
    UIImageView *imgVState = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f, 62.f, 31.f, 31.f)];
    [imgVState setImage:[UIImage imageNamed:@"connect_state_on"]];
    [self.viewPrepare addSubview:imgVState];
    
    UIButton *btnStart = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90.f, 230.f, 180.f, 180.f)];
    [btnStart setBackgroundImage:[UIImage imageNamed:@"practice_icon5"] forState:UIControlStateNormal];
    [btnStart setTitle:@"开 始" forState:UIControlStateNormal];
    btnStart.titleLabel.font = [UIFont systemFontOfSize:18.0];
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
}

#pragma mark - 准备阶段
-(void)clickBtnStart{
    [UIView animateWithDuration:0.25 animations:^{
        [self.viewPrepare setAlpha:0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.viewStart setAlpha:1];
        }];
    }];
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

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

@interface EnduranceTestingRHandViewController ()
@property (strong, nonatomic)EnduranceFinishViewController *viewControllerFinish;

@property (strong, nonatomic) UIImageView *imgvTestState1;
@property (strong, nonatomic) UIImageView *imgvTestState2;
@property (strong, nonatomic) UIImageView *imgvTestState3;
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
    
    //    self.jcManChart = [[JCManValueChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40.f, 170.f, 80.f, 280.f)];
    //    [self.view addSubview:self.jcManChart];
    
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
    [self.navigationController pushViewController:self.viewControllerFinish animated:YES];
}
-(void)clickBtnBack{
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

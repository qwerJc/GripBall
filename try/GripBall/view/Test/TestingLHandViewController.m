//
//  TestingLHandViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/1/3.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TestingLHandViewController.h"
#import "ModelLocator.h"
#import "TestRHandViewController.h"

@interface TestingLHandViewController ()
@property (strong, nonatomic) TestRHandViewController *viewTestRHand;
@property (strong, nonatomic) UIImageView *imgvStrengValue;

@property (strong, nonatomic) UIImageView *imgvChoseState1;
@property (strong, nonatomic) UIImageView *imgvChoseState2;
@property (strong, nonatomic) UIImageView *imgvChoseState3;
@end



@implementation TestingLHandViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        
        self.viewTestRHand = [[TestRHandViewController alloc] init];
        
        [self createUI];
        
    }
    return self;
}

-(void)createUI
{
    // BGImage
    UIImageView *imgVPrepareBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
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
    self.imgvStrengValue =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40.f, 170.f, 80.f, 80.f)];
    [self.view addSubview:self.imgvStrengValue];
    UIImage *newImageTest = [[UIImage imageNamed:@"test_strengValue"] stretchableImageWithLeftCapWidth:0 topCapHeight:60];
//    [self.imgvStrengValue setImage:newImageTest];
    [self.imgvStrengValue setImage:[UIImage imageNamed:@"test_strengValue"]];
    
    self.imgvChoseState1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-47, 480.f, 18.f, 18.f)];
    [self.imgvChoseState1 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.view addSubview:self.imgvChoseState1];
    
    self.imgvChoseState2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-9, 480.f, 18.f, 18.f)];
    [self.imgvChoseState2 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.view addSubview:self.imgvChoseState2];
    
    self.imgvChoseState3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+29, 480.f, 18.f, 18.f)];
    [self.imgvChoseState3 setImage:[UIImage imageNamed:@"test_unChosen"]];
    [self.view addSubview:self.imgvChoseState3];
    
    UIButton *btnExit = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-130.f, 171, 46.f)];
    [btnExit setTitle:@"退出测试" forState:UIControlStateNormal];
    btnExit.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnExit setBackgroundImage:[UIImage imageNamed:@"test_btn_red"] forState:UIControlStateNormal];
    [btnExit setTitleColor:[UIColor colorWithRed:195.f/255.f green:195.f/255.f blue:195.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnExit addTarget:self action:@selector(clickBtnExit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExit];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Btn Delegate
-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickBtnExit{
    [self.navigationController pushViewController:self.viewTestRHand animated:YES];
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

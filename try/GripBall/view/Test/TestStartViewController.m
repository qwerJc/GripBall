//
//  TestStartViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/1/3.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TestStartViewController.h"
#import "ModelLocator.h"
#import "TestLHandViewController.h"

@interface TestStartViewController ()
@property (strong , nonatomic) TestLHandViewController *viewLHand;
@end

@implementation TestStartViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        
        self.viewLHand = [[TestLHandViewController alloc] init];
        
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
    [lblTPrepareTitle setText:@"练习模式"];
    [lblTPrepareTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTPrepareTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTPrepareTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTPrepareTitle];
    
    UIImageView *imgVState = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f, 62.f, 31.f, 31.f)];
    [imgVState setImage:[UIImage imageNamed:@"connect_state_on"]];
    [self.view addSubview:imgVState];
    
    UIButton *btnStart = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90.f, 230.f, 180.f, 180.f)];
    [btnStart setBackgroundImage:[UIImage imageNamed:@"practice_icon5"] forState:UIControlStateNormal];
    [btnStart setTitle:@"开 始" forState:UIControlStateNormal];
    btnStart.titleLabel.font = [UIFont systemFontOfSize:24.0];
    [btnStart setTitleColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnStart.layer setCornerRadius:90.f];
    [btnStart.layer setMasksToBounds:YES];
    [btnStart addTarget:self action:@selector(clickBtnStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStart];
    
    UILabel *lblTPrepareText1 = [[UILabel alloc] initWithFrame:CGRectMake(50.f,SCREEN_HEIGHT - 170.f, 60.f, 20.f)];
    [lblTPrepareText1 setText:@"规则："];
    [lblTPrepareText1 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText1 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText1 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblTPrepareText1];
    
    UILabel *lblTPrepareText2 = [[UILabel alloc] initWithFrame:CGRectMake(50.f,lblTPrepareText1.frame.origin.y + 20.f + 6.f, SCREEN_WIDTH - 80.f, 20.f)];
    [lblTPrepareText2 setText:@"测试单次抓握过程中的最大力"];
    [lblTPrepareText2 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText2 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText2 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblTPrepareText2];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Btn Delegate
-(void)clickBtnStart{
    [self.navigationController pushViewController:self.viewLHand animated:YES];
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

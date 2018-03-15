//
//  CompetitionStartViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/1/28.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "CompetitionStartViewController.h"
#import "ModelLocator.h"
#import "ExplodeStartViewController.h"
#import "EnduranceStartViewController.h"
#import "CompetitionListViewController.h"

@interface CompetitionStartViewController ()
@property (strong, nonatomic) ExplodeStartViewController    *viewControllerExplodeStart;
@property (strong, nonatomic) EnduranceStartViewController  *viewControllerEnduranceStart;
@property (strong, nonatomic) CompetitionListViewController *viewControllerList;
@end

@implementation CompetitionStartViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        self.viewControllerList = [[CompetitionListViewController alloc] init];
        
        self.viewControllerEnduranceStart = [[EnduranceStartViewController alloc] init];
        
        [self createUI];
        
    }
    return self;
}

-(void)createUI
{
    NSLog(@"%f,%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    // BGImage
    UIImageView *imgVPrepareBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVPrepareBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVPrepareBG];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(45.f, 62.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UILabel *lblTPrepareTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 43.f,70.f, 86.f, 25.f)];
    [lblTPrepareTitle setText:@"竞技模式"];
    [lblTPrepareTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTPrepareTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTPrepareTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTPrepareTitle];
    
    UIButton *btnExplode = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 285.f, SCREEN_WIDTH-200.f, 46.f)];
    [btnExplode setTitle:@"爆发力" forState:UIControlStateNormal];
    btnExplode.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnExplode setBackgroundImage:[UIImage imageNamed:@"competition_btn_black"] forState:UIControlStateNormal];
    [btnExplode setTitleColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnExplode addTarget:self action:@selector(onBtnExplode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExplode];
    
    UIButton *btnExplodeList = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100.f, 285.f, 40.f, 40.f)];
    [btnExplodeList setBackgroundImage:[UIImage imageNamed:@"competition_btn_list"] forState:UIControlStateNormal];
    [btnExplodeList addTarget:self action:@selector(onBtnExplodeList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExplodeList];
    
    UIButton *btnEndurance = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 415.f, SCREEN_WIDTH-200.f, 46.f)];
    [btnEndurance setTitle:@"耐力" forState:UIControlStateNormal];
    btnEndurance.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnEndurance setBackgroundImage:[UIImage imageNamed:@"competition_btn_black"] forState:UIControlStateNormal];
    [btnEndurance setTitleColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnEndurance addTarget:self action:@selector(onBtnEndurance) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEndurance];
    
    UIButton *btnEnduranceList = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100.f, 400.f, 40.f, 40.f)];
    [btnEnduranceList setBackgroundImage:[UIImage imageNamed:@"competition_btn_list"] forState:UIControlStateNormal];
    [btnEnduranceList addTarget:self action:@selector(onBtnEnduranceList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnduranceList];
    
}

#pragma mark - Btn Delegate
-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onBtnExplode{
    self.viewControllerExplodeStart = [[ExplodeStartViewController alloc] init];
    [self.navigationController pushViewController:self.viewControllerExplodeStart animated:YES];
}
-(void)onBtnExplodeList{
    [self.viewControllerList setTitle:@"爆发力竞技排行榜"];
    [self.navigationController pushViewController:self.viewControllerList animated:YES];
}
-(void)onBtnEndurance{
    self.viewControllerEnduranceStart = [[EnduranceStartViewController alloc] init];
    [self.navigationController pushViewController:self.viewControllerEnduranceStart animated:YES];
}
-(void)onBtnEnduranceList{
    [self.viewControllerList setTitle:@"耐力竞技排行榜"];
    [self.navigationController pushViewController:self.viewControllerList animated:YES];
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

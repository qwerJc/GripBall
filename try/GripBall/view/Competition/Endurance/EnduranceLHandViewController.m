//
//  EnduranceLHandViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/3/5.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "EnduranceLHandViewController.h"
#import "ModelLocator.h"
#import "EnduranceTestingLHandViewController.h"

@interface EnduranceLHandViewController ()
@property (strong, nonatomic)EnduranceTestingLHandViewController *viewControllerTestingLHand;
@end

@implementation EnduranceLHandViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        self.viewControllerTestingLHand = [[EnduranceTestingLHandViewController alloc] init];
        
        [self createUI];
        
    }
    return self;
}
-(void)createUI{
    UIImageView *imgVBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVBG];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(45.f, 62.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 55.f,70.f, 110.f, 25.f)];
    [lblTitle setText:@"爆发力比拼"];
    [lblTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTitle];
    
    UIButton *btnStart = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90.f, 230.f, 180.f, 180.f)];
    [btnStart setBackgroundImage:[UIImage imageNamed:@"practice_icon5"] forState:UIControlStateNormal];
    btnStart.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnStart setTitleColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnStart.layer setCornerRadius:90.f];
    [btnStart.layer setMasksToBounds:YES];
    [btnStart addTarget:self action:@selector(clickBtnStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStart];
    
    UILabel *lblTBtnStartName1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90.f,290, 180.f, 30.f)];
    [lblTBtnStartName1 setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTBtnStartName1 setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [lblTBtnStartName1 setTextAlignment:NSTextAlignmentCenter];
    //设置字间距
    NSDictionary *dic = @{NSKernAttributeName:@4.3f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"左手" attributes:dic];
    [lblTBtnStartName1 setAttributedText:attributeStr];
    [self.view addSubview:lblTBtnStartName1];
    
    UILabel *lblTBtnStartName2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90.f,320, 180.f, 30.f)];
    [lblTBtnStartName2 setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTBtnStartName2 setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [lblTBtnStartName2 setTextAlignment:NSTextAlignmentCenter];
    //设置字间距
    NSDictionary *dic2 = @{NSKernAttributeName:@4.3f};
    NSAttributedString *attributeStr2 = [[NSAttributedString alloc] initWithString:@"测验" attributes:dic2];
    [lblTBtnStartName2 setAttributedText:attributeStr2];
    [self.view addSubview:lblTBtnStartName2];
    
    UIImageView *imgVLhand = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-53.f, SCREEN_HEIGHT - 230.f, 42.f, 75.f)];
    [imgVLhand setImage:[UIImage imageNamed:@"test_Lhand_h"]];
    [self.view addSubview:imgVLhand];
    
    UIImageView *imgVRhand = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+11.f, SCREEN_HEIGHT - 230.f, 42.f, 75.f)];
    [imgVRhand setImage:[UIImage imageNamed:@"test_Rhand"]];
    [self.view addSubview:imgVRhand];
    
    UILabel *lblTPrepareText1 = [[UILabel alloc] initWithFrame:CGRectMake(90.f,SCREEN_HEIGHT-130.f, SCREEN_WIDTH - 80.f, 20.f)];
    [lblTPrepareText1 setText:@"竞技过程中，将抓握三次"];
    [lblTPrepareText1 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText1 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText1 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblTPrepareText1];
    
    UILabel *lblTPrepareText2 = [[UILabel alloc] initWithFrame:CGRectMake(90.f,SCREEN_HEIGHT-100.f, SCREEN_WIDTH - 80.f, 20.f)];
    [lblTPrepareText2 setText:@"取坚持时间最长的一次。"];
    [lblTPrepareText2 setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblTPrepareText2 setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTPrepareText2 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblTPrepareText2];
}

#pragma mark - Btn Delegate
-(void)clickBtnStart{
    [self.navigationController pushViewController:self.viewControllerTestingLHand animated:YES];
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

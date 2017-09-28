//
//  LoginViewController.m
//  GripBall
//
//  Created by 贾辰 on 2017/9/25.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "LoginViewController.h"
#import "ModelLocator.h"
#import "MainViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) UIButton *btnLogin;
@property (strong, nonatomic) MainViewController *viewControllerBlueTooth;

@end

@implementation LoginViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewControllerBlueTooth = [[MainViewController alloc] init];
        
        [self createUI];
        
    }
    return self;
}

-(void)createUI
{
    self.navigationItem.title = @"Login";
    
    self.btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-60.f, SCREEN_HEIGHT-40.f, 120.f,40.f)];
    [self.btnLogin addTarget:self
                      action:@selector(onClickedLogin)
            forControlEvents:UIControlEventTouchUpInside];
    [self.btnLogin setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.btnLogin];
}

#pragma btnEvent
-(void)onClickedLogin
{
    [self.navigationController pushViewController:self.viewControllerBlueTooth animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
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

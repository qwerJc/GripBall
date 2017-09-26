//
//  LoginViewController.m
//  GripBall
//
//  Created by 贾辰 on 2017/9/25.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "LoginViewController.h"
#import "ModelLocator.h"
#import "BlueToothViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) UIButton *btnLogin;
@property (strong, nonatomic) BlueToothViewController *viewControllerBlueTooth;

@end

@implementation LoginViewController

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//    }
//    return self;
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewControllerBlueTooth = [[BlueToothViewController alloc] init];
        
        [self createUI];
        
    }
    return self;
}

-(void)createUI
{
    self.btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-60.f, SCREEN_HEIGHT/2, 120.f,40.f)];
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

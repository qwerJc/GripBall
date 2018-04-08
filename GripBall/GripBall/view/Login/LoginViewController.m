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
#import "LoginTelphoneViewController.h"
#import "JCAlertLogin.h"

@interface LoginViewController ()
@property (strong ,nonatomic) UITextField *txvTel;
@property (strong ,nonatomic) UITextField *txvPwd;

@property (strong, nonatomic) UIButton *btnSignIn;//登陆
@property (strong, nonatomic) UIButton *btnSignUP;//注册

@property (strong, nonatomic) MainViewController *viewControllerBlueTooth;
@property (strong, nonatomic) LoginTelphoneViewController *viewControllerLoginTel;

@property (strong, nonatomic) JCAlertLogin *alert;

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
    UIImageView *imgVPrepareBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVPrepareBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVPrepareBG];
    
    UIImageView *imgVIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, 100, 120, 120)];
    [imgVIcon setImage:[UIImage imageNamed:@"Login_icon_BGRoll"]];
    [self.view addSubview:imgVIcon];
    
    UIImageView *imgVBGInput = [[UIImageView alloc] initWithFrame:CGRectMake(40, 270,SCREEN_WIDTH-80, SCREEN_HEIGHT-400)];
    [imgVBGInput setImage:[UIImage imageNamed:@"Login_white_BG_short"]];
    [self.view addSubview:imgVBGInput];
    
    UIImageView *imgVTelIcon = [[UIImageView alloc] initWithFrame:CGRectMake(70, 315, 20, 20)];
    [imgVTelIcon setImage:[UIImage imageNamed:@"Login_icon_Tel"]];
    [self.view addSubview:imgVTelIcon];
    
    self.txvTel = [[UITextField alloc] initWithFrame:CGRectMake(120, 310,SCREEN_WIDTH-200, 30)];
    [self.txvTel setPlaceholder:@"输入手机号"];
    self.txvTel.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.txvTel];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(120, 341,SCREEN_WIDTH-200, 1)];
    [viewLine setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [self.view addSubview:viewLine];
    
    UIImageView *imgVPwdIcon = [[UIImageView alloc] initWithFrame:CGRectMake(70, 395, 20, 20)];
    [imgVPwdIcon setImage:[UIImage imageNamed:@"Login_icon_pwd"]];
    [self.view addSubview:imgVPwdIcon];
    
    self.txvPwd = [[UITextField alloc] initWithFrame:CGRectMake(120, 390,SCREEN_WIDTH-200, 30)];
    [self.txvPwd setPlaceholder:@"输入密码"];
    [self.view addSubview:self.txvPwd];
    
    UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(120, 421,SCREEN_WIDTH-200, 1)];
    [viewLine2 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [self.view addSubview:viewLine2];
    
    self.btnSignIn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-200.f, 171, 46.f)];
    [self.btnSignIn setBackgroundImage:[UIImage imageNamed:@"Login_Btn3"] forState:UIControlStateNormal];
    [self.btnSignIn addTarget:self
                       action:@selector(onClickedSignIn)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnSignIn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.btnSignIn setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:self.btnSignIn];
    
    self.btnSignUP = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-110.f, 171, 46.f)];
    [self.btnSignUP setBackgroundImage:[UIImage imageNamed:@"connect_btn_blue"] forState:UIControlStateNormal];
    [self.btnSignUP addTarget:self
                       action:@selector(onClickedSignUP)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnSignUP setTitle:@"注册" forState:UIControlStateNormal];
    [self.btnSignUP setTitleColor:[UIColor colorWithRed:206.f/255.f green:206.f/255.f blue:206.f/255.f alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:self.btnSignUP];

}

#pragma mark - TouchEvent
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch@");
    [self.txvTel resignFirstResponder];
    [self.txvPwd resignFirstResponder];
}

#pragma mark - btnEvent
-(void)onClickedSignIn
{
    if (1) {
        self.viewControllerBlueTooth = [[MainViewController alloc] init];
        [self.navigationController pushViewController:self.viewControllerBlueTooth animated:YES];
    }else{
        self.alert = [[JCAlertLogin alloc] initWithTitle:@"账号或密码错误" andDetailTitle:@"请重新输入"];
        UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
        [rootWindow addSubview:self.alert];

    }
    
}
-(void)onClickedSignUP{
    self.viewControllerLoginTel = [[LoginTelphoneViewController alloc] init];
    [self.navigationController pushViewController:self.viewControllerLoginTel animated:YES];
    
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

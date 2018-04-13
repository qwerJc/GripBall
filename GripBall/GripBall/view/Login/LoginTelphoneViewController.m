//
//  LoginTelphoneViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/3/11.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "LoginTelphoneViewController.h"
#import "ModelLocator.h"
#import "LoginPasswordViewController.h"
#import "JCAlertLogin.h"

@interface LoginTelphoneViewController ()
@property (strong ,nonatomic) UITextField *txvTel;
@property (strong ,nonatomic) UITextField *txvVcoed;

@property (strong, nonatomic) UIButton *btnSignUP;//注册
@property (strong, nonatomic) UIButton *btnBackLogin;

@property (strong, nonatomic) LoginPasswordViewController *viewControllerPwd;
@property (strong, nonatomic) JCAlertLogin *alert;
@end

@implementation LoginTelphoneViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewControllerPwd = [[LoginPasswordViewController alloc] init];
        
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
    
    self.txvVcoed = [[UITextField alloc] initWithFrame:CGRectMake(120, 390,SCREEN_WIDTH-300, 30)];
//    [self.txvVcoed setPlaceholder:@"输入验证码"];
    self.txvVcoed.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.txvVcoed];
    
    UIButton *btnGetVCode = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-165, 390, 90, 30)];
    [btnGetVCode setBackgroundColor:[UIColor redColor]];
    [btnGetVCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnGetVCode setTitleColor:[UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnGetVCode addTarget:self
                       action:@selector(onBtnGetVCode)
             forControlEvents:UIControlEventTouchUpInside];
    [btnGetVCode.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:15.f]];
    [self.view addSubview:btnGetVCode];
    
    UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(120, 421,SCREEN_WIDTH-200, 1)];
    [viewLine2 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [self.view addSubview:viewLine2];
    
    self.btnSignUP = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-200.f, 171, 46.f)];
    [self.btnSignUP setBackgroundImage:[UIImage imageNamed:@"Login_Btn3"] forState:UIControlStateNormal];
    [self.btnSignUP addTarget:self
                       action:@selector(onBtnSignUP)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnSignUP setTitle:@"注册" forState:UIControlStateNormal];
    [self.btnSignUP setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:self.btnSignUP];
    
    self.btnBackLogin = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-110.f, 171, 46.f)];
    [self.btnBackLogin setBackgroundImage:[UIImage imageNamed:@"Login_Btn2"] forState:UIControlStateNormal];
    [self.btnBackLogin addTarget:self
                       action:@selector(onBtnBackLogin)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnBackLogin setTitle:@"返回登录" forState:UIControlStateNormal];
    [self.btnBackLogin setTitleColor:[UIColor colorWithRed:8.f/255.f green:8.f/255.f blue:8.f/255.f alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:self.btnBackLogin];
    
}

#pragma mark - TouchEvent
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch@");
    [self.txvTel resignFirstResponder];
    [self.txvVcoed resignFirstResponder];
}

#pragma mark - btnEvent
-(void)onBtnGetVCode{
    [httpModel getVcodeWithTelNum:self.txvTel.text Completion:^{
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        if (num == 2) {
            self.alert = [[JCAlertLogin alloc] initWithTitle:@"" andDetailTitle:@"已注册"];
            UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
            [rootWindow addSubview:self.alert];
            NSLog(@"已注册");
        }else if(num == 3){
            self.alert = [[JCAlertLogin alloc] initWithTitle:@"" andDetailTitle:@"未知错误"];
            UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
            [rootWindow addSubview:self.alert];
            NSLog(@"未知错误");
        }else{
            self.alert = [[JCAlertLogin alloc] initWithTitle:@"" andDetailTitle:@"请检查当前网络"];
            UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
            [rootWindow addSubview:self.alert];
            NSLog(@"请检查当前网络");
        }
    }];
}
-(void)onBtnSignUP
{
    [model setTelephone:self.txvTel.text];
    
    [httpModel registerWithTelNum:self.txvTel.text andVCode:self.txvVcoed.text Completion:^() {
        NSLog(@"成功");
        [self.navigationController pushViewController:self.viewControllerPwd animated:YES];
    } error:^(NSError *error, int num) {
        if (num == 2) {
            NSLog(@"已注册");
        }else if(num == 3){
            NSLog(@"验证码错误");
        }else if(num == 4){
            NSLog(@"验证码过期");
        }else if (num == 5){
            NSLog(@"未知错误");
        }else{
            NSLog(@"请检查当前网络");
        }
    }];
}
-(void)onBtnBackLogin{
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

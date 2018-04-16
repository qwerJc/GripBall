//
//  LoginPasswordViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/3/11.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "LoginPasswordViewController.h"
#import "ModelLocator.h"
#import "LoginInformationViewController.h"
#import "JCAlertLogin.h"

@interface LoginPasswordViewController ()
@property (strong ,nonatomic) UITextField *txvPwd;
@property (strong ,nonatomic) UITextField *txvPwd2;

@property (strong, nonatomic) UIButton *btnCertain;

@property (strong, nonatomic) LoginInformationViewController *viewControllerInfo;
@property (strong, nonatomic) JCAlertLogin *alert;
@end

@implementation LoginPasswordViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    UIImageView *imgVPrepareBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVPrepareBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVPrepareBG];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(45.f, 50.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100.f,200.f, 200.f, 25.f)];
    [lblTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [lblTitle setText:@"设置密码"];
    [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTitle];
    
    UIImageView *imgVBGInput = [[UIImageView alloc] initWithFrame:CGRectMake(40, 270,SCREEN_WIDTH-80, SCREEN_HEIGHT-400)];
    [imgVBGInput setImage:[UIImage imageNamed:@"Login_white_BG_short"]];
    [self.view addSubview:imgVBGInput];
    
    self.txvPwd = [[UITextField alloc] initWithFrame:CGRectMake(70, 310,SCREEN_WIDTH-140, 30)];
    [self.txvPwd setPlaceholder:@"请设置6-16位密码"];
    [self.txvPwd setValue:[UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txvPwd setValue:[UIFont fontWithName:@"ArialMT" size:15.f] forKeyPath:@"_placeholderLabel.font"];
    self.txvPwd.keyboardType = UIKeyboardTypeNumberPad;
    [self.txvPwd setSecureTextEntry:YES];
    [self.view addSubview:self.txvPwd];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(70, 341,SCREEN_WIDTH-140, 1)];
    [viewLine setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [self.view addSubview:viewLine];
    
    self.txvPwd2 = [[UITextField alloc] initWithFrame:CGRectMake(70, 390,SCREEN_WIDTH-140, 30)];
    self.txvPwd2.placeholder = @"请确认密码";
    [self.txvPwd2 setValue:[UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txvPwd2 setValue:[UIFont fontWithName:@"ArialMT" size:15.f]forKeyPath:@"_placeholderLabel.font"];
    self.txvPwd2.keyboardType = UIKeyboardTypeNumberPad;
    [self.txvPwd2 setSecureTextEntry:YES];
    [self.view addSubview:self.txvPwd2];
    
    UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(70, 421,SCREEN_WIDTH-140, 1)];
    [viewLine2 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [self.view addSubview:viewLine2];
    
    self.btnCertain = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-200.f, 171, 46.f)];
    [self.btnCertain setBackgroundImage:[UIImage imageNamed:@"Login_Btn3"] forState:UIControlStateNormal];
    [self.btnCertain addTarget:self
                       action:@selector(onBtnCertain)
             forControlEvents:UIControlEventTouchUpInside];
    [self.btnCertain setTitle:@"确认" forState:UIControlStateNormal];
    [self.btnCertain setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:self.btnCertain];
    
}

#pragma mark - TouchEvent
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch@");
    [self.txvPwd resignFirstResponder];
    [self.txvPwd2 resignFirstResponder];
}

#pragma mark - btnEvent
-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onBtnCertain
{
    //＊＊＊＊＊＊＊＊＊＊＊＊＊正式版需要取消注视，注释为判断输入的密码是否合法
    if (_txvPwd.text.length<6||_txvPwd.text.length>16||_txvPwd2.text.length<6||_txvPwd2.text.length>16) {
        self.alert = [[JCAlertLogin alloc] initWithTitle:@"请输入6-16位密码" andDetailTitle:@""];
        UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
        [rootWindow addSubview:self.alert];
    }else if (_txvPwd.text != _txvPwd2.text) {
        self.alert = [[JCAlertLogin alloc] initWithTitle:@"两次密码不一致" andDetailTitle:@"请重新输入"];
        UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
        [rootWindow addSubview:self.alert];
    }else{
        
        self.viewControllerInfo = [[LoginInformationViewController alloc] init];
        [self.viewControllerInfo setTelephone:[model telephone] andPwd:_txvPwd.text];
        [self.navigationController pushViewController:self.viewControllerInfo animated:YES];
        
//        //合法
//        [httpModel setPassWordWithPwd:_txvPwd.text Completion:^{
//            //成功
//            self.viewControllerInfo = [[LoginInformationViewController alloc] init];
//            [self.navigationController pushViewController:self.viewControllerInfo animated:YES];
//        } error:^(NSError *error, int num) {
//            if (num == 2 ) {
//                NSLog(@"完善失败");
//            }else{
//                NSLog(@"请检查当前网络");
//            }
//        }];
        
        
    }
    
    //*************************************************************************
//    self.viewControllerInfo = [[LoginInformationViewController alloc] init];
//    [self.viewControllerInfo setTelephone:@"18701459239"];
//    [self.navigationController pushViewController:self.viewControllerInfo animated:YES];
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

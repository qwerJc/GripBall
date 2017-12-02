//
//  MainViewController.m
//  GripBall
//
//  Created by 贾辰 on 17/9/26.
//  Copyright © 2017年 贾辰. All rights reserved.
//
//  主要的界面，负责蓝牙的搜索、连接、数据接受等
//

#import "MainViewController.h"
#import "SearchResViewController.h"
#import "ModelLocator.h"
#import "JCAlertView.h"
#import "ConnectResViewController.h"
     

@interface MainViewController ()
@property (strong, nonatomic) SearchResViewController   *viewControllerSearchRes;
@property (strong, nonatomic) ConnectResViewController  *viewControllerConnectRes;

@property (strong, nonatomic) UIButton                  *btnStart;
@property (strong, nonatomic) CBCentralManager          *manager;       // 中心管理者
@property (strong, nonatomic) CBPeripheral              *peripheral;
@property (strong, nonatomic) JCAlertView               *alert;
@property (strong, nonatomic) NSMutableArray            *arrPeripheralsList;

@property (strong, nonatomic) UIImageView               *imgViewState;

@property (strong, nonatomic) NSTimer                   *timeSearch;

@property (assign, nonatomic) BOOL                      isReConnect;
@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isReConnect = false;
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.viewControllerSearchRes = [[SearchResViewController alloc] init];
        self.viewControllerSearchRes.delegate = self;
        
        self.viewControllerConnectRes = [[ConnectResViewController alloc] init];
        
        self.arrPeripheralsList = [NSMutableArray array];
        
        
        [self createUI];
        
        
    }
    return self;
}

-(void)createUI
{
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //背景图片
    UIImageView *imgViewBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgViewBG];
    
    //头像
    UIImageView *imgHeadPic = [[UIImageView alloc] initWithFrame:CGRectMake(50.f, 47.5f, 60.f, 60.f)];
    [imgHeadPic setImage:[UIImage imageNamed:@"connect_head"]];
    [imgHeadPic.layer setCornerRadius:30.f];
    [self.view addSubview:imgHeadPic];
    
    //蓝牙状态图标
    self.imgViewState = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f, 62.f, 31.f, 31.f)];
    [self.imgViewState setImage:[UIImage imageNamed:@"connect_state_off"]];
    [self.view addSubview:self.imgViewState];
    
    //中部背景图片
    UIImageView *imgViewBG2 = [[UIImageView alloc] initWithFrame:CGRectMake(36.f, 141.f, SCREEN_WIDTH-72.f, 105.f)];
    [imgViewBG2 setImage:[UIImage imageNamed:@"connect_background2"]];
    [self.view addSubview:imgViewBG2];
    
    self.btnStart = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, SCREEN_HEIGHT-90, 171, 46.f)];
    [self.btnStart setTitle:@"Start Test" forState:UIControlStateNormal];
    [self.btnStart setBackgroundImage:[UIImage imageNamed:@"connect_btn_blue"] forState:UIControlStateNormal];
    [self.btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnStart addTarget:self action:@selector(clickBtnStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnStart];
    
    //-----------------[del]===================
    UIButton *temBtn = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 50.f, 80.f, 40.f)];
    [temBtn setBackgroundColor:[UIColor redColor]];
    [temBtn addTarget:self action:@selector(tem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temBtn];
    
    UIButton *temBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 50.f, 80.f, 40.f)];
    [temBtn2 setBackgroundColor:[UIColor redColor]];
    [temBtn2 addTarget:self action:@selector(tem2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temBtn2];
    
    UIButton *temBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 50.f, 80.f, 40.f)];
    [temBtn3 setBackgroundColor:[UIColor redColor]];
    [temBtn3 addTarget:self action:@selector(tem3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temBtn3];
    //=========================================
}

//-----------------[del]===================
-(void)tem{
    self.alert = [[JCAlertView alloc] initAlert3ReConnectWithTitle:@"手机与握力球断开连接" andBtn1Title:@"重新连接" andBtn2Title:@"回到首页"];
    [self.alert.btnCancel setBackgroundImage:[UIImage imageNamed:@"practice_btn3"] forState:UIControlStateNormal];
    [self.alert.btnOK addTarget:self action:@selector(reConnect) forControlEvents:UIControlEventTouchUpInside];
    [self.alert.btnCancel addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.alert];
}

-(void)tem2{
    [self.alert setAlert3WaitView];
}

-(void)tem3{
    [self]
}
//=========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)showSearchRes{
    if (self.arrPeripheralsList.count > 0) {
        //  搜索成功
        [self.viewControllerSearchRes showSuccessView:self.arrPeripheralsList];
    }else{
        //  搜索失败
        [self.viewControllerSearchRes showFailView];
    }
    [_manager stopScan];    //蓝牙停止搜索
}

#pragma BlueTooth Delegate
//  判断当前蓝牙状态
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBManagerStatePoweredOn:
        {
            NSLog(@"蓝牙已打开,请扫描外设");
            // 第一个参数填nil代表扫描所有蓝牙设备,第二个参数options也可以写nil
            [_manager scanForPeripheralsWithServices:nil options:nil];
            
            //弹出视图
            [self.navigationController pushViewController:self.viewControllerSearchRes animated:YES];
            
            self.timeSearch =  [NSTimer scheduledTimerWithTimeInterval:5.f
                                                                target:self
                                                              selector:@selector(showSearchRes)
                                                              userInfo:nil
                                                               repeats:NO];
        }
            break;
        case CBManagerStatePoweredOff:
        {
            self.alert = [[JCAlertView alloc] initWithTitle:@"蓝牙未打开" andDetailTitle:@"请在 设置-蓝牙 中开启" andBtnTitle:@"我知道了"];
            
            UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
            [rootWindow addSubview:self.alert];

            NSLog(@"蓝牙没有打开,请先打开蓝牙");
        }
            break;
        default:
        {
            self.alert = [[JCAlertView alloc] initWithTitle:@"" andDetailTitle:@"该设备不支持蓝牙功能,请检查系统设置" andBtnTitle:@"我知道了"];
            
            UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
            [rootWindow addSubview:self.alert];
            
            NSLog(@"该设备不支持蓝牙功能");
        }
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    // _dicoveredPeripherals是用来存放已经扫描到的外部设备
    // 如果发现了这个外围设备我就把它添加到这个数组里面
    
    if(![self.arrPeripheralsList containsObject:peripheral])//peripheral.name != NULL
    {
        NSLog(@"now : %@",peripheral.name);
        [self.arrPeripheralsList addObject:peripheral];
    }

}
// 中心管理者连接外设成功
- (void)centralManager:(CBCentralManager *)central // 中心管理者
  didConnectPeripheral:(CBPeripheral *)peripheral // 外设
{
    if (self.isReConnect) {         //判断是否为断线重连，如果是则直接不需要再次设置代理
//        [self.alert setAlert2SuccView];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"%s, line = %d, %@=连接成功", __FUNCTION__, __LINE__, peripheral.name);
        // 连接成功之后,可以进行服务和特征的发现
        
        [self.imgViewState setImage:[UIImage imageNamed:@"connect_state_on"]];
        
        [self.viewControllerConnectRes setLbl2Name:peripheral.name];
        [self.navigationController pushViewController:self.viewControllerConnectRes animated:YES];
        
        
        //  设置外设的代理
        self.peripheral.delegate = self;
        
        // 外设发现服务,传nil代表不过滤
        // 这里会触发外设的代理方法 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
        [self.peripheral discoverServices:nil];
    }
    
}
// 外设连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, line = %d, %@=连接失败", __FUNCTION__, __LINE__, peripheral.name);
}
// 断开链接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    self.alert = [[JCAlertView alloc] initAlert3ReConnectWithTitle:@"手机与握力球断开连接" andBtn1Title:@"重新连接" andBtn2Title:@"回到首页"];
    [self.alert.btnCancel setBackgroundImage:[UIImage imageNamed:@"practice_btn3"] forState:UIControlStateNormal];
    [self.alert.btnOK addTarget:self action:@selector(reConnect) forControlEvents:UIControlEventTouchUpInside];
    [self.alert.btnCancel addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.alert];
}
//断开连接后的断线重连
-(void)reConnect{
    self.isReConnect = true;
    [self.manager connectPeripheral:self.peripheral options:nil];
//    [self.alert setAlert2WaitView];
}
//断开连接后的回到首页
-(void)backToMain{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MainViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    [self.alert removeFromSuperview];
}

#pragma Btn Event
-(void)clickBtnStart
{
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{@"CBCentralManagerOptionShowPowerAlertKey":@NO}];
}

#pragma SearchResult delegate
//选择连接
-(void)blueToothConnect:(int)index{
    NSLog(@"点击的是 ：%d",index);
    self.peripheral = [self.arrPeripheralsList objectAtIndex:index];
    [self.manager connectPeripheral:self.peripheral options:nil];
}

//重新搜索
-(void)reSearch{
    [self clickBtnStart];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.arrPeripheralsList removeAllObjects];

}

-(void)viewWillAppear:(BOOL)animated{
    if (self.timeSearch) {
        [self.timeSearch invalidate];
        self.timeSearch = nil;
    }
    [_manager stopScan];    //蓝牙停止搜索
}
-(void)viewDidDisappear:(BOOL)animated{
//    [self.manager stopScan];
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

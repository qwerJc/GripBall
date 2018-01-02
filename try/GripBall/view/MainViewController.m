//
//  MainViewController.m
//  GripBall

//  [try]

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
@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
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
    self.navigationItem.title = @"Main";
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
}

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
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"%s, line = %d, %@=连接成功", __FUNCTION__, __LINE__, peripheral.name);
    // 连接成功之后,可以进行服务和特征的发现
    
    [self.imgViewState setImage:[UIImage imageNamed:@"connect_state_on"]];
    
    //  设置外设的代理
    self.peripheral.delegate = self;
    
    // 外设发现服务,传nil代表不过滤
    // 这里会触发外设的代理方法 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    [self.peripheral discoverServices:nil];
}

//如果查询到外设的服务，执行回调
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"查询到外设服务");
    if (error)
    {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    //服务并不是我们的目标，也没有实际意义。我们需要用的是服务下的特征，查询（每一个服务下的若干）特征
    for (CBService *service in peripheral.services)
    {
        NSLog(@"serve %@",service);
        [peripheral discoverCharacteristics:nil forService:service];
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
    
}

// 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    
    CBUUID *sUUID0 = [CBUUID UUIDWithString:@"DFB0"];
    CBUUID *sUUID1 = [CBUUID UUIDWithString:@"DFB1"];
    CBUUID *sUUID2 = [CBUUID UUIDWithString:@"DFB2"];
    
    for (CBCharacteristic *cha in service.characteristics) {
        
        if ([cha.UUID  isEqual: sUUID0]) {
            NSLog(@"这是用于数据写入的特征,它的UUID是:\(characteristic.UUID)");
        }else if([cha.UUID isEqual:sUUID1]){
            NSLog(@"这是用于读取数据的特征,它的UUID是:\(characteristic.UUID)");
            //  8、进行监听
            [self.peripheral setNotifyValue:YES forCharacteristic:cha];
            
        }else if([cha.UUID isEqual:sUUID2]){
            NSLog(@"这是用于读取数据的特征,它的UUID是:\(characteristic.UUID)");
            //  8、进行监听
            [self.peripheral setNotifyValue:YES forCharacteristic:cha];
            
        }else{
            NSLog(@"发现了特征值 char = %@", cha);
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    NSLog(@"找到了数据！！！,%@",characteristic);
    if ([characteristic isEqual: @"你要的特征的UUID或者是你已经找到的特征"] ) {
        //characteristic.value就是你要的数据
    }
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

//重新连接
-(void)reConnect{
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

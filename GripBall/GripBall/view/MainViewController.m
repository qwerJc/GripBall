//
//  MainViewController.m
//  GripBall
//
//  Created by 贾辰 on 17/9/26.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "MainViewController.h"
#import "SearchResViewController.h"
#import "ModelLocator.h"
#import "JCAlertView.h"
     

@interface MainViewController ()
@property (strong, nonatomic) SearchResViewController   *viewControllerSearchRes;
@property (strong, nonatomic) UIButton                  *btnStart;
@property (strong, nonatomic) CBCentralManager          *manager;
@property (strong, nonatomic) CBPeripheral              *peripheral;
@property (strong, nonatomic) JCAlertView               *alert;
@property (strong, nonatomic) NSMutableArray            *arrPeripheralsList;

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.viewControllerSearchRes = [[SearchResViewController alloc] init];
        self.arrPeripheralsList = [NSMutableArray array];
        
        
        [self createUI];
        
        
    }
    return self;
}

-(void)createUI
{
    self.navigationItem.title = @"Main";
    
    self.btnStart = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 80.f)];
    [self.btnStart setTitle:@"Start Test" forState:UIControlStateNormal];
    [self.btnStart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnStart addTarget:self action:@selector(clickBtnStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnStart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma BlueTooth Delegate
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
            
            double delayInSeconds = 10.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //执行事件
                [self.viewControllerSearchRes showSuccessView:self.arrPeripheralsList];
            });
        }
            break;
        case CBManagerStatePoweredOff:
        {
            self.alert = [[JCAlertView alloc] initWithTitle:@"1" andDetailTitle:@"蓝牙没有打开,请先打开蓝牙" andBtnTitle:@"确定"];
            
            UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
            [rootWindow addSubview:self.alert];

            NSLog(@"蓝牙没有打开,请先打开蓝牙");
        }
            break;
        default:
        {
            self.alert = [[JCAlertView alloc] initWithTitle:@"1" andDetailTitle:@"该设备不支持蓝牙功能,请检查系统设置" andBtnTitle:@"确定"];
            
            UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
            [rootWindow addSubview:self.alert];
            
            NSLog(@"该设备不支持蓝牙功能,请检查系统设置");
        }
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
//    NSLog(@"peripheral = %@, advertisementData = %@, RSSI = %@", peripheral, advertisementData, RSSI);
    
    // _dicoveredPeripherals是用来存放已经扫描到的外部设备
    // 如果发现了这个外围设备我就把它添加到这个数组里面
    
    if(![self.arrPeripheralsList containsObject:peripheral] && peripheral.name != NULL)
        [self.arrPeripheralsList addObject:peripheral];
}


#pragma Btn Event
-(void)clickBtnStart
{
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{@"CBCentralManagerOptionShowPowerAlertKey":@NO}];
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

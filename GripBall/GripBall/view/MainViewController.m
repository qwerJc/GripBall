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
#import "JCAlertLogin.h"
#import "TendencyViewController.h"

#import "ShowAllUserViewController.h"

#import "ConnectResViewController.h"

#import "MainViewListCell.h"
     

@interface MainViewController ()
@property (strong, nonatomic) SearchResViewController   *viewControllerSearchRes;
@property (strong, nonatomic) ConnectResViewController  *viewControllerConnectRes;

@property (strong, nonatomic) UIButton                  *btnStart;
@property (strong, nonatomic) UIButton                  *btnChangeUser;

@property (strong, nonatomic) CBCentralManager          *manager;       // 中心管理者
@property (strong, nonatomic) CBPeripheral              *peripheral;
@property (strong, nonatomic) JCAlertLogin              *alertLogin;
@property (strong, nonatomic) JCAlertView               *alert;
@property (strong, nonatomic) JCAlertView               *alertConnectSucc;
@property (strong, nonatomic) JCAlertView               *alertConnectFail;
@property (strong, nonatomic) NSMutableArray            *arrPeripheralsList;

@property (strong, nonatomic) UIImageView               *imgViewState;

@property (strong, nonatomic) NSTimer                   *timeSearch;

@property (assign, nonatomic) BOOL                      isReConnect;
@property (assign, nonatomic) int                       choiceModelState;   //进入子View状态 ：－1为未选择；0为练习模式；1为测验模式；2为竞技－爆发力模式；3为竞技－耐力模式

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
        
        self.choiceModelState = -1;
        //注册接收者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SignOut) name:@"SignOut" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetPracticeBegin) name:@"PracticeModelBegin" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetTestBegin) name:@"TestModelBegin" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetEnduranceBegin) name:@"EnduranceModelBegin" object:nil];
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //背景图片
    UIImageView *imgVBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVBG];
    
    //头像
    UIImageView *imgHeadPic = [[UIImageView alloc] initWithFrame:CGRectMake(50.f, 47.5f, 60.f, 60.f)];
    [imgHeadPic setImage:[UIImage imageNamed:@"connect_head"]];
    [imgHeadPic.layer setCornerRadius:30.f];
    [self.view addSubview:imgHeadPic];
    
    _btnChangeUser = [[UIButton alloc] initWithFrame:imgHeadPic.frame];
    [_btnChangeUser.layer setCornerRadius:30.f];
    [_btnChangeUser.layer masksToBounds];
//    [_btnChangeUser setBackgroundColor:[UIColor redColor]];
    [_btnChangeUser addTarget:self action:@selector(onBtnChangeUserAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnChangeUser];
    
    //蓝牙状态图标
    self.imgViewState = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80.f, 62.f, 31.f, 31.f)];
    [self.imgViewState setImage:[UIImage imageNamed:@"connect_state_off"]];
    [self.view addSubview:self.imgViewState];
    
    //中部背景图片
    UIImageView *imgViewBG2 = [[UIImageView alloc] initWithFrame:CGRectMake(24.f, 141.f, SCREEN_WIDTH-48.f, 105.f)];
    [imgViewBG2 setImage:[UIImage imageNamed:@"connect_background2"]];
    [self.view addSubview:imgViewBG2];
    
    UIButton *btnShowTendency = [[UIButton alloc] initWithFrame:CGRectMake(36.f, 141.f, SCREEN_WIDTH-72.f, 105.f)];
    [btnShowTendency setBackgroundColor:[UIColor clearColor]];
    [btnShowTendency addTarget:self action:@selector(onBtnShowTendency) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShowTendency];
    
    UIImageView *imgViewBGTableView = [[UIImageView alloc] initWithFrame:CGRectMake(40.f,260.f, SCREEN_WIDTH-80.f, SCREEN_HEIGHT-400)];
    [imgViewBGTableView setImage:[UIImage imageNamed:@"Login_white_BG_short"]];
    [self.view addSubview:imgViewBGTableView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(21,12.f, 60.f, 20.f)];
    [label setTextColor:[UIColor colorWithRed:75.f/255.f green:76.f/255.f blue:78.f/255.f alpha:1]];
//    [label setTextColor:[UIColor blackColor]];
    [label setText:@"使用记录"];
    [label setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [imgViewBGTableView addSubview:label];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(42,295.f, SCREEN_WIDTH-82.f, SCREEN_HEIGHT-445)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [tableView setBackgroundColor:[UIColor redColor]];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
    
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

#pragma tableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[model newestListData] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CIdentifier = @"CellIdentifier";
    
    MainViewListCell *cell = [tableView dequeueReusableCellWithIdentifier:CIdentifier];
    if (cell == nil) {
        cell = [[MainViewListCell alloc]initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:CIdentifier];
    }
    [cell setDataDic:[[[model newestListData] objectAtIndex:indexPath.row] objectAtIndex:1]];
    return cell;
    
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
        self.alertConnectSucc = [[JCAlertView alloc] initAlert3OneBackBtnAndOneIcon:[UIImage imageNamed:@"practice_Icon1"] andOneTitle:@"连接成功"];
        [self.alertConnectSucc.btnOK addTarget:self action:@selector(onAlertConnectSucc) forControlEvents:UIControlEventTouchUpInside];
        UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
        [rootWindow addSubview:self.alertConnectSucc];
        [self.alertConnectFail removeFromSuperview];
        
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
//已发现服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    NSLog(@"发现服务.");
    
    for (CBService *s in peripheral.services) {
        NSLog(@"服务 UUID: %@(%@)",s.UUID.data,s.UUID);
        
        // 扫描到服务后,根据服务发现特征（然后跳转到监听特征值）
        [peripheral discoverCharacteristics:nil forService:s];
        
    }
}
// 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    
    for (CBCharacteristic *cha in service.characteristics) {
        NSLog(@"%s, line = %d, char = %@", __FUNCTION__, __LINE__, cha);
        [_peripheral setNotifyValue:YES forCharacteristic:cha];
    }
}
//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    //DFB1为读 DFB2为写
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"DFB1"]]) {
        NSData *data = characteristic.value;
//        Byte * resultByte = (Byte *)[data bytes];
        
//        NSLog(@"===============================");
//        // 此处的byte数组就是接收到的数据
//        NSLog(@"%s", resultByte);
        
        NSString *strSend = [[NSString alloc]initWithData: data encoding:NSUTF8StringEncoding];
        //判断当前选择模式发送数据
        switch (self.choiceModelState) {
            case 0:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SendPracticeData" object:strSend];
                break;
            case 1:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SendTestData" object:strSend];
                break;
            case 2:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SendEnduranceData" object:strSend];
                break;
            default:
                break;
        }
    }
}

// 断开链接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
    self.alertConnectFail = [[JCAlertView alloc] initAlert3OneBackBtnAndOneIcon:[UIImage imageNamed:@"practice_icon2"] andOneTitle:@"连接断开，请检查握力球"];
    [self.alertConnectFail.btnOK addTarget:self action:@selector(onAlertConnectFail) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.alertConnectFail];
    [self.manager connectPeripheral:self.peripheral options:nil];
    self.isReConnect = true;
}

#pragma mark - Btn Event
//显示所有用户
-(void)onBtnChangeUserAction{
    ShowAllUserViewController *viewControllerShow = [[ShowAllUserViewController alloc] init];
    viewControllerShow.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [httpModel getUserListWithCompletion:^(NSArray *arr) {
//        NSLog(@"获取列表成功");
        [model setAllUserList:arr];
        
        [viewControllerShow setRoleList:[model getElseUserList:[[model userInfo] getRid]]];
        
        [self presentViewController:viewControllerShow animated:YES completion:nil];
    } error:^(NSError *error, int num) {
        self.alertLogin = [[JCAlertLogin alloc] initWithTitle:@"请检查当前网络" andDetailTitle:@""];
        UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
        [rootWindow addSubview:self.alertLogin];
    }];
//    [self presentViewController:viewControllerShow animated:YES completion:nil];
}
-(void)onBtnShowTendency{
    TendencyViewController *viewControllerTendency = [[TendencyViewController alloc] init];
    [self.navigationController pushViewController:viewControllerTendency animated:YES];
}
-(void)clickBtnStart
{
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{@"CBCentralManagerOptionShowPowerAlertKey":@NO}];
}
-(void)onAlertConnectSucc{
    [self.peripheral discoverServices:nil];
    [self.alertConnectSucc removeFromSuperview];
}
-(void)onAlertConnectFail{
    [self.alertConnectFail removeFromSuperview];
}
#pragma mark - SearchResult delegate
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

#pragma mark - 选择模式后的Notification监听
-(void)SignOut{
    NSLog(@"退出登录111");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)GetPracticeBegin{
    NSLog(@"进入了 练习模式");
    self.choiceModelState = 0;
}

-(void)GetTestBegin{
    NSLog(@"进入了 测试模式");
    self.choiceModelState = 1;
}

-(void)GetEnduranceBegin{
    NSLog(@"进入了 爆发力模式");
    self.choiceModelState = 2;
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

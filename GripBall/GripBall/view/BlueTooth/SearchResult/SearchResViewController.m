//
//  SearchResViewController.m
//  GripBall
//
//  Created by 贾辰 on 17/9/27.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "SearchResViewController.h"
#import "ModelLocator.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface SearchResViewController ()
@property (strong, nonatomic) UIView *viewSearch;           //等待界面
@property (strong, nonatomic) UIImageView *imgViewRoll;     //等待界面旋转图标

@property (strong, nonatomic) UIView *viewSearchSuccess;
@property (strong, nonatomic) NSMutableArray *arrList;
@property (strong, nonatomic) UITableView *tableview;

@property (strong, nonatomic) UIView *viewSearchFail;

@end

@implementation SearchResViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];

        [self createUI];
        
    }
    return self;
}

-(void)createUI
{
    [self.view setBackgroundColor:[UIColor blackColor]];
    //-----------------------------【SearchView】---------------------------
    // BGView
    self.viewSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewSearch setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.viewSearch];
    // BGImage
    UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgViewBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.viewSearch addSubview:imgViewBG];
    // Roll Icon
    self.imgViewRoll = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-80.f, 177.f, 160.f, 160.f)];
    [self.imgViewRoll setImage:[UIImage imageNamed:@"connect_background5"]];
    [self.viewSearch addSubview:self.imgViewRoll];

    UILabel *lblSearch1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50.f, 440.f, 100.f, 20.f)];
    [lblSearch1 setText:@"设备搜索中"];
    [lblSearch1 setTextColor:[UIColor whiteColor]];
    [lblSearch1 setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblSearch1 setTextAlignment:NSTextAlignmentCenter];
    [self.viewSearch addSubview:lblSearch1];
    
    UILabel *lblSearch2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.f,440.f+19.f, 100.f, 20.f)];
    [lblSearch2 setText:@"..."];
    [lblSearch2 setTextColor:[UIColor whiteColor]];
    [lblSearch2 setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblSearch2 setTextAlignment:NSTextAlignmentCenter];
    [self.viewSearch addSubview:lblSearch2];
    
    //-----------------------------【SearSuccess】---------------------------
    self.viewSearchSuccess = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewSearchSuccess setAlpha:0];
    [self.view addSubview:self.viewSearchSuccess];
    
    // BG
    UIImageView *searchSuccBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_background"]];
    [self.viewSearchSuccess addSubview:searchSuccBG];
    
    UILabel *lblTSearchSuccTlitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-48.f, 100.f, 96.f, 25.f)];
    [lblTSearchSuccTlitle setText:@"搜索成功"];
    [lblTSearchSuccTlitle setTextColor:[UIColor colorWithRed:164.f/255.f green:164.f/255.f blue:164.f/255.f alpha:1]];
    [lblTSearchSuccTlitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblTSearchSuccTlitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewSearchSuccess addSubview:lblTSearchSuccTlitle];
    
    UILabel *lblTSearchSuccText1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100.f, 362.f, 200.f, 16.f)];
    [lblTSearchSuccText1 setText:@"搜索到以下设备"];
    [lblTSearchSuccText1 setTextColor:[UIColor colorWithRed:221.f/255.f green:221.f/255.f blue:221.f/255.f alpha:1]];
    [lblTSearchSuccText1 setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblTSearchSuccText1 setTextAlignment:NSTextAlignmentCenter];
    [self.viewSearchSuccess addSubview:lblTSearchSuccText1];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(35.f, 350.f, SCREEN_WIDTH-70.f, SCREEN_HEIGHT-350.f-35.f)];
    [self.tableview.layer setCornerRadius:10.f];
//    [self.tableview setBackgroundView:[UIImage imageNamed:@"connect_rectangle_l"]];
    [self.viewSearchSuccess addSubview:self.tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    //-----------------------------【SearchFail】---------------------------
    self.viewSearchFail = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewSearchFail  setBackgroundColor:[UIColor blackColor]];
    [self.viewSearchFail setAlpha:0];
    [self.view addSubview:self.viewSearchFail];
    
    // BGImage
    UIImageView *searchFailBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [searchFailBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.viewSearchFail addSubview:searchFailBG];
    
    UILabel *lblSearchFailitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-48.f, 100.f, 96.f, 25.f)];
    [lblSearchFailitle setText:@"搜索失败"];
    [lblSearchFailitle setTextColor:[UIColor colorWithRed:164.f/255.f green:164.f/255.f blue:164.f/255.f alpha:1]];
    [lblSearchFailitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
    [lblSearchFailitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewSearchFail addSubview:lblSearchFailitle];
    
    UIImageView *failIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-45.f, 208.f, 90.f, 90.f)];
    [failIcon setImage:[UIImage imageNamed:@"connect_background3"]];
    [self.viewSearchFail addSubview:failIcon];
    
    UILabel *lblTSearchText1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100.f, 332.f, 200.f, 16.f)];
    [lblTSearchText1 setText:@"很抱歉，设备搜索失败"];
    [lblTSearchText1 setTextColor:[UIColor colorWithRed:221.f/255.f green:221.f/255.f blue:221.f/255.f alpha:1]];
    [lblTSearchText1 setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblTSearchText1 setTextAlignment:NSTextAlignmentCenter];
    [self.viewSearchFail addSubview:lblTSearchText1];
    
    UILabel *lblTSearchText2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100.f, 362.f, 200.f, 16.f)];
    [lblTSearchText2 setText:@"请查看握力球开关是否打开"];
    [lblTSearchText2 setTextColor:[UIColor colorWithRed:221.f/255.f green:221.f/255.f blue:221.f/255.f alpha:1]];
    [lblTSearchText2 setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblTSearchText2 setTextAlignment:NSTextAlignmentCenter];
    [self.viewSearchFail addSubview:lblTSearchText2];
    
    UIButton *btnSearchFail1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, 470, 171, 46.f)];
    [btnSearchFail1 setTitle:@"重新连接" forState:UIControlStateNormal];
    btnSearchFail1.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnSearchFail1 setBackgroundImage:[UIImage imageNamed:@"connect_btn_red"] forState:UIControlStateNormal];
    [btnSearchFail1 setTitleColor:[UIColor colorWithRed:227.f/255.f green:227.f/255.f blue:227.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnSearchFail1 addTarget:self action:@selector(clickBtnSearchFail1) forControlEvents:UIControlEventTouchUpInside];
    [self.viewSearchFail addSubview:btnSearchFail1];
    
    UIButton *btnSearchFail2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-85.5f, 550, 171, 46.f)];
    [btnSearchFail2 setTitle:@"回到首页" forState:UIControlStateNormal];
    btnSearchFail2.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnSearchFail2 setBackgroundImage:[UIImage imageNamed:@"connect_btn_gray"] forState:UIControlStateNormal];
    [btnSearchFail2 setTitleColor:[UIColor colorWithRed:21.f/255.f green:21.f/255.f blue:21.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnSearchFail2 addTarget:self action:@selector(clickBtnSearchFail2) forControlEvents:UIControlEventTouchUpInside];
    [self.viewSearchFail addSubview:btnSearchFail2];
}

#pragma mark - SearchSuccess
-(void)showSuccessView:(NSMutableArray *)arr{
    self.arrList = arr;

    [self.tableview reloadData];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.viewSearch setAlpha:0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.viewSearchSuccess setAlpha:1];
        }];
    }];
    
    NSLog(@"list :%@",self.arrList);
}

#pragma mark - tableView代理实现

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CIdentifier];
    }
    CBPeripheral *peripheral = [self.arrList objectAtIndex:indexPath.row];
    if (peripheral.name == NULL) {
        cell.textLabel.text = @"未知蓝牙信号";
    }else{
        cell.textLabel.text = peripheral.name;
    }
    
    return cell;
        
}
//点击tableview表单事件，从0行开始
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(blueToothConnect:)]) { // 如果协议响应了sendValue:方法
        [_delegate blueToothConnect:indexPath.row]; // 通知执行协议方法
    }

}
#pragma mark - SearchFail

-(void)showFailView{
    [UIView animateWithDuration:0.25 animations:^{
        [self.viewSearch setAlpha:0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.viewSearchFail setAlpha:1];
        }];
    }];
    
}

#pragma mark - SearchFail - Btn
-(void)clickBtnSearchFail1{
    [self.navigationController popViewControllerAnimated:YES];
    if ([_delegate respondsToSelector:@selector(reSearch)]) { // 如果协议响应了sendValue:方法
        [_delegate reSearch]; // 通知执行协议方法
    }
}

-(void)clickBtnSearchFail2{     //回到首页
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 其他

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated{
    //  等待图标旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:M_PI*40];
    animation.duration = 20; // 持续时间

    [self.imgViewRoll.layer addAnimation:animation forKey:@"rotate-layer"];
    
}
-(void)viewDidAppear:(BOOL)animated{
//    [self.imgViewRoll.layer removeAllAnimations];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.viewSearch setAlpha:1];
    [self.viewSearchFail setAlpha:0];
    [self.viewSearchSuccess setAlpha:0];
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

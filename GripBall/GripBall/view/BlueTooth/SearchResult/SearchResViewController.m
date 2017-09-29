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
@property (strong, nonatomic) UIView *viewSearch;
@property (strong, nonatomic) UIImageView *imgView;

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
    self.navigationItem.title = @"Search";
    
    // Search View
    self.viewSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewSearch setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.viewSearch];

    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50.f, SCREEN_HEIGHT/2 - 50.f, 100.f, 100.f)];
    [self.imgView setBackgroundColor:[UIColor purpleColor]];
    [self.viewSearch addSubview:self.imgView];
    
    self.viewSearchSuccess = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.viewSearchSuccess setBackgroundColor:[UIColor orangeColor]];
    [self.viewSearchSuccess setAlpha:0];
    [self.view addSubview:self.viewSearchSuccess];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2-5.f)];
    [self.viewSearchSuccess addSubview:self.tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
}

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
    return 50;
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
   
    switch (indexPath.row) {
        case 0:         //选择服务器
            
            break;
        case 1:         //重设引导信息
            
            break;
        case 2:
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated{
    [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear animations:^{
        [self.imgView setTransform:CGAffineTransformRotate(self.imgView.transform,3.14f)];
    } completion:nil];
}
-(void)viewDidAppear:(BOOL)animated{

}

-(void)viewDidDisappear:(BOOL)animated{
    [self.viewSearch setAlpha:1];
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

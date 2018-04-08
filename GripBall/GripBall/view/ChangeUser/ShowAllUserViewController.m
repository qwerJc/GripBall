//
//  ShowAllUserViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/3/12.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ShowAllUserViewController.h"
#import "ModelLocator.h"
#import "ListUserCell.h"
#import "AddUserViewController.h"
#import "ShowInfoViewController.h"

@interface ShowAllUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong , nonatomic) UIImageView *imvHead;
@property (strong , nonatomic) UILabel     *lblName;
@end

@implementation ShowAllUserViewController
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(36, 30, SCREEN_WIDTH -72, SCREEN_HEIGHT-160)];
//    [viewContainer setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:viewContainer];
    // Do any additional setup after loading the view.
    
    UIImageView *imvBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewContainer.frame.size.width, viewContainer.frame.size.height)];
    [imvBG setImage:[UIImage imageNamed:@"Login_white_BG_long"]];
    [viewContainer addSubview:imvBG];
    
    UIButton *btnNowUser = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewContainer.frame.size.width, 88)];
    [btnNowUser addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [viewContainer addSubview:btnNowUser];
    
    _imvHead = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 60,60)];
    [_imvHead setImage:[UIImage imageNamed:@"connect_head"]];
    [viewContainer addSubview:_imvHead];
    
    _lblName = [[UILabel alloc] initWithFrame:CGRectMake(90, 34, 100, 20)];
    [_lblName setText:@"Michale"];
    [_lblName setTextColor:[UIColor colorWithRed:100.f/255.f green:100.f/255.f blue:100.f/255.f alpha:1]];
    [_lblName setFont:[UIFont fontWithName:@"ArialMT" size:15.f]];
    [_lblName setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:_lblName];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(1, 90, viewContainer.frame.size.width-2, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:225.f/255.f green:225.f/255.f blue:225.f/255.f alpha:1]];
    [viewContainer addSubview:line];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(1,90,viewContainer.frame.size.width-2,viewContainer.frame.size.height-190) style:UITableViewStyleGrouped];
    tableview.dataSource=self;
    tableview.delegate = self;
    [tableview setBackgroundColor:[UIColor clearColor]];
    [viewContainer addSubview:tableview];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(1, viewContainer.frame.size.height-101, viewContainer.frame.size.width-2, 1)];
    [line2 setBackgroundColor:[UIColor lightGrayColor]];
    [viewContainer addSubview:line2];
    
    UIButton *btnBottomView = [[UIButton alloc] initWithFrame:CGRectMake(0,viewContainer.frame.size.height-99, viewContainer.frame.size.width, 90)];
//    [btnBottomView setBackgroundColor:[UIColor clearColor]];
    [viewContainer addSubview:btnBottomView];
    
    UIButton *btnAddUser = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width/2-85.5f, viewContainer.frame.size.height-70, 171, 46.f)];
    [btnAddUser setTitle:@"添加新用户" forState:UIControlStateNormal];
    btnAddUser.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnAddUser setBackgroundImage:[UIImage imageNamed:@"Change_btn_black"] forState:UIControlStateNormal];
    [btnAddUser setTitleColor:[UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:255.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnAddUser addTarget:self action:@selector(onBtnAdd) forControlEvents:UIControlEventTouchUpInside];
    [viewContainer addSubview:btnAddUser];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableView
//添加编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了。。%ld",(long)indexPath.row);
        
        tableView.editing = NO;
        //删除数组，刷新列表
        //数据源删除对应元素要在tableview删除对应的cell之前
//         [callRecordsArrremoveObjectAtIndex:indexPath.row];
        //当左滑按钮执行的操作涉及数据源和页面的更新时，要先更新数据源，在更新视图，否则会出现无响应的情况
        //[tableView deleteRowsAtIndexPaths:[NSMutableArrayarrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    action0.backgroundColor = [UIColor colorWithRed:189.f/255.f green:189.f/255.f blue:189.f/255.f alpha:1.0];

    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
    }];
    action1.backgroundColor = [UIColor colorWithRed:210.f/255.f green:210.f/255.f blue:210.f/255.f alpha:1.0];

    
    return @[action1, action0];
    
}

//删除所做的动作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Deleate!");
}
//Height of Cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
//height of header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//Num of Cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   //每个节点有几行
    return 20;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CIdentifier = @"CellIdentifier";
    ListUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CIdentifier];
    if (cell == nil) {
        cell = [[ListUserCell alloc]initWithStyle:UITableViewCellStyleSubtitle   reuseIdentifier:CIdentifier];
    }
    [cell setName:@"qwersd"];
    return cell;
}

#pragma mark - Btn Delegate
-(void)onBtnAdd{
    AddUserViewController *viewControllerShow = [[AddUserViewController alloc] init];
    viewControllerShow.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:viewControllerShow animated:YES completion:nil];
}

-(void)showInfo{
    ShowInfoViewController *viewControllerShowInfo = [[ShowInfoViewController alloc] init];
    viewControllerShowInfo.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:viewControllerShowInfo animated:YES completion:nil];
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

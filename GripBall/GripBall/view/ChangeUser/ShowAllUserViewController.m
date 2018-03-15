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
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.2]];
    
    UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(36, 30, SCREEN_WIDTH -72, SCREEN_HEIGHT-160)];
    [viewContainer setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:viewContainer];
    // Do any additional setup after loading the view.
    
    UIImageView *imvBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewContainer.frame.size.width, viewContainer.frame.size.height)];
    [imvBG setImage:[UIImage imageNamed:@"Login_white_BG_long"]];
    [viewContainer addSubview:imvBG];
    
    UIButton *btnNowUser = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewContainer.frame.size.width, 88)];
//    [btnNowUser setBackgroundColor:[UIColor blueColor]];
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
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88, viewContainer.frame.size.width, 2)];
    [line setBackgroundColor:[UIColor colorWithRed:225.f/255.f green:225.f/255.f blue:225.f/255.f alpha:1]];
    [viewContainer addSubview:line];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,90,viewContainer.frame.size.width,viewContainer.frame.size.height-190) style:UITableViewStyleGrouped];
    tableview.dataSource=self;
    tableview.delegate = self;
    [viewContainer addSubview:tableview];
    
//    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, viewContainer.frame.size.height-190, viewContainer.frame.size.width, 2)];
//    [line2 setBackgroundColor:[UIColor colorWithRed:225.f/255.f green:225.f/255.f blue:225.f/255.f alpha:1]];
//    [viewContainer addSubview:line2];
    
    UIButton *btnBottomView = [[UIButton alloc] initWithFrame:CGRectMake(0,viewContainer.frame.size.height-100, viewContainer.frame.size.width, 90)];
    [viewContainer addSubview:btnBottomView];
    
    UIButton *btnAddUser = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width/2-85.5f, viewContainer.frame.size.height-70, 171, 46.f)];
    [btnAddUser setTitle:@"添加新用户" forState:UIControlStateNormal];
    btnAddUser.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnAddUser setBackgroundImage:[UIImage imageNamed:@"test_btn_red"] forState:UIControlStateNormal];
    [btnAddUser setTitleColor:[UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:255.f/255.f alpha:1] forState:UIControlStateNormal];
    [btnAddUser addTarget:self action:@selector(clickBtnExit) forControlEvents:UIControlEventTouchUpInside];
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

//左滑动出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

//删除所做的动作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Deleate!");
}
//Height of Cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
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

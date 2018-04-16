//
//  CompetitionListViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/3/5.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "CompetitionListViewController.h"
#import "CompetitionListCell.h"

@interface CompetitionListViewController ()
@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) UILabel *lblTitle;
@end

@implementation CompetitionListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self temGetDate];
        
        [self createUI];
    }
    return self;
}

//临时模拟数据
-(void)temGetDate{
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"张三", @"name", @"40/5", @"score", @"左", @"hand", nil];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"五湖四海", @"name", @"50/4", @"score", @"左", @"hand",nil];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"zhangsan", @"name", @"40/5", @"score", @"左", @"hand", nil];
    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wang", @"name", @"50/4", @"score", @"左", @"hand",nil];
    NSDictionary *dic6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
    NSDictionary *dic7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"zhangsan", @"name", @"40/5", @"score", @"左", @"hand", nil];
    NSDictionary *dic8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wang", @"name", @"50/4", @"score", @"左", @"hand",nil];
    NSDictionary *dic9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
    NSDictionary *dic10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"zhangsan", @"name", @"40/5", @"score", @"左", @"hand", nil];
    NSDictionary *dic11 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wang", @"name", @"50/4", @"score", @"左", @"hand",nil];
    NSDictionary *dic12 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
    NSDictionary *dic13 = [[NSDictionary alloc] initWithObjectsAndKeys:@"zhangsan", @"name", @"40/5", @"score", @"左", @"hand", nil];
    NSDictionary *dic14 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wang", @"name", @"50/4", @"score", @"左", @"hand",nil];
    NSDictionary *dic15 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
    self.listData = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12,dic13,dic14,dic15,nil];
}

-(void)createUI
{
    // BGImage
    UIImageView *imgVBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imgVBG setImage:[UIImage imageNamed:@"connect_background"]];
    [self.view addSubview:imgVBG];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(45.f, 50.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100.f,100.f, 200.f, 25.f)];
    [self.lblTitle setTextColor:[UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1]];
    [self.lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:24.f]];
    [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.lblTitle];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(75.f,160.f, SCREEN_WIDTH-150.f, 0.5)];
    [lblLine setBackgroundColor:[UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:1]];
    [self.view addSubview:lblLine];
    
    UILabel *lbllistTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-135,230.f,40.f, 20.f)];
    [lbllistTitle1 setText:@"名次"];
    [lbllistTitle1 setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lbllistTitle1 setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lbllistTitle1 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lbllistTitle1];
    
    UILabel *lbllistTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-55,230.f, 60.f, 20.f)];
    [lbllistTitle2 setText:@"姓名"];
    [lbllistTitle2 setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lbllistTitle2 setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lbllistTitle2 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lbllistTitle2];
    
    UILabel *lbllistTitle3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+35,230.f, 40.f, 20.f)];
    [lbllistTitle3 setText:@"成绩"];
    [lbllistTitle3 setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lbllistTitle3 setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lbllistTitle3 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lbllistTitle3];
    
    UILabel *lbllistTitle4 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+105,230.f, 35.f, 20.f)];
    [lbllistTitle4 setText:@"手"];
    [lbllistTitle4 setTextColor:[UIColor colorWithRed:173.f/255.f green:173.f/255.f blue:173.f/255.f alpha:1]];
    [lbllistTitle4 setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lbllistTitle4 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lbllistTitle4];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, SCREEN_HEIGHT-275-25)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
}

-(void)setTitle:(NSString *)title{
    [self.lblTitle setText:title];
}
#pragma mark - Btn Delegate
-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listData.count > 20) {
        return 20;
    }else{
        return [self.listData count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CIdentifier = @"CellIdentifier";    
    
    CompetitionListCell *cell = [tableView dequeueReusableCellWithIdentifier:CIdentifier];
    if (cell == nil) {
        cell = [[CompetitionListCell alloc]initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:CIdentifier];
    }
    [cell setNum:[NSString stringWithFormat:@"%ld",indexPath.row]
         andName:[self.listData[indexPath.row] objectForKey:@"name"]
        andScore:[self.listData[indexPath.row] objectForKey:@"score"]
         andHand:[self.listData[indexPath.row] objectForKey:@"hand"]];
    
    cell.backgroundColor = [UIColor clearColor];
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

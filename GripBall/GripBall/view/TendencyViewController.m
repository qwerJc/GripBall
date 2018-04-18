//
//  TendencyViewController.m
//  GripBall
//
//  Created by 贾辰 on 2018/4/13.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TendencyViewController.h"
#import "ModelLocator.h"
#import "TendencyListCell.h"

@interface TendencyViewController ()
@property (strong ,nonatomic)NSMutableArray *listData;

@property (strong, nonatomic)UIButton *btnTestHand;
@property (strong, nonatomic)UIButton *btnExplodeHand;
@property (strong, nonatomic)UIButton *btnEnduranceHand;

@property (strong, nonatomic)UILabel *lblTestTitle;
@property (strong, nonatomic)UILabel *lblExplodeTitle;
@property (strong, nonatomic)UILabel *lblEnduranceTitle;

@property (strong, nonatomic)UITableView *tableViewTest;
@property (strong, nonatomic)UITableView *tableViewExplode;
@property (strong, nonatomic)UITableView *tableViewEndurance;


@end

@implementation TendencyViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createUI];
        
//        [self temGetDate];

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
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(45.f,54.f , 80.f, 20.f)];
    [lblTitle setText:@"握力趋势"];
    [lblTitle setTextColor:[UIColor colorWithRed:213.f/255.f green:213.f/255.f blue:213.f/255.f alpha:1]];
    [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblTitle setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lblTitle];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 44.f, 40.f, 40.f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"practice_btn1"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    //上下滚动条
    UIScrollView *scrollContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, SCREEN_WIDTH, SCREEN_HEIGHT-150)];
    [scrollContainer setBackgroundColor:[UIColor clearColor]];
    scrollContainer.contentSize = CGSizeMake(SCREEN_WIDTH, 810);
    [self.view addSubview:scrollContainer];
    
    UIImageView *imgvTestBG = [[UIImageView alloc] initWithFrame:CGRectMake(45.f,0.f , 85.f, 30.f)];
    [imgvTestBG setImage:[UIImage imageNamed:@"Change_BG2"]];
    [scrollContainer addSubview:imgvTestBG];
    
    UILabel *lblTest = [[UILabel alloc] initWithFrame:CGRectMake(45.f,0.f , 85.f, 30.f)];
    [lblTest setText:@"测验"];
    [lblTest setTextColor:[UIColor colorWithRed:213.f/255.f green:213.f/255.f blue:213.f/255.f alpha:1]];
    [lblTest setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblTest setTextAlignment:NSTextAlignmentCenter];
    [scrollContainer addSubview:lblTest];
    
    _btnTestHand = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 0.f, 46, 25)];
    [_btnTestHand setTag:0];
    [_btnTestHand setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
    [_btnTestHand addTarget:self action:@selector(onBtnTestHand:) forControlEvents:UIControlEventTouchUpInside];
    [scrollContainer addSubview:_btnTestHand];
    
    _lblTestTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 88, 0.f, 23, 25)];
    [_lblTestTitle setText:@"左"];
    [_lblTestTitle setTextColor:[UIColor colorWithRed:53.f/255.f green:53.f/255.f blue:53.f/255.f alpha:1]];
    [_lblTestTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
    [_lblTestTitle setBackgroundColor:[UIColor clearColor]];
    [_lblTestTitle setTextAlignment:NSTextAlignmentCenter];
    [scrollContainer addSubview:_lblTestTitle];
    
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50,SCREEN_WIDTH-80, 200)];
    [imgBG setImage:[UIImage imageNamed:@"chartBG@2x.png"]];
    [scrollContainer addSubview:imgBG];
    
    //测试模式 横向滚动条
    
    float height;
    if (SCREEN_HEIGHT < 700) {
        height = 10;
    }else{
        height = -5;
    }
    
    self.tableViewTest = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,height,200,SCREEN_WIDTH-100)];
    self.tableViewTest.dataSource = self;
    self.tableViewTest.delegate = self;
    self.tableViewTest.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableViewTest setBackgroundColor:[UIColor clearColor]];
    self.tableViewTest.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [scrollContainer addSubview:self.tableViewTest];
    
    
    //＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊［ 爆发力 ］＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    UIImageView *imgvExplodeBG = [[UIImageView alloc] initWithFrame:CGRectMake(45.f,270.f , 85.f, 30.f)];
    [imgvExplodeBG setImage:[UIImage imageNamed:@"Change_BG2"]];
    [scrollContainer addSubview:imgvExplodeBG];
    
    UILabel *lblExplode = [[UILabel alloc] initWithFrame:CGRectMake(45.f,270.f , 85.f, 30.f)];
    [lblExplode setText:@"爆发力"];
    [lblExplode setTextColor:[UIColor colorWithRed:213.f/255.f green:213.f/255.f blue:213.f/255.f alpha:1]];
    [lblExplode setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblExplode setTextAlignment:NSTextAlignmentCenter];
    [scrollContainer addSubview:lblExplode];
    
    _btnExplodeHand = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 270.f, 46, 25)];
    [_btnExplodeHand setTag:0];
    [_btnExplodeHand setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
    [_btnExplodeHand addTarget:self action:@selector(onBtnExplodeHand:) forControlEvents:UIControlEventTouchUpInside];
    [scrollContainer addSubview:_btnExplodeHand];
    
    _lblExplodeTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 88, 270.f, 23, 25)];
    [_lblExplodeTitle setText:@"左"];
    [_lblExplodeTitle setTextColor:[UIColor colorWithRed:53.f/255.f green:53.f/255.f blue:53.f/255.f alpha:1]];
    [_lblExplodeTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
    [_lblExplodeTitle setTextAlignment:NSTextAlignmentCenter];
    [scrollContainer addSubview:_lblExplodeTitle];
    
    UIImageView *imgBG2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 320,SCREEN_WIDTH-80, 200)];
    [imgBG2 setImage:[UIImage imageNamed:@"chartBG@2x.png"]];
    [scrollContainer addSubview:imgBG2];
    
    self.tableViewExplode = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,270+height,200,SCREEN_WIDTH-100)];
    self.tableViewExplode.dataSource = self;
    self.tableViewExplode.delegate = self;
    self.tableViewExplode.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableViewExplode setBackgroundColor:[UIColor clearColor]];
    self.tableViewExplode.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [scrollContainer addSubview:self.tableViewExplode];
    
    //＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊［ 爆发力 ］＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    UIImageView *imgvEnduranceBG = [[UIImageView alloc] initWithFrame:CGRectMake(45.f,540.f , 85.f, 30.f)];
    [imgvEnduranceBG setImage:[UIImage imageNamed:@"Change_BG2"]];
    [scrollContainer addSubview:imgvEnduranceBG];
    
    UILabel *lblEndurance = [[UILabel alloc] initWithFrame:CGRectMake(45.f,540.f , 85.f, 30.f)];
    [lblEndurance setText:@"耐力"];
    [lblEndurance setTextColor:[UIColor colorWithRed:213.f/255.f green:213.f/255.f blue:213.f/255.f alpha:1]];
    [lblEndurance setFont:[UIFont fontWithName:@"ArialMT" size:14.f]];
    [lblEndurance setTextAlignment:NSTextAlignmentCenter];
    [scrollContainer addSubview:lblEndurance];
    
    _btnEnduranceHand = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 540.f, 46, 25)];
    [_btnEnduranceHand setTag:0];
    [_btnEnduranceHand setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
    [_btnEnduranceHand addTarget:self action:@selector(onBtnEnduranceHand:) forControlEvents:UIControlEventTouchUpInside];
    [scrollContainer addSubview:_btnEnduranceHand];
    
    _lblEnduranceTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 88, 540.f, 23, 25)];
    [_lblEnduranceTitle setText:@"左"];
    [_lblEnduranceTitle setTextColor:[UIColor colorWithRed:53.f/255.f green:53.f/255.f blue:53.f/255.f alpha:1]];
    [_lblEnduranceTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
    [_lblEnduranceTitle setTextAlignment:NSTextAlignmentCenter];
    [scrollContainer addSubview:_lblEnduranceTitle];
    
    UIImageView *imgBG3 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 590,SCREEN_WIDTH-80, 200)];
    [imgBG3 setImage:[UIImage imageNamed:@"chartBG@2x.png"]];
    [scrollContainer addSubview:imgBG3];
    
    self.tableViewEndurance = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,540+height,200,SCREEN_WIDTH-100)];
    self.tableViewEndurance.dataSource = self;
    self.tableViewEndurance.delegate = self;
    self.tableViewEndurance.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableViewEndurance setBackgroundColor:[UIColor clearColor]];
    self.tableViewEndurance.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [scrollContainer addSubview:self.tableViewEndurance];
    
}

//-(void)addTestView:(UIScrollView *)container{
//    for (int i = 0; i < [[model testList] count];i++) {
//        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(39*i, 0, 40, 200)];
//        [viewBG setBackgroundColor:[UIColor redColor]];
//        [container addSubview:viewBG];
//    }
//}
#pragma mark - Btn Delegate

-(void)clickBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onBtnTestHand:(UIButton *)btn{
    if (btn.tag == 0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Rhand"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        [_lblTestTitle setFrame:CGRectMake(SCREEN_WIDTH - 70, 0.f, 23, 25)];
        [_lblTestTitle setText:@"右"];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
        btn.tag = 0;
        
        [_lblTestTitle setFrame:CGRectMake(SCREEN_WIDTH - 88, 0.f, 23, 25)];
        [_lblTestTitle setText:@"左"];
    }
    [_tableViewTest reloadData];
}

-(void)onBtnExplodeHand:(UIButton *)btn{
    if (btn.tag == 0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Rhand"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        [_lblExplodeTitle setFrame:CGRectMake(SCREEN_WIDTH - 70, 270.f, 23, 25)];
        [_lblExplodeTitle setText:@"右"];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
        btn.tag = 0;
        
        [_lblExplodeTitle setFrame:CGRectMake(SCREEN_WIDTH - 88, 270.f, 23, 25)];
        [_lblExplodeTitle setText:@"左"];
    }
    [_tableViewExplode reloadData];
}
-(void)onBtnEnduranceHand:(UIButton *)btn{
    if (btn.tag == 0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Rhand"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        [_lblEnduranceTitle setFrame:CGRectMake(SCREEN_WIDTH - 70, 540.f, 23, 25)];
        [_lblEnduranceTitle setText:@"右"];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
        btn.tag = 0;
        
        [_lblEnduranceTitle setFrame:CGRectMake(SCREEN_WIDTH - 88, 540.f, 23, 25)];
        [_lblEnduranceTitle setText:@"左"];
    }
    [_tableViewEndurance reloadData];
}

#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableViewTest) {
        return [[model testList] count];
    }else if(tableView == _tableViewExplode){
        return [[model explodeList] count];
    }else if (tableView == _tableViewEndurance){
        return [[model enduranceList] count];
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CIdentifier = @"CellIdentifier";
    
    TendencyListCell *cell = [tableView dequeueReusableCellWithIdentifier:CIdentifier];
    if (cell == nil) {
        cell = [[TendencyListCell alloc]initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:CIdentifier];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    if (tableView == _tableViewTest) {
        
        [cell setTestValue:[[model testList] objectAtIndex:indexPath.row] withTag:_btnTestHand.tag];
        
    }else if(tableView == _tableViewExplode){
        
        [cell setExplodeValue:[[model explodeList] objectAtIndex:indexPath.row] withTag:_btnExplodeHand.tag];
        
    }else if (tableView == _tableViewEndurance){
        
        [cell setEnduranceValue:[[model enduranceList] objectAtIndex:indexPath.row] withTag:_btnExplodeHand.tag];
    }
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

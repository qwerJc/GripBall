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

@end

@implementation TendencyViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createUI2];
        
        [self temGetDate];

    }
    return self;
}

-(void)temGetDate{
//    date = "Fri, 13 Apr 2018 10:17:37 GMT";
//    id = 4;
//    meanvalue = 1;
//    mode = practice;
//    timecost = 1;
//    times = 1;
    
//    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"meanvalue", @"practice",@"mode", @"1", @"timecost", @"1",@"times", nil];
    
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"100", @"lval", @"15", @"rval",nil];
    
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"10", @"lval", @"15", @"rval",nil];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"20", @"lval", @"15", @"rval",nil];
    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"30", @"lval", @"15", @"rval",nil];
    
    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"40", @"lval", @"15", @"rval",nil];
    NSDictionary *dic6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"100", @"lval", @"15", @"rval",nil];
    NSDictionary *dic7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"100", @"lval", @"15", @"rval",nil];
    
    NSDictionary *dic8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"100", @"lval", @"15", @"rval",nil];
    NSDictionary *dic9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tue, 10 Apr 2018 15:42:16 GMT", @"date", @"100", @"lval", @"15", @"rval",nil];
    self.listData = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,nil];
    
    
//    self.listData = [model getTestList];
}

-(void)createUI2{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //上下滚动条
    UIScrollView *scrollContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, SCREEN_WIDTH, SCREEN_HEIGHT-150)];
    [scrollContainer setBackgroundColor:[UIColor clearColor]];
    scrollContainer.contentSize = CGSizeMake(SCREEN_WIDTH, 810);
    [self.view addSubview:scrollContainer];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,50,200,SCREEN_WIDTH-80)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor redColor]];
    tableView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    [scrollContainer addSubview:tableView];
//    40, 320,SCREEN_WIDTH-80, 200
    
    UITableView *tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,320,200,SCREEN_WIDTH-80)];
    tableView2.dataSource = self;
    tableView2.delegate = self;
    tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView2 setBackgroundColor:[UIColor redColor]];
    tableView2.transform = CGAffineTransformMakeRotation(M_PI / 2);
    [scrollContainer addSubview:tableView2];
}

-(void)createUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
//    [_lblTestTitle setBackgroundColor:[UIColor redColor]];
    [_lblTestTitle setTextAlignment:NSTextAlignmentCenter];
    
    [scrollContainer addSubview:_lblTestTitle];
    
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50,SCREEN_WIDTH-80, 200)];
    [imgBG setImage:[UIImage imageNamed:@"chartBG@2x.png"]];
    [scrollContainer addSubview:imgBG];
    
    //测试模式 横向滚动条
//    UIScrollView *scrollViewTest = [[UIScrollView alloc] initWithFrame:CGRectMake(45,50, SCREEN_WIDTH-80,200)];
//    [scrollViewTest setBackgroundColor:[UIColor orangeColor]];
//    scrollViewTest.contentSize = CGSizeMake(SCREEN_WIDTH*2, 200);
//    [scrollViewTest setBackgroundColor:[UIColor redColor]];
//    [scrollContainer addSubview:scrollViewTest];
//    [self addTestView:scrollViewTest];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(45,50, SCREEN_WIDTH-80,200)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor redColor]];
    tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [scrollContainer addSubview:tableView];
    
    
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
    
}

-(void)addTestView:(UIScrollView *)container{
    for (int i = 0; i < [[model getTestList] count];i++) {
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(39*i, 0, 40, 200)];
        [viewBG setBackgroundColor:[UIColor redColor]];
        [container addSubview:viewBG];
    }
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
    NSLog(@"%ld",(long)btn.tag);
}

-(void)onBtnExplodeHand:(UIButton *)btn{
    if (btn.tag == 0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Rhand"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        [_lblExplodeTitle setFrame:CGRectMake(SCREEN_WIDTH - 70, 0.f, 23, 25)];
        [_lblExplodeTitle setText:@"右"];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
        btn.tag = 0;
        
        [_lblExplodeTitle setFrame:CGRectMake(SCREEN_WIDTH - 88, 0.f, 23, 25)];
        [_lblExplodeTitle setText:@"左"];
    }
}
-(void)onBtnEnduranceHand:(UIButton *)btn{
    if (btn.tag == 0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Rhand"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        [_lblEnduranceTitle setFrame:CGRectMake(SCREEN_WIDTH - 70, 0.f, 23, 25)];
        [_lblEnduranceTitle setText:@"右"];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"Change_state_Lhand"] forState:UIControlStateNormal];
        btn.tag = 0;
        
        [_lblEnduranceTitle setFrame:CGRectMake(SCREEN_WIDTH - 88, 0.f, 23, 25)];
        [_lblEnduranceTitle setText:@"左"];
    }
    NSLog(@"%ld",(long)btn.tag);
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
    
    TendencyListCell *cell = [tableView dequeueReusableCellWithIdentifier:CIdentifier];
    if (cell == nil) {
        cell = [[TendencyListCell alloc]initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:CIdentifier];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    [cell setvalue:nil withTag:nil];
//    [cell.textLabel setText:@"zzz"];
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

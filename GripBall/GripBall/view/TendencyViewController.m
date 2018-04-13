//
//  TendencyViewController.m
//  GripBall
//
//  Created by 贾辰 on 2018/4/13.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TendencyViewController.h"
#import "ModelLocator.h"

@interface TendencyViewController ()
@property (strong ,nonatomic)NSMutableArray *listData;
@end

@implementation TendencyViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        [self createUI];
        
        [self temGetDate];

    }
    return self;
}

-(void)temGetDate{
//    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"张三", @"name", @"40/5", @"score", @"左", @"hand", nil];
//    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"五湖四海", @"name", @"50/4", @"score", @"左", @"hand",nil];
//    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
//    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"zhangsan", @"name", @"40/5", @"score", @"左", @"hand", nil];
//    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wang", @"name", @"50/4", @"score", @"左", @"hand",nil];
//    NSDictionary *dic6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
//    NSDictionary *dic7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"zhangsan", @"name", @"40/5", @"score", @"左", @"hand", nil];
//    NSDictionary *dic8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wang", @"name", @"50/4", @"score", @"左", @"hand",nil];
//    NSDictionary *dic9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Liu", @"name", @"50/4", @"score", @"右", @"hand",nil];
//    NSDictionary *dic10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"zhangsan", @"name", @"40/5", @"score", @"左", @"hand", nil];
//    self.listData = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,nil];
    
//    for (int i = 0; i<NUM_TEST; i++) {
//        <#statements#>
//    }
    self.listData = [model getTestList];
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
    UIScrollView *scrollContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    [scrollContainer setBackgroundColor:[UIColor clearColor]];
    scrollContainer.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
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
    
//    UIImageView *MonthBG = [[UIImageView alloc] initWithFrame:CGRectMake(45.f,90.f , 24.f, 24.f)];
//    [MonthBG setImage:[UIImage imageNamed:@"Change_Title_BG"]];
//    [scrollContainer addSubview:MonthBG];
    
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50,SCREEN_WIDTH-80, 200)];
    [imgBG setImage:[UIImage imageNamed:@"chartBG@2x.png"]];
    [scrollContainer addSubview:imgBG];
    
    UIScrollView *scrollViewTest = [[UIScrollView alloc] initWithFrame:CGRectMake(45,100, SCREEN_WIDTH-90,300)];
    [scrollViewTest setBackgroundColor:[UIColor orangeColor]];
    scrollViewTest.contentSize = CGSizeMake(SCREEN_WIDTH*2, 300);
    [scrollContainer addSubview:scrollViewTest];
    

    
    [self addTestView:scrollViewTest];
}

-(void)addTestView:(UIScrollView *)container{
    for (int i = 0; i < [[model getTestList] count];i++) {
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(39*i, 0, 40, 200)];
        [viewBG setBackgroundColor:[UIColor redColor]];
        [container addSubview:viewBG];
    }
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

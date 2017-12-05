//
//  JCAlertReConnectView.m
//  GripBall
//
//  Created by 贾辰 on 2017/12/4.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import "JCAlertReConnectView.h"
#import "ModelLocator.h"

@interface JCAlertReConnectView()
@property (strong, nonatomic)UIScrollView *alert3ScrollView;
@end

@implementation JCAlertReConnectView
- (instancetype)initAlert3ReConnectWithTitle:(NSString *)title{
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [viewBG setBackgroundColor:[UIColor blackColor]];
        [viewBG setAlpha:0.6];
        [self addSubview:viewBG];
        
        self.alert3ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(45.f, 200.f, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-200.f)];
        [self.alert3ScrollView setContentSize:CGSizeMake((SCREEN_WIDTH-90.f)*3, SCREEN_HEIGHT-200.f)];
        //        [self.alert3ScrollView setScrollEnabled:false];
        [self addSubview:self.alert3ScrollView];
        
        UIView *viewChoose = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [viewChoose setBackgroundColor:[UIColor clearColor]];
        [self.alert3ScrollView addSubview:viewChoose];
        
        UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [imgViewBG setImage:[UIImage imageNamed:@"connect_rectangle_l"]];
        [viewChoose addSubview:imgViewBG];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(25.f, 62.f,viewChoose.frame.size.width-50.f, 22.f)];
        [lblTitle setText:title];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [viewChoose addSubview:lblTitle];
        
        _btnReConnectBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(55.f, 100.f, viewChoose.frame.size.width-110.f, 48.f)];
        [_btnReConnectBtn1 setBackgroundImage:[UIImage imageNamed:@"practice_btn7"] forState:UIControlStateNormal];
        [_btnReConnectBtn1 setTitle:@"重新连接" forState:UIControlStateNormal];
        [_btnReConnectBtn1.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [_btnReConnectBtn1 setTintColor:[UIColor colorWithRed:72.f/255.f green:72.f/255.f blue:72.f/255.f alpha:1]];
        [_btnReConnectBtn1 setTintColor:[UIColor whiteColor]];
        [viewChoose addSubview:_btnReConnectBtn1];
        
        _btnReConnectBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(55.f, 175.f, viewChoose.frame.size.width-110.f, 48.f)];
        [_btnReConnectBtn2 setBackgroundImage:[UIImage imageNamed:@"practice_btn5"] forState:UIControlStateNormal];
        [_btnReConnectBtn2 setTitle:@"回到首页" forState:UIControlStateNormal];
        [_btnReConnectBtn2.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [_btnReConnectBtn2 setTintColor:[UIColor colorWithRed:72.f/255.f green:72.f/255.f blue:72.f/255.f alpha:1]];
        [viewChoose addSubview:_btnReConnectBtn2];
        
        [self.alert3ScrollView addSubview:viewChoose];
        
        //重联第二阶段 等待界面
        UIView *viewWait = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90.f, 0.f, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [viewWait setBackgroundColor:[UIColor clearColor]];
        [self.alert3ScrollView addSubview:viewWait];
        
        UIImageView *imgViewWaitBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
        [imgViewWaitBG setImage:[UIImage imageNamed:@"connect_rectangle_l"]];
        [viewWait addSubview:imgViewWaitBG];
        
        UILabel *lblViewWaitTitle = [[UILabel alloc] initWithFrame:CGRectMake(30.f, 60.f,viewChoose.frame.size.width-60.f, 23.f)];
        [lblViewWaitTitle setText:title];
        [lblViewWaitTitle setText:@"正在重新连接..."];
        [lblViewWaitTitle setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:66.f/255.f]];
        [lblViewWaitTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [lblViewWaitTitle setTextAlignment:NSTextAlignmentCenter];
        [viewWait addSubview:lblViewWaitTitle];
        
        //重联第三阶段 成功 (因为考虑到有可能是成功和失败两种结果，所以在下面的setAlert方法中去实现)
        
    }
    return self;
}
- (void)setAlert3WaitView{
    [self.alert3ScrollView setContentOffset:CGPointMake(SCREEN_WIDTH-90.f, 0.f) animated:true];
}
- (void)setAlert3SuccView{
    //重连第三阶段 成功
    UIView *viewSuccess = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90.f)*2, 0.f, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
    [viewSuccess setBackgroundColor:[UIColor clearColor]];
    [self.alert3ScrollView addSubview:viewSuccess];
    
    UIImageView *imgViewWaitBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, SCREEN_HEIGHT-400.f)];
    [imgViewWaitBG setImage:[UIImage imageNamed:@"connect_rectangle_l"]];
    [viewSuccess addSubview:imgViewWaitBG];
    
    [self.alert3ScrollView setContentOffset:CGPointMake((SCREEN_WIDTH-90.f)*2, 0.f) animated:true];
}
- (void)setAlert3FailView{
    UIView *viewFail = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90.f)*2,0.f, SCREEN_WIDTH-90.f, 400.f)];
    [viewFail setBackgroundColor:[UIColor clearColor]];
    [self.alert3ScrollView addSubview:viewFail];
    
    UIImageView *imgViewWaitBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90.f, 400.f)];
    [imgViewWaitBG setImage:[UIImage imageNamed:@"connect_rectangle_l"]];
    [viewFail addSubview:imgViewWaitBG];
    
    UIImageView *imgViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(viewFail.frame.size.width/2-35.f, 35.f, 70.f, 70.f)];
    [imgViewIcon setImage:[UIImage imageNamed:@"practice_icon2"]];
    [viewFail addSubview:imgViewIcon];
    
    UILabel *lblTitle1 = [[UILabel alloc] initWithFrame:CGRectMake((viewFail.frame.size.width-140)/2, 140.f,300.f, 22.f)];
    [lblTitle1 setText:@"连接失败"];
    [lblTitle1 setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:66.f/255.f]];
    [lblTitle1 setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblTitle1 setTextAlignment:NSTextAlignmentLeft];
    [viewFail addSubview:lblTitle1];
    
    UILabel *lblTitle2 = [[UILabel alloc] initWithFrame:CGRectMake((viewFail.frame.size.width-140)/2, 170.f,300.f, 22.f)];
    [lblTitle2 setText:@"检查握力球开关"];
    [lblTitle2 setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:66.f/255.f]];
    [lblTitle2 setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblTitle2 setTextAlignment:NSTextAlignmentLeft];
    [viewFail addSubview:lblTitle2];
    
    UILabel *lblTitle3 = [[UILabel alloc] initWithFrame:CGRectMake((viewFail.frame.size.width-140)/2, 200.f,300.f, 22.f)];
    [lblTitle3 setText:@"及手机蓝牙打开"];
    [lblTitle3 setTextColor:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:66.f/255.f]];
    [lblTitle3 setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [lblTitle3 setTextAlignment:NSTextAlignmentLeft];
    [viewFail addSubview:lblTitle3];
    
    _btnFailBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(55.f, viewFail.frame.size.height-145.f, viewFail.frame.size.width-110.f, 48.f)];
    [_btnFailBtn1 setBackgroundImage:[UIImage imageNamed:@"practice_btn7"] forState:UIControlStateNormal];
    [_btnFailBtn1 setTitle:@"重新连接" forState:UIControlStateNormal];
    [_btnFailBtn1.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [_btnFailBtn1 setTintColor:[UIColor colorWithRed:72.f/255.f green:72.f/255.f blue:72.f/255.f alpha:1]];
    [_btnFailBtn1 setTintColor:[UIColor whiteColor]];
    [viewFail addSubview:_btnFailBtn1];
    
    _btnFailBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(55.f,viewFail.frame.size.height-75.f, viewFail.frame.size.width-110.f, 48.f)];
    [_btnFailBtn2 setBackgroundImage:[UIImage imageNamed:@"practice_btn5"] forState:UIControlStateNormal];
    [_btnFailBtn2 setTitle:@"回到首页" forState:UIControlStateNormal];
    [_btnFailBtn2.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
    [_btnFailBtn2 setTintColor:[UIColor colorWithRed:72.f/255.f green:72.f/255.f blue:72.f/255.f alpha:1]];
    [viewFail addSubview:_btnFailBtn2];
    
    [self.alert3ScrollView setContentOffset:CGPointMake((SCREEN_WIDTH-90.f)*2, 0.f) animated:true];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

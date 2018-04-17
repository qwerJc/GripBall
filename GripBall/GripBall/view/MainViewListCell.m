//
//  MainViewListCell.m
//  GripBall
//
//  Created by 贾辰 on 2018/4/16.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "MainViewListCell.h"
#import "ModelLocator.h"

@interface MainViewListCell()
@property (strong, nonatomic)UILabel *modelTitle;
@property (strong, nonatomic)UILabel *lblDate;
@property (strong, nonatomic)UILabel *lblTime;

@property (strong, nonatomic)UIView *viewPractice;
@property (strong, nonatomic)UILabel *lblPracticeTime;
@property (strong, nonatomic)UILabel *lblPracticeCount;
@property (strong, nonatomic)UILabel *lblPrcaticeValue;

@property (strong, nonatomic)UIView *viewTest;
@property (strong, nonatomic)UILabel *lblTestLValue;
@property (strong, nonatomic)UILabel *lblTestRValue;
@property (strong, nonatomic)UILabel *lblTestLScore;
@property (strong, nonatomic)UILabel *lblTestRScore;

@property (strong, nonatomic)UIView *viewExplode;
@property (strong, nonatomic)UILabel *lblExplodeLValue;
@property (strong, nonatomic)UILabel *lblExplodeRValue;

@property (strong, nonatomic)UILabel *lblEnduranceLTime;
@property (strong, nonatomic)UILabel *lblEnduranceRTime;

@property (strong, nonatomic)UIView *viewEndurance;
@end

@implementation MainViewListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.modelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.f,15.f, 120.f, 20.f)];
        [self.modelTitle setTextColor:[UIColor colorWithRed:52.f/255.f green:52.f/255.f blue:52.f/255.f alpha:1]];
        [self.modelTitle setTextColor:[UIColor blackColor]];
        [self.modelTitle setFont:[UIFont fontWithName:@"ArialMT" size:20.f]];
        [self.modelTitle setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.modelTitle];
        
        self.lblDate = [[UILabel alloc] initWithFrame:CGRectMake(21,42.f, 40.f, 20.f)];
        [self.lblDate setTextColor:[UIColor colorWithRed:172.f/255.f green:173.f/255.f blue:174.f/255.f alpha:1]];
        [self.lblDate setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblDate setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblDate];
        
        self.lblTime = [[UILabel alloc] initWithFrame:CGRectMake(60,42.f, 40.f, 20.f)];
        [self.lblTime setTextColor:[UIColor colorWithRed:172.f/255.f green:173.f/255.f blue:174.f/255.f alpha:1]];
        [self.lblTime setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblTime setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lblTime];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 69, SCREEN_WIDTH-122, 1)];
        [line setBackgroundColor:[UIColor colorWithRed:208.f/255.f green:206.f/255.f blue:206.f/255.f alpha:1]];
        [self addSubview:line];
        
        //////////////////////////////////////////////
        self.viewPractice = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-210, 0, 110, 70)];
        [self addSubview:self.viewPractice];
        
        self.lblPracticeTime = [[UILabel alloc] initWithFrame:CGRectMake(55,15.f, 45.f, 20.f)];
        [self.lblPracticeTime setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblPracticeTime setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblPracticeTime setTextAlignment:NSTextAlignmentRight];
        [self.viewPractice addSubview:self.lblPracticeTime];
        
        self.lblPracticeCount = [[UILabel alloc] initWithFrame:CGRectMake(0,42.f, 60.f, 20.f)];
        [self.lblPracticeCount setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblPracticeCount setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblPracticeCount setTextAlignment:NSTextAlignmentRight];
        [self.viewPractice addSubview:self.lblPracticeCount];
        
        self.lblPrcaticeValue = [[UILabel alloc] initWithFrame:CGRectMake(70,42.f, 30.f, 20.f)];
        [self.lblPrcaticeValue setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblPrcaticeValue setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblPrcaticeValue setTextAlignment:NSTextAlignmentRight];
        [self.viewPractice addSubview:self.lblPrcaticeValue];
        
        ////////////////////////////////////////////
        self.viewTest = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-230, 0, 130, 70)];
        [self.viewTest setHidden:YES];
        [self addSubview:_viewTest];
        
        UILabel *lblLTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,15.f, 30.f, 20.f)];
        [lblLTitle setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [lblLTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [lblLTitle setTextAlignment:NSTextAlignmentRight];
        [lblLTitle setText:@"左手"];
        [self.viewTest addSubview:lblLTitle];
        
        UILabel *lblRTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,42.f, 30.f, 20.f)];
        [lblRTitle setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [lblRTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [lblRTitle setTextAlignment:NSTextAlignmentRight];
        [lblRTitle setText:@"右手"];
        [self.viewTest addSubview:lblRTitle];
        
        self.lblTestLValue = [[UILabel alloc] initWithFrame:CGRectMake(35,15.f, 40.f, 20.f)];
        [self.lblTestLValue setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblTestLValue setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblTestLValue setTextAlignment:NSTextAlignmentRight];
        [self.viewTest addSubview:self.lblTestLValue];
        
        self.lblTestRValue = [[UILabel alloc] initWithFrame:CGRectMake(35,42.f, 40.f, 20.f)];
        [self.lblTestRValue setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblTestRValue setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblTestRValue setTextAlignment:NSTextAlignmentRight];
        [self.viewTest addSubview:self.lblTestRValue];
        
        self.lblTestLScore = [[UILabel alloc] initWithFrame:CGRectMake(75,15.f, 45.f, 20.f)];
        [self.lblTestLScore setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblTestLScore setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblTestLScore setTextAlignment:NSTextAlignmentRight];
        [self.viewTest addSubview:self.lblTestLScore];
        
        self.lblTestRScore = [[UILabel alloc] initWithFrame:CGRectMake(75,42.f, 45.f, 20.f)];
        [self.lblTestRScore setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblTestRScore setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblTestRScore setTextAlignment:NSTextAlignmentRight];
        [self.viewTest addSubview:self.lblTestRScore];
        
        ////////////////////////////////////////////////////////////
        self.viewExplode = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-230, 0, 130, 70)];
        [self.viewExplode setHidden:YES];
        [self addSubview:self.viewExplode];
        
        UILabel *lblExplodeLTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,15.f, 60.f, 20.f)];
        [lblExplodeLTitle setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [lblExplodeLTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [lblExplodeLTitle setTextAlignment:NSTextAlignmentRight];
        [lblExplodeLTitle setText:@"左手成绩"];
        [self.viewExplode addSubview:lblExplodeLTitle];
        
        UILabel *lblExplodeRTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,42.f, 60.f, 20.f)];
        [lblExplodeRTitle setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [lblExplodeRTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [lblExplodeRTitle setTextAlignment:NSTextAlignmentRight];
//        [lblExplodeRTitle setBackgroundColor:[UIColor redColor]];
        [lblExplodeRTitle setText:@"右手成绩"];
        [self.viewExplode addSubview:lblExplodeRTitle];
        
        self.lblExplodeLValue = [[UILabel alloc] initWithFrame:CGRectMake(65,15.f, 55.f, 20.f)];
        [self.lblExplodeLValue setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblExplodeLValue setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblExplodeLValue setTextAlignment:NSTextAlignmentRight];
        [self.viewExplode addSubview:self.lblExplodeLValue];
        
        self.lblExplodeRValue = [[UILabel alloc] initWithFrame:CGRectMake(65,42.f, 55.f, 20.f)];
        [self.lblExplodeRValue setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblExplodeRValue setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblExplodeRValue setTextAlignment:NSTextAlignmentRight];
//        [self.lblExplodeRValue setBackgroundColor:[UIColor redColor]];
        [self.viewExplode addSubview:self.lblExplodeRValue];
        
        ///////////////////////////////////////////////////////////
        self.viewEndurance = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-230, 0, 130, 70)];
        [self.viewEndurance setHidden:YES];
        [self addSubview:self.viewEndurance];
        
        UILabel *lblEnduranceLTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,15.f, 60.f, 20.f)];
        [lblEnduranceLTitle setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [lblEnduranceLTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [lblEnduranceLTitle setTextAlignment:NSTextAlignmentRight];
        [lblEnduranceLTitle setText:@"左手成绩"];
        [self.viewEndurance addSubview:lblEnduranceLTitle];
        
        UILabel *lblEnduranceRTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,42.f, 60.f, 20.f)];
        [lblEnduranceRTitle setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [lblEnduranceRTitle setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [lblEnduranceRTitle setTextAlignment:NSTextAlignmentRight];
//        [lblEnduranceRTitle setBackgroundColor:[UIColor redColor]];
        [lblEnduranceRTitle setText:@"右手成绩"];
        [self.viewEndurance addSubview:lblEnduranceRTitle];
        
        self.lblEnduranceLTime = [[UILabel alloc] initWithFrame:CGRectMake(65,15.f, 55.f, 20.f)];
        [self.lblEnduranceLTime setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblEnduranceLTime setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblEnduranceLTime setTextAlignment:NSTextAlignmentRight];
        [self.viewEndurance addSubview:self.lblEnduranceLTime];
        
        self.lblEnduranceRTime = [[UILabel alloc] initWithFrame:CGRectMake(65,42.f, 55.f, 20.f)];
        [self.lblEnduranceRTime setTextColor:[UIColor colorWithRed:95.f/255.f green:96.f/255.f blue:98.f/255.f alpha:1]];
        [self.lblEnduranceRTime setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblEnduranceRTime setTextAlignment:NSTextAlignmentRight];
//        [self.lblEnduranceRTime setBackgroundColor:[UIColor redColor]];
        [self.viewEndurance addSubview:self.lblEnduranceRTime];
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dic{
    NSLog(@"data:%@",dic);
    NSString *mode = [dic objectForKey:@"mode"];
    if ([mode isEqualToString:@"practice"]) {
        [_viewPractice setHidden:NO];
        [_viewTest setHidden:YES];
        [_viewExplode setHidden:YES];
        [_viewEndurance setHidden:YES];
        
        [_modelTitle setText:@"练习模式"];
        
        [self.lblPracticeTime setText:[NSString stringWithFormat:@"%@min",[dic objectForKey:@"timecost"]]];
        [self.lblPracticeCount setText:[NSString stringWithFormat:@"%@次",[dic objectForKey:@"times"]]];
        [self.lblPrcaticeValue setText:[NSString stringWithFormat:@"%@N",[dic objectForKey:@"meanvalue"]]];
        
    }else if ([mode isEqualToString:@"test"]){
        [_viewPractice setHidden:YES];
        [_viewTest setHidden:NO];
        [_viewExplode setHidden:YES];
        [_viewEndurance setHidden:YES];
        
        [_modelTitle setText:@"测试模式"];
        
        [self.lblTestLValue setText:[NSString stringWithFormat:@"%@N",[dic objectForKey:@"lefthand_val"]]];
        [self.lblTestRValue setText:[NSString stringWithFormat:@"%@N",[dic objectForKey:@"righthand_val"]]];
        [self.lblTestLScore setText:[NSString stringWithFormat:@"%@分",[dic objectForKey:@"lefthand_score"]]];
        [self.lblTestRScore setText:[NSString stringWithFormat:@"%@分",[dic objectForKey:@"righthand_score"]]];
        
    }else if ([mode isEqualToString:@"explosive"]){
        [_viewPractice setHidden:YES];
        [_viewTest setHidden:YES];
        [_viewExplode setHidden:NO];
        [_viewEndurance setHidden:YES];
        
        [_modelTitle setText:@"爆发力模式"];
        [self.lblExplodeLValue setText:[NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"lefthand_val"],[dic objectForKey:@"lefthand_timecost"]]];
        [self.lblExplodeRValue setText:[NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"righthand_val"],[dic objectForKey:@"righthand_timecost"]]];
        

    }else if ([mode isEqualToString:@"stamina"]){
        [_viewPractice setHidden:YES];
        [_viewTest setHidden:YES];
        [_viewExplode setHidden:YES];
        [_viewEndurance setHidden:NO];
        
        [_modelTitle setText:@"耐力模式"];
        [self.lblEnduranceLTime setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"lefthand_duration"]]];
        [self.lblEnduranceRTime setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"righthand_duration"]]];
    }
    
    // 设置日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
    NSDate *someDay = [fmt dateFromString:[dic objectForKey:@"date"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M-dd"];
    [self.lblDate setText:[formatter stringFromDate:someDay]];
    
    [formatter setDateFormat:@"HH:mm"];
    [self.lblTime setText:[formatter stringFromDate:someDay]];
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MM.dd"];
//    [self.lblDate setText:[formatter stringFromDate:[dic objectForKey:@"date"]]];
//    [formatter setDateFormat:@"HH:mm"];
//    [self.lblTime setText:[formatter stringFromDate:[dic objectForKey:@"date"]]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

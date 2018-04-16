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
@property (strong, nonatomic)UILabel *lValue;
@property (strong, nonatomic)UILabel *rValue;
@property (strong, nonatomic)UILabel *lScore;
@property (strong, nonatomic)UILabel *rScore;

@property (strong, nonatomic)UIView *viewExplode;

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
        [self.viewPractice setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.viewPractice];
        
        self.lblPracticeCount = [[UILabel alloc] initWithFrame:CGRectMake(32,42.f, 60.f, 20.f)];
        [self.lblPracticeCount setTextColor:[UIColor colorWithRed:75.f/255.f green:76.f/255.f blue:78.f/255.f alpha:1]];
        [self.lblPracticeCount setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblPracticeCount setTextAlignment:NSTextAlignmentLeft];
        [self.lblPracticeCount setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.lblPracticeCount];
        
        self.lblPrcaticeValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-152,42.f, 50.f, 20.f)];
        [self.lblPrcaticeValue setTextColor:[UIColor colorWithRed:75.f/255.f green:76.f/255.f blue:78.f/255.f alpha:1]];
        [self.lblPrcaticeValue setFont:[UIFont fontWithName:@"ArialMT" size:13.f]];
        [self.lblPrcaticeValue setTextAlignment:NSTextAlignmentLeft];
        [self.lblPrcaticeValue setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.lblPrcaticeValue];
        
        ////////////////////////////////////////////
        self.viewTest = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-190, 0, 110, 70)];
        [self.viewTest setBackgroundColor:[UIColor greenColor]];
        [self.viewTest setHidden:YES];
        [self addSubview:_viewTest];
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
        
    }else if ([mode isEqualToString:@"test"]){
        [_viewPractice setHidden:YES];
        [_viewTest setHidden:NO];
        [_viewExplode setHidden:YES];
        [_viewEndurance setHidden:YES];
        
        [_modelTitle setText:@"测试模式"];
    }else if ([mode isEqualToString:@"explosive"]){
        [_viewPractice setHidden:YES];
        [_viewTest setHidden:YES];
        [_viewExplode setHidden:NO];
        [_viewEndurance setHidden:YES];
        
        [_modelTitle setText:@"爆发力模式"];
    }else if ([mode isEqualToString:@"stamina"]){
        [_viewPractice setHidden:YES];
        [_viewTest setHidden:YES];
        [_viewExplode setHidden:YES];
        [_viewEndurance setHidden:NO];
        
        [_modelTitle setText:@"耐力模式"];
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

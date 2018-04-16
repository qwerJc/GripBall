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
        
        self.modelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20,15.f, 90.f, 20.f)];
        [self.modelTitle setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.modelTitle setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.modelTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.modelTitle];
        
        self.lblDate = [[UILabel alloc] initWithFrame:CGRectMake(20,45.f, 40.f, 20.f)];
        [self.lblDate setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.lblDate setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.lblDate setTextAlignment:NSTextAlignmentCenter];
        [self.lblDate setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.lblDate];
        
        self.lblTime = [[UILabel alloc] initWithFrame:CGRectMake(70,45.f, 40.f, 20.f)];
        [self.lblTime setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.lblTime setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.lblTime setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblTime];
        
//        self.valueBG = [[UIView alloc] initWithFrame:CGRectMake(50,10.f,240.f, 20.f)];
//        [self addSubview:self.valueBG];
        
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
    }
    
    // 设置日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
    NSDate *someDay = [fmt dateFromString:[dic objectForKey:@"date"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
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

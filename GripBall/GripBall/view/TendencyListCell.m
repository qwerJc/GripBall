//
//  TendencyListCell.m
//  GripBall
//
//  Created by 贾辰 on 2018/4/16.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TendencyListCell.h"
#import "ModelLocator.h"

@interface TendencyListCell()
@property (strong ,nonatomic)UIView *valueBG;
@property (strong, nonatomic)UILabel *lbldata;
@property (strong, nonatomic)UILabel *lblvalue;
@end

//max Height 200 Weight :45
@implementation TendencyListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.valueBG = [[UIView alloc] initWithFrame:CGRectZero];
        [_valueBG setBackgroundColor:[UIColor colorWithRed:82.f/255.f green:152.f/255.f blue:188.f/255.f alpha:1]];
        [self.valueBG.layer setCornerRadius:7.5];
        [self.valueBG.layer setMasksToBounds:YES];
        [self addSubview:self.valueBG];
        
        self.lbldata = [[UILabel alloc] initWithFrame:CGRectMake(0 ,10.f, 30.f, 20.f)];
        [self.lbldata setTextColor:[UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:1]];
        [self.lbldata setFont:[UIFont fontWithName:@"ArialMT" size:12.f]];
        self.lbldata.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self.lbldata setTextAlignment:NSTextAlignmentCenter];
        [self.lbldata setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.lbldata];

        self.lblvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+30,15.f, 30.f, 20.f)];
        [self.lblvalue setTextColor:[UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:1]];
        [self.lblvalue setFont:[UIFont fontWithName:@"ArialMT" size:12.f]];
        [self.lblvalue setTextAlignment:NSTextAlignmentCenter];
        self.lblvalue.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self.lblvalue setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.lblvalue];
//
//        self.lblHand = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+105,15.f, 35.f, 20.f)];
//        [self.lblHand setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
//        [self.lblHand setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
//        [self.lblHand setTextAlignment:NSTextAlignmentLeft];
//        [self addSubview:self.lblHand];
    }
    return self;
}

-(void)setTestValue:(NSDictionary *)data withTag:(NSInteger)tag{

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
    NSDate *someDay = [fmt dateFromString:[data objectForKey:@"date"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/dd"];
    
    [self.lbldata setText:[formatter stringFromDate:someDay]];
    
    if (tag == 0) {
        //range : 0-120
        float value = [[data objectForKey:@"lval"] floatValue];
        //30 bottom
        [self.valueBG setFrame:CGRectMake(30, 15, value, 15)];
        
        [self.lblvalue setFrame:CGRectMake(value+35, 0, 20, 45)];
        [self.lblvalue setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"lval"]]];
        
        [self.lbldata setFrame:CGRectMake(10 ,0.f, 20.f, 45)];
    }else{
        
        float value = [[data objectForKey:@"rval"] floatValue];
        //30 bottom
        [self.valueBG setFrame:CGRectMake(30, 15, value, 15)];
        
        [self.lblvalue setFrame:CGRectMake(value+35, 0, 20, 45)];
        [self.lblvalue setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"rval"]]];
        
        [self.lbldata setFrame:CGRectMake(10 ,0.f, 20.f, 45)];
    }
}

-(void)setExplodeValue:(NSDictionary *)data withTag:(NSInteger)tag{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
    NSDate *someDay = [fmt dateFromString:[data objectForKey:@"date"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/dd"];
    
    [self.lbldata setText:[formatter stringFromDate:someDay]];
    
    if (tag == 0) {
        float lval = [[data objectForKey:@"lval"] floatValue];
        float lcost = [[data objectForKey:@"lcost"] floatValue];
        
        if (lcost<1) {
            lcost = 1;
        }
        
        float rate = lval / lcost;
        
        [self.valueBG setFrame:CGRectMake(30, 15, rate, 15)];
        
        [self.lblvalue setFrame:CGRectMake(rate+35, 0, 20, 45)];
        [self.lblvalue setText:[NSString stringWithFormat:@"%@/%@",[data objectForKey:@"lval"],[data objectForKey:@"lcost"]]];
        
        [self.lbldata setFrame:CGRectMake(10 ,0.f, 20.f, 45)];
    }else{
        float lval = [[data objectForKey:@"rval"] floatValue];
        float lcost = [[data objectForKey:@"rcost"] floatValue];
        
        if (lcost<1) {
            lcost = 1;
        }
        
        float rate = lval / lcost;
        
        [self.valueBG setFrame:CGRectMake(30, 15, rate, 15)];
        
        [self.lblvalue setFrame:CGRectMake(rate+35, 0, 20, 45)];
        [self.lblvalue setText:[NSString stringWithFormat:@"%@/%@",[data objectForKey:@"rval"],[data objectForKey:@"rcost"]]];
        
        [self.lbldata setFrame:CGRectMake(10 ,0.f, 20.f, 45)];
    }
}

-(void)setEnduranceValue:(NSDictionary *)data withTag:(NSInteger)tag{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
    NSDate *someDay = [fmt dateFromString:[data objectForKey:@"date"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/dd"];
    
    [self.lbldata setText:[formatter stringFromDate:someDay]];
    
    if (tag == 0) {
        float lval = [[data objectForKey:@"lval"] floatValue];

        if (lval >240) {
            lval = 240;
        }
        
        [self.valueBG setFrame:CGRectMake(30, 15, lval/2, 15)];
        
        [self.lblvalue setFrame:CGRectMake(lval/2+35, 0, 20, 45)];
        [self.lblvalue setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"lval"]]];
        
        [self.lbldata setFrame:CGRectMake(10 ,0.f, 20.f, 45)];
    }else{
        float lval = [[data objectForKey:@"rval"] floatValue];
        
        if (lval >240) {
            lval = 240;
        }
        
        [self.valueBG setFrame:CGRectMake(30, 15, lval/2, 15)];
        
        [self.lblvalue setFrame:CGRectMake(lval/2+35, 0, 20, 45)];
        [self.lblvalue setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"rval"]]];
        
        [self.lbldata setFrame:CGRectMake(10 ,0.f, 20.f, 45)];
    }
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

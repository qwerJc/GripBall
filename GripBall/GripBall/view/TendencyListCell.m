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
        [_valueBG setBackgroundColor:[UIColor blueColor]];
        [self addSubview:self.valueBG];
        
        self.lbldata = [[UILabel alloc] initWithFrame:CGRectMake(170 ,10.f, 30.f, 20.f)];
        [self.lbldata setTextColor:[UIColor colorWithRed:151.f/255.f green:151.f/255.f blue:151.f/255.f alpha:1]];
        [self.lbldata setFont:[UIFont fontWithName:@"ArialMT" size:12.f]];
        self.lbldata.transform = CGAffineTransformMakeRotation(-M_PI/2);
        [self.lbldata setTextAlignment:NSTextAlignmentCenter];
        [self.lbldata setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.lbldata];

        self.lblvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+30,15.f, 50.f, 20.f)];
        [self.lblvalue setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.lblvalue setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.lblvalue setTextAlignment:NSTextAlignmentCenter];
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
//    [self.valueBG setBackgroundColor:[UIColor grayColor]];
    [self.lbldata setText:@"5/13"];
    
    NSLog(@"data %@:",data);
    
    if (tag == 0) {
        int value = [[data objectForKey:@"lval"] intValue];
        float rate = value*1.f/120;
        [self.valueBG setFrame:CGRectMake(200*(1-rate), 15, 200*rate, 15)];
    }else{
        int value = [[data objectForKey:@"rval"] intValue];
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

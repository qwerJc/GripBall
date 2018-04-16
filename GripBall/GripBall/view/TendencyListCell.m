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
@property (strong, nonatomic)UILabel *data;
@property (strong, nonatomic)UILabel *value;
@end

@implementation TendencyListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.valueBG = [[UIView alloc] initWithFrame:CGRectMake(50,10.f,240.f, 20.f)];
        [self addSubview:self.valueBG];
        
//        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-80,15.f, 90.f, 20.f)];
//        //        [self.lblName setBackgroundColor:[UIColor blueColor]];
//        [self.lblName setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
//        [self.lblName setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
//        [self.lblName setTextAlignment:NSTextAlignmentCenter];
//        [self addSubview:self.lblName];
//
//        self.lblScore = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+30,15.f, 50.f, 20.f)];
//        [self.lblScore setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
//        [self.lblScore setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
//        [self.lblScore setTextAlignment:NSTextAlignmentCenter];
//        [self addSubview:self.lblScore];
//
//        self.lblHand = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+105,15.f, 35.f, 20.f)];
//        [self.lblHand setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
//        [self.lblHand setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
//        [self.lblHand setTextAlignment:NSTextAlignmentLeft];
//        [self addSubview:self.lblHand];
    }
    return self;
}

-(void)setvalue:(NSDictionary *)data withTag:(NSInteger)tag{
    [self.valueBG setBackgroundColor:[UIColor grayColor]];
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

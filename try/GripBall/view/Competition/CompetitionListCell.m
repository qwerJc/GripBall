//
//  CompetitionListCell.m
//  GripBall
//
//  Created by 贾辰 on 18/3/5.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "CompetitionListCell.h"
#import "ModelLocator.h"

@interface CompetitionListCell()
@property (nonatomic, strong)UILabel *lblNum;
@property (nonatomic, strong)UILabel *lblName;
@property (nonatomic, strong)UILabel *lblScore;
@property (nonatomic, strong)UILabel *lblHand;
@end

@implementation CompetitionListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.lblNum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-135,15.f,40.f, 20.f)];
        [self.lblNum setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.lblNum setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.lblNum setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblNum];
        
        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-80,15.f, 90.f, 20.f)];
//        [self.lblName setBackgroundColor:[UIColor blueColor]];
        [self.lblName setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.lblName setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.lblName setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblName];
        
        self.lblScore = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+30,15.f, 50.f, 20.f)];
        [self.lblScore setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.lblScore setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.lblScore setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblScore];
        
        self.lblHand = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+105,15.f, 35.f, 20.f)];
        [self.lblHand setTextColor:[UIColor colorWithRed:82.f/255.f green:125.f/255.f blue:188.f/255.f alpha:1]];
        [self.lblHand setFont:[UIFont fontWithName:@"ArialMT" size:18.f]];
        [self.lblHand setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblHand];
    }
    return self;
}

-(void)setNum:(NSString *)num andName:(NSString *)name andScore:(NSString *)score andHand:(NSString *)hand{
    [self.lblNum setText:num];
    [self.lblName setText:name];
    [self.lblScore setText:score];
    [self.lblHand setText:hand];
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

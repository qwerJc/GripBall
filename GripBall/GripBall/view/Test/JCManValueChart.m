//
//  JCManValueChart.m
//  GripBall
//
//  Created by 贾辰 on 18/1/28.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "JCManValueChart.h"

@interface JCManValueChart()
@property (strong, nonatomic)UIView *viewNowValue;
@end
@implementation JCManValueChart
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0,0,80, 270)];
        [viewBG.layer setCornerRadius:40];
        [viewBG.layer setMasksToBounds:YES];
        [self addSubview:viewBG];
        
        UIImageView *imgVBGValueMax = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 80.f, 280.f)];
        [imgVBGValueMax setImage:[UIImage imageNamed:@"test_strengValueMax"]];
        [viewBG addSubview:imgVBGValueMax];
        
        self.viewNowValue = [[UIView alloc] initWithFrame:CGRectMake(0, 270, 80, 270)];
        [self.viewNowValue.layer setCornerRadius:40];
        [self.viewNowValue.layer setMasksToBounds:YES];
        [viewBG addSubview:self.viewNowValue];
        
        UIImageView *imgVNowValueBG = [[UIImageView alloc] initWithFrame:viewBG.frame];
        [imgVNowValueBG setImage:[UIImage imageNamed:@"test_strengValueBG"]];
        [self.viewNowValue addSubview:imgVNowValueBG];

    }
    return self;
}
-(void)setManValue:(float)value{
    float startY;
    if (value >=120.f) {
        startY=0;
    }else if(value <=0 ){
        startY = 270.f;
    }else{
        startY= 270.f*(1-value/120.f);
    }
    [UIView animateWithDuration:0.45 animations:^{
        [self.viewNowValue setFrame:CGRectMake(0, startY, 80, 270)];
    }];
}
@end

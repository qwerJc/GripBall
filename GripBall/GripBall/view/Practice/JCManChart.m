//
//  JCManChart.m
//  GripBall
//
//  Created by 贾辰 on 18/1/1.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "JCManChart.h"
#import "ModelLocator.h"

#define Chart_Height 120
#define Chart_Width (SCREEN_WIDTH-70.f)

@interface JCManChart ()
@property (assign, nonatomic) CGPoint pointStart;
@property (assign, nonatomic) CGPoint pointEnd;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) int             valueNum;
@end

@implementation JCManChart

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _valueNum = 0;
        
        UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,Chart_Width, Chart_Height)];
        [imgBG setImage:[UIImage imageNamed:@"chartBG@2x.png"]];
        [self addSubview:imgBG];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(1,1,Chart_Width,Chart_Height-1)];
        self.scrollView.contentSize = CGSizeMake(Chart_Width*1000, 120);
        self.scrollView.scrollEnabled = NO;
        [self addSubview:self.scrollView];
        
        
        self.pointStart = CGPointMake(0, Chart_Height);
        self.pointEnd = CGPointMake(0, Chart_Height);
    }
    return self;
}

-(void)addLine:(float)endPointY{
    _valueNum++;
    
    //判断超过最大值及低于最小值
    if (endPointY>Chart_Height) {
        endPointY = endPointY;
    }else if (endPointY<0){
        endPointY = 0;
    }
    
    self.pointStart = self.pointEnd;
    self.pointEnd = CGPointMake(self.pointEnd.x+30, endPointY);
    
    //设置上方数值
    UILabel *lblChartValue;
    if (endPointY>Chart_Height/2) {
        lblChartValue = [[UILabel alloc] initWithFrame:CGRectMake(self.pointEnd.x-5, self.pointEnd.y-15, 35, 10)];
    }else{
        lblChartValue = [[UILabel alloc] initWithFrame:CGRectMake(self.pointEnd.x-5, self.pointEnd.y+5, 35, 10)];
    }
    
    int intValue = (Chart_Height - endPointY)*10;
    
    [lblChartValue setTextColor:[UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]];
    [lblChartValue setText: [NSString stringWithFormat:@"%d",intValue]];
    [lblChartValue setFont:[UIFont fontWithName:@"ArialMT" size:12.f]];
    [self.scrollView addSubview:lblChartValue];
    [lblChartValue setAlpha:0.f];
    [UIView animateWithDuration:0.3f animations:^{} completion:^(BOOL finished) {
        [lblChartValue setAlpha:1.f];
    }];
    
    //Scroll Move Right
    if (self.pointStart.x>Chart_Width*0.75) {
        [UIView animateWithDuration:0.4 animations:^{
            self.scrollView.contentOffset = CGPointMake(self.pointEnd.x-200, 0);
        } completion:^(BOOL finished) {
        }];
    }
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:self.pointStart];
    [line addLineToPoint:self.pointEnd];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    // 填充颜色
    layer.fillColor = [UIColor clearColor].CGColor;
    // 绘制颜色
    layer.strokeColor = [UIColor colorWithRed:82.f/255.f green:152.f/255.f blue:188.f/255.f alpha:1].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.lineWidth = 4;
    layer.frame = self.bounds;
    layer.path = line.CGPath;
    [self.scrollView.layer addSublayer:layer];
    
    //Animation
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animate.removedOnCompletion = NO;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:
                              kCAMediaTimingFunctionLinear];;
    animate.duration = 0.4;
    animate.fillMode = kCAFillModeForwards;
    animate.fromValue = @(0.0f);
    animate.toValue = @(1.0f);
    [layer addAnimation:animate forKey:@"checkAnimation"];
    
}


-(void)FinishTest{
    [self.scrollView setContentSize:CGSizeMake(_valueNum*30+20, 0)];
    self.scrollView.scrollEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

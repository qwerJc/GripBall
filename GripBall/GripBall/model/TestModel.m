//
//  TestModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/4/13.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "TestModel.h"
@interface TestModel()
@property (strong, nonatomic)NSDate *date;
@property (strong, nonatomic)NSString *lValue;
@property (strong, nonatomic)NSString *lScore;
@property (strong, nonatomic)NSString *rValue;
@property (strong, nonatomic)NSString *rScore;
@end

@implementation TestModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [self init];
    if (self) {
        NSString *sDay = [dic objectForKey:@"birthday"];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
        NSDate *someDay = [fmt dateFromString:sDay];
        _date = someDay;
        
        _lValue = [dic objectForKey:@"lefthand_val"];
        _lScore = [dic objectForKey:@"lefthand_score"];
        _rValue = [dic objectForKey:@"righthand_val"];
        _rScore = [dic objectForKey:@"righthand_score"];
        
    }
    return self;
}
-(NSString *)getLeftScore{
    return _lScore;
}
-(NSString *)getLeftValue{
    return _lValue;
}
-(NSString *)getRightScore{
    return _rScore;
}
-(NSString *)getRightValue{
    return _rValue;
}

//-(NSString *)getMonth{
//
//}

@end

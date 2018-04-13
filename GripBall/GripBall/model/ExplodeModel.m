//
//  ExplodeModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/4/13.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ExplodeModel.h"
@interface ExplodeModel()
@property (strong, nonatomic)NSDate *date;
@property (strong, nonatomic)NSString *lValue;
@property (strong, nonatomic)NSString *lTimeCost;
@property (strong, nonatomic)NSString *rValue;
@property (strong, nonatomic)NSString *rTimeCost;
@end

@implementation ExplodeModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [self init];
    if (self) {
        NSString *sDay = [dic objectForKey:@"birthday"];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
        NSDate *someDay = [fmt dateFromString:sDay];
        _date = someDay;
        

    }
    return self;
}
@end

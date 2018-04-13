//
//  UserInfoModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/4/11.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "UserInfoModel.h"
@interface UserInfoModel()
@property (strong, nonatomic)NSDate *birthday;
@property (strong, nonatomic)NSNumber *height;
@property (strong, nonatomic)NSNumber *weight;
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSNumber *sex;
@property (strong, nonatomic)NSString *phone;
@property (strong, nonatomic)NSString *headImgURL;
@property (strong, nonatomic)NSNumber *uid;
@property (strong, nonatomic)NSNumber *rid;
@end

@implementation UserInfoModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [self init];
    if (self) {
        NSString *sDay = [dic objectForKey:@"birthday"];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
        NSDate *someDay = [fmt dateFromString:sDay];
        NSLog(@"someDay : %@", someDay);
        _birthday = someDay;
        
        _height = [dic objectForKey:@"height"];
        _weight = [dic objectForKey:@"weight"];
        _name = [dic objectForKey:@"name"];
        _phone = [dic objectForKey:@"phone"];
        _rid = [dic objectForKey:@"rid"];
        _uid = [dic objectForKey:@"uid"];
        _sex = [dic objectForKey:@"sex"];
        
    }
    return self;
}
-(NSString *)getName{
    return _name;
}
-(NSString *)getPhone{
    return _phone;
}
-(NSString *)getHeight{
    return [_height stringValue];
}
-(NSString *)getWeight{
    return [_weight stringValue];
}
-(NSString *)getStrBirthday{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy年MM月dd日"];
//    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSString *strBirthday = [formatter stringFromDate:_birthday];
    return strBirthday;
}
-(int)getYears{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy"];
    NSString *year = [formatter stringFromDate:_birthday];
    return [year intValue];
}
-(NSString *)getSex{
    if ([_sex isEqualToNumber:[NSNumber numberWithInt:0]]) {
        return @"男";
    }else{
        return @"女";
    }
}
-(NSNumber *)getRid{
    return _rid;
}
-(NSNumber *)getUid{
    return _uid;
}
@end

//
//  UserInfoModel.h
//  GripBall
//
//  Created by 贾辰 on 2018/4/11.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
-(instancetype)initWithDic:(NSDictionary *)dic;
-(NSString *)getName;
-(NSString *)getPhone;
-(NSString *)getHeight;
-(NSString *)getWeight;
-(NSString *)getStrBirthday;
-(int)getYears;
-(NSString *)getSex;
-(NSNumber *)getRid;
-(NSNumber *)getUid;

-(void)setHeight:(NSString *)height andWeight:(NSString *)weight andBirth:(NSString *)birth andSex:(NSString *)sex;
@end

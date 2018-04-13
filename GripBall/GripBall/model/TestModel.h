//
//  TestModel.h
//  GripBall
//
//  Created by 贾辰 on 2018/4/13.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject
-(instancetype)initWithDic:(NSDictionary *)dic;
-(NSString *)getLeftScore;
-(NSString *)getLeftValue;
-(NSString *)getRightScore;
-(NSString *)getRightValue;
@end

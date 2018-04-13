//
//  GBModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/3/28.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "GBModel.h"
@interface GBModel()

@end

@implementation GBModel
+(GBModel *)shareModel{
    static dispatch_once_t onceToken;
    static GBModel *model = nil;
    if (model == nil) {
        dispatch_once(&onceToken, ^{
            model = [[GBModel alloc] init];
        });
    }
    return model;
}
-(NSMutableArray *)getElseUserList:(NSNumber *)mainRid{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<[_allUserList count]; i++) {
        UserInfoModel *userModel = [[UserInfoModel alloc] initWithDic:[_allUserList objectAtIndex:i]];
//        NSNumber* num1 = [NSNumber numberWithInt:23];
//        NSNumber* num2 = [NSNumber numberWithFloat:23.0f];
//        BOOL b = [num1 isEqualToNumber:num2];
        if (![[userModel getRid] isEqualToNumber:mainRid]) {
              [arr addObject:userModel];
        }

    }
    return arr;
}
@end

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

@end

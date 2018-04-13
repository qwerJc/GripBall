//
//  GBModel.m
//  GripBall
//
//  Created by 贾辰 on 2018/3/28.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "GBModel.h"
#import "TestModel.h"
#import "ExplodeModel.h"
#import "EnduranceModel.h"

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
        if (![[userModel getRid] isEqualToNumber:mainRid]) {
              [arr addObject:userModel];
        }

    }
    return arr;
}

//-(NSMutableArray *)getPracticeList{
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i<[_practiceList count]; i++) {
//        PracticeModel *model = [[PracticeModel alloc] initWithDic:[_practiceList objectAtIndex:i]];
//        [arr addObject:model];
//    }
//    return arr;
//}

-(NSMutableArray *)getTestList{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<[_testList count]; i++) {
        TestModel *model = [[TestModel alloc] initWithDic:[_testList objectAtIndex:i]];
        [arr addObject:model];
    }
    return arr;
}

-(NSMutableArray *)getExplodeList{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<[_explodeList count]; i++) {
        ExplodeModel *model = [[ExplodeModel alloc] initWithDic:[_explodeList objectAtIndex:i]];
        [arr addObject:model];
    }
    return arr;
}

-(NSMutableArray *)getEnduranceList{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<[_enduranceList count]; i++) {
        EnduranceModel *model = [[EnduranceModel alloc] initWithDic:[_enduranceList objectAtIndex:i]];
        [arr addObject:model];
    }
    return arr;
}
@end

//
//  GBModel.h
//  GripBall
//
//  Created by 贾辰 on 2018/3/28.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "TestModel.h"
#import "ExplodeModel.h"
#import "EnduranceModel.h"

@interface GBModel : NSObject
@property (strong ,nonatomic) NSString *telephone;
@property (strong ,nonatomic) NSNumber *uid;
@property (strong ,nonatomic) NSNumber *rid;    //主用户 id
@property (strong, nonatomic) NSArray *allUserList;
@property (strong, nonatomic) NSArray *practiceList;
@property (strong, nonatomic) NSArray *testList;
@property (strong, nonatomic) NSArray *explodeList;
@property (strong, nonatomic) NSArray *enduranceList;
@property (strong, nonatomic) UserInfoModel *userInfo;
@property (strong, nonatomic) NSArray *newestListData;
+(GBModel *)shareModel;
-(NSMutableArray *)getElseUserList:(NSNumber *)mainRid;
//-(NSMutableArray *)getPracticeList;
-(NSMutableArray *)getTestList;
-(NSMutableArray *)getExplodeList;
-(NSMutableArray *)getEnduranceList;
@end

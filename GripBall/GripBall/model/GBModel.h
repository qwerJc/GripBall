//
//  GBModel.h
//  GripBall
//
//  Created by 贾辰 on 2018/3/28.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBModel : NSObject
@property (strong ,nonatomic) NSString *uid;
@property (strong ,nonatomic) NSString *rid;
@property (strong, nonatomic) NSArray *allUserList;
@property (strong, nonatomic) NSArray *practiceList;
@property (strong, nonatomic) NSArray *testList;
@property (strong, nonatomic) NSArray *explodeList;
@property (strong, nonatomic) NSArray *enduranceList;
+(GBModel *)shareModel;

@end

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
+(GBModel *)shareModel;

@end

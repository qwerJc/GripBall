//
//  TendencyListCell.h
//  GripBall
//
//  Created by LHHH on 2018/4/16.
//  Copyright © 2018年 LHHH. All rights reserved.
//
//explosive
//                 {
//                     date = "Sat, 07 Apr 2018 11:06:05 GMT";
//                     lcost = 5;
//                     lval = 10;
//                     rcost = 12;
//                     rval = 15;
//                 },

#import <UIKit/UIKit.h>

@interface TendencyListCell : UITableViewCell
//tag 左右手标志
-(void)setTestValue:(NSDictionary *)data withTag:(NSInteger)tag;
-(void)setExplodeValue:(NSDictionary *)data withTag:(NSInteger)tag;
-(void)setEnduranceValue:(NSDictionary *)data withTag:(NSInteger)tag;
@end

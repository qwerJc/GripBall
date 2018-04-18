//
//  CompetitionListViewController.h
//  GripBall
//
//  Created by 贾辰 on 18/3/5.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelLocator.h"

@interface CompetitionListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
-(void)setTitle:(NSString *)title;
-(void)reloadExplodeList;
-(void)reloadEnduranceList;
@end

//
//  SearchResViewController.h
//  GripBall
//
//  Created by 贾辰 on 17/9/27.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
-(void)showSuccessView:(NSMutableArray *)arr;
-(void)showFailView;
@end

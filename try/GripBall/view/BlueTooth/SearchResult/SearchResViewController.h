//
//  SearchResViewController.h
//  GripBall
//
//  Created by 贾辰 on 17/9/27.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设置delegate
@protocol SearchDelegate // 代理传值方法
- (void)blueToothConnect:(int)index;
- (void)reConnect;
@end

@interface SearchResViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) id delegate;        //委托代理人，代理一般需使用弱引用(weak)
-(void)showSuccessView:(NSMutableArray *)arr;
-(void)showFailView;
@end

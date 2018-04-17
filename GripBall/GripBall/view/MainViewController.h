//
//  MainViewController.h
//  GripBall
//
//  Created by Lhnn on 17/9/26.
//  Copyright © 2017年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SearchResViewController.h"
#import "ShowAllUserViewController.h"

@interface MainViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate,SearchDelegate,ChangeUserDelegate,UITableViewDelegate,UITableViewDataSource>

@end

//
//  MainViewController.h
//  GripBall
//
//  Created by 贾辰 on 17/9/26.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MainViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate>

@end

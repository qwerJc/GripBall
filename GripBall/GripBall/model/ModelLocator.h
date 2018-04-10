//
//  ModelLocator.h
//  GripBall
//
//  Created by 贾辰 on 17/9/25.
//  Copyright © 2017年 贾辰. All rights reserved.
//

#ifndef ModelLocator_h

#import "GBModel.h"
#import "HTTPModel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale

#define SCREEN_HEIGHT [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale

#define ONE_PIXEL_WIDTH 1/[UIScreen mainScreen].nativeScale

#define model [GBModel shareModel]

#define httpModel [HTTPModel shareHttpModel]



#endif /* ModelLocator_h */


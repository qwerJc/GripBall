//
//  ViewController.m
//  AFNetWorking
//
//  Created by 贾辰 on 18/1/8.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#import "ModelLocator.h"

@interface ViewController ()
@property (strong, nonatomic) UIImageView *imgv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 80, 20)];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"验证码" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 40, 80, 20)];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"注册" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 80, 20)];
    [btn3 setBackgroundColor:[UIColor redColor]];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"设密码" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, 80, 20)];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 setTitle:@"登陆" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btn4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 80, 20)];
    [btn5 setBackgroundColor:[UIColor redColor]];
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn5 setTitle:@"完善信息" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(btn5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [[UIButton alloc] initWithFrame:CGRectMake(100, 120, 80, 20)];
    [btn6 setBackgroundColor:[UIColor redColor]];
    [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn6 setTitle:@"更改信息" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(btn6) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 80, 20)];
    [btn7 setBackgroundColor:[UIColor redColor]];
    [btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn7 setTitle:@"get列表" forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(btn7) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [[UIButton alloc] initWithFrame:CGRectMake(100, 160, 80, 20)];
    [btn8 setBackgroundColor:[UIColor redColor]];
    [btn8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn8 setTitle:@"切换角色" forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(btn8) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    
    UIButton *btn9 = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 80, 20)];
    [btn9 setBackgroundColor:[UIColor redColor]];
    [btn9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn9 setTitle:@"练习" forState:UIControlStateNormal];
    [btn9 addTarget:self action:@selector(btn9) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn9];
    
    UIButton *btn10 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 80, 20)];
    [btn10 setBackgroundColor:[UIColor redColor]];
    [btn10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn10 setTitle:@"测试" forState:UIControlStateNormal];
    [btn10 addTarget:self action:@selector(btn10) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn10];
    
    UIButton *btn11 = [[UIButton alloc] initWithFrame:CGRectMake(10, 240, 80, 20)];
    [btn11 setBackgroundColor:[UIColor redColor]];
    [btn11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn11 setTitle:@"爆发" forState:UIControlStateNormal];
    [btn11 addTarget:self action:@selector(btn11) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn11];
    
    UIButton *btn12 = [[UIButton alloc] initWithFrame:CGRectMake(100, 240, 80, 20)];
    [btn12 setBackgroundColor:[UIColor redColor]];
    [btn12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn12 setTitle:@"耐力" forState:UIControlStateNormal];
    [btn12 addTarget:self action:@selector(btn12) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn12];
    
    UIButton *btn13 = [[UIButton alloc] initWithFrame:CGRectMake(10, 280, 80, 20)];
    [btn13 setBackgroundColor:[UIColor redColor]];
    [btn13 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn13 setTitle:@"爆发排行" forState:UIControlStateNormal];
    [btn13 addTarget:self action:@selector(btn13) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn13];
    
    UIButton *btn14 = [[UIButton alloc] initWithFrame:CGRectMake(100, 280, 80, 20)];
    [btn14 setBackgroundColor:[UIColor redColor]];
    [btn14 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn14 setTitle:@"耐力排行" forState:UIControlStateNormal];
    [btn14 addTarget:self action:@selector(btn14) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn14];
    
    UIButton *btn15 = [[UIButton alloc] initWithFrame:CGRectMake(10, 320, 80, 20)];
    [btn15 setBackgroundColor:[UIColor redColor]];
    [btn15 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn15 setTitle:@"del" forState:UIControlStateNormal];
    [btn15 addTarget:self action:@selector(btn15) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn15];
    
    UIButton *btn16 = [[UIButton alloc] initWithFrame:CGRectMake(100, 320, 180, 20)];
    [btn16 setBackgroundColor:[UIColor redColor]];
    [btn16 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn16 setTitle:@"获取排行榜" forState:UIControlStateNormal];
    [btn16 addTarget:self action:@selector(btn16) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn16];
    
    UIButton *btn17 = [[UIButton alloc] initWithFrame:CGRectMake(10, 320, 80, 20)];
    [btn17 setBackgroundColor:[UIColor redColor]];
    [btn17 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn17 setTitle:@"del" forState:UIControlStateNormal];
    [btn17 addTarget:self action:@selector(btn15) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn17];
    
    UIButton *btn18 = [[UIButton alloc] initWithFrame:CGRectMake(100, 320, 180, 20)];
    [btn18 setBackgroundColor:[UIColor redColor]];
    [btn18 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn18 setTitle:@"获取排行榜" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(btn16) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn18];
}
//////////////////////////////////////////////////////////////////////////////
-(void)btn1{
    [httpModel getVcodeWithTelNum:@"18701459239" Completion:^{
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        if (num == 2) {
            NSLog(@"已注册");
        }else if(num == 3){
            NSLog(@"未知错误");
        }else{
            NSLog(@"请检查当前网络");
        }
    }];
}

-(void)btn2{
    [httpModel registerWithTelNum:@"18701459239" andVCode:@"60311" Completion:^() {
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        if (num == 2) {
            NSLog(@"已注册");
        }else if(num == 3){
            NSLog(@"验证码错误");
        }else if(num == 4){
            NSLog(@"验证码过期");
        }else if (num == 5){
            NSLog(@"未知错误");
        }else{
            NSLog(@"请检查当前网络");
        }
    }];
}
-(void)btn3{
    [httpModel setPassWordWithPwd:@"12345" Completion:^{
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        if (num == 2) {
            NSLog(@"设置失败");
        }else{
            NSLog(@"请检查当前网络");
        }
    }];
}
//login
-(void)btn4{
    [model setTelephone:@"15755396353"];
    [httpModel logInWithTelNum:[model telephone]
                        andPwd:@"666888"
                    Completion:^{
                        
                        NSLog(@"登陆成功");
                    }
                         error:^(NSError *error, int num) {
                             if (num == 2 ) {
                                 NSLog(@"账户不存在或密码错误");
                             }else if(num == 3){
                                 NSLog(@"未知错误");
                             }else{
                                 NSLog(@"请检查当前网络");
                             }
                         }];
}
//完善信息
-(void)btn5{
    [httpModel completeInformationWithName:@"try1"
                                    andSex:@"nan"
                               andBirthday:@"1990/01/01"
                                 andHeight:@"173"
                                 andWeight:@"83"
                                 andTelNum:@"15755396353"
                                Completion:^{
                                    NSLog(@"成功");
                                } error:^(NSError *error, int num) {
                                    if (num == 2 ) {
                                        NSLog(@"完善失败");
                                    }else{
                                        NSLog(@"请检查当前网络");
                                    }
                                }];
}

//修改信息
-(void)btn6{
    [httpModel changeInformationWithName:@"try5" andSex:@"男" andBirthday:@"1900年1月1日" andHeight:@"173" andWeight:@"83" Completion:^{
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"修改失败");
        }else{
            NSLog(@"请检查当前网络 changeInformation");
        }
    }];
    
//    [httpModel changeInformationWithName:@"try1"
//                                  andSex:@"nan"
//                             andBirthday:@"1900/01/01"
//                               andHeight:@"173"
//                               andWeight:@"83"
//                               andTelNum:[model telephone]
//                              Completion:^{
//                                  NSLog(@"成功");
//                              } error:^(NSError *error, int num) {
//                                  if (num == 2 ) {
//                                      NSLog(@"修改失败");
//                                  }else{
//                                      NSLog(@"请检查当前网络 changeInformation");
//                                  }
//                              }];
}
//获取角色列表
-(void)btn7{
    [httpModel getUserListWithCompletion:^(NSArray *arr) {
        NSLog(@"获取列表成功：");
    } error:^(NSError *error, int num) {
        NSLog(@"请检查当前网络");
    }];
}

//切换角色
-(void)btn8{
    //main 8 8| 8 11
    [httpModel changeUserWithUid:@"8" andRid:@"11" Completion:^{
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        NSLog(@"请检查当前网络");
    }];
}

-(void)btn9{
    [httpModel postPracticeRecordWithTimecost:@"1" andCount:@"1" andValue:@"1" Completion:^{
        NSLog(@"练习模式 上传成功");
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"修改失败");
        }else{
            NSLog(@"请检查当前网络 Practice");
        }
    }];
    
    
}

-(void)btn10{
    //测试
    [httpModel postTestRecordWithLeftHandValue:@"1" andLeftHandScore:@"1" andRightHandValue:@"1" andRightHandScore:@"1" Completion:^{
        NSLog(@"测试 上传成功");
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"修改失败");
        }else{
            NSLog(@"请检查当前网络 Practice");
        }
    }];
}

-(void)btn11{
    //爆发
    [httpModel postExplodeWithLeftHandValue:@"15" andLeftHandCostTime:@"15.1" andRightHandValue:@"1" andRightHandCostTime:@"1.1" Completion:^{
        NSLog(@"爆发 上传成功");
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"修改失败");
        }else{
            NSLog(@"请检查当前网络 爆发");
        }
    }];
}

-(void)btn12{
    //耐力
    [httpModel postEnduranceWithLeftHandValue:@"1" andLeftHandCostTime:@"1" andRightHandValue:@"1" andRightHandCostTime:@"1" Completion:^{
        NSLog(@"耐力 上传成功");
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"修改失败");
        }else{
            NSLog(@"请检查当前网络 爆发");
        }
    }];
}

-(void)btn13{
    //list - 爆发
    [httpModel getExplodeListWithCompletion:^(NSArray *list) {
        NSLog(@"成功:%@",list);
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"获取失败");
        }else{
            NSLog(@"请检查当前网络 爆发");
        }
    }];
}
-(void)btn14{
    [httpModel getEnduranceListWithCompletion:^(NSArray *list) {
        NSLog(@"成功:%@",list);
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"获取失败");
        }else{
            NSLog(@"请检查当前网络 爆发");
        }
    }];
    //list - 耐力
}

-(void)btn15{
    [httpModel deleteRoleWithUid:@"8" andRid:@"13" Completion:^{
        NSLog(@"成功");
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"获取失败");
        }else{
            NSLog(@"请检查当前网络 爆发");
        }
    }];
}

-(void)btn16{
    [httpModel getUserListWithCompletion:^(NSArray *arr) {
        NSLog(@"所有用户列表：%@",arr);
    } error:^(NSError *error, int num) {
        if (num == 2 ) {
            NSLog(@"获取失败");
        }else{
            NSLog(@"请检查当前网络 爆发");
        }
    }];
}

//////////////////////////////////////////////////////////////////////////////
    //普通的get方法
-(void)clickBtn1{
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //使AFNetWorking 支持“text／html”数据格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:@"http://101.132.38.221/php/login.php" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSError *error;
             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                                options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                  error:&error];
             //        NSData - dictory
             NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
             
             NSLog(@"这里打印请求成功要做的事");
             NSLog(@"dic2 :%@", listDic);
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}

-(void)clickBtn2{
//    [self addPost];
    [self post2];
}

-(void)post2{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //我用的xcode7.2 ,AFNetworking3.0 不写下面这句话发送请求后台收不到请求头信息，其他版本自行测试
//    manager.requestSerializer = [AFJSONRequestSerializer new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
//    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    
    NSDictionary *params = @{
                             @"uid" :[NSNumber numberWithInt:11],
                             @"name":@"00000",
                             @"sex":[NSNumber numberWithInt:1],
                             @"birthday":@"1900/01/01",
                             @"height":[NSNumber numberWithInt:155],
                             @"weight":[NSNumber numberWithInt:86],
                             @"headimg":@"",
                             @"phone":@"15755396353"
                             };
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
//    /stressapp/api/modify_profile
    //NSString *url = [NSString stringWithFormat:@"http://120.79.133.38:8089/stressapp/api/add_new_role"];
    NSString *url = [NSString stringWithFormat:@"http://120.79.133.38:8089/stressapp/api/modify_profile"];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"succ");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
        NSLog(@"%@",error);  //这里打印错误信息
    }];
}

-(void)addPost{
    NSDictionary *params = @{
                             @"uid" :@"8",
                             @"name":@"qwertyu",
                             @"sex":@"nan",
                             @"birthday":@"1900/01/01",
                             @"height":@"144",
                             @"weight":@"86",
                             @"headimg":@"",
                             @"phone":@"15755396353"
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];      //申明请求的数据是json类型
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    AFHTTPRequestSerializer *ser = manager.requestSerializer;
//    [ser setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    manager.requestSerializer = ser;
//
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//申明返回的结果是json类型
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    AFJSONRequestSerializer *jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    [jsonRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = jsonRequestSerializer;
    
    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableSet *jsonResAcceptableContentTypes = [NSMutableSet setWithSet:jsonResponseSerializer.acceptableContentTypes];
    [jsonResAcceptableContentTypes addObject:@"application/json"];
    jsonResponseSerializer.acceptableContentTypes = jsonResAcceptableContentTypes;
    manager.responseSerializer = jsonResponseSerializer;
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSString *url = [NSString stringWithFormat:@"http://120.79.133.38:8089/stressapp/api/add_new_role"];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"succ");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
         NSLog(@"%@",error);  //这里打印错误信息
    }];
}

    //格式化 日期
-(void)clickBtn3{

//    NSString *time = @"Mon, 01 Jan 1900 00:00:00 GMT";
//    NSString *time =@"Tue May 31 17:46:55 +0800 2011";
//    NSLog(@"time %@:",time);
    NSString *string = @"Mon, 01 Jan 1900 00:00:00 GMT";
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
     fmt.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
    // 设置语言区域(因为这种时间是欧美常用时间)
    NSDate *someDay = [fmt dateFromString:string];
    NSLog(@"%@", someDay);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    NSString *currentDateString = [formatter stringFromDate:someDay];
    NSLog(@"%@", currentDateString);
}

//上传头像的方法
-(void)clickBtn4{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求参数
    
    NSString *url = @"http://101.132.38.221/php/recImage2.php";
    NSDictionary *parameters = nil;
    
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage* temImage= _imgv.image;
        
        // 获取图片数据
        NSData *fileData = UIImageJPEGRepresentation(temImage, 1.0);
        
        //            NSString *fileName = [NSString stringWithFormat:@"%@", [_arrayOfAlbum objectAtIndex:i]];
        
        [formData appendPartWithFileData:fileData name:@"image" fileName:@"JJC" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功：%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败：%@", error);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

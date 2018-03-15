//
//  ViewController.m
//  AFNetWorking
//
//  Created by 贾辰 on 18/1/8.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (strong, nonatomic) UIImageView *imgv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 220, 80)];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"btn1-Get" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 220, 80)];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"btn1-Post" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 220, 80)];
    [btn3 setBackgroundColor:[UIColor redColor]];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"btn3-Download" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(clickBtn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 220, 80)];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 setTitle:@"ImgPost" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(clickBtn4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    _imgv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 500, 50, 50)];
    [_imgv setImage:[UIImage imageNamed:@"Group Copy"]];
    [self.view addSubview:_imgv];
}

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
    
}

-(void)clickBtn3{
    
}

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

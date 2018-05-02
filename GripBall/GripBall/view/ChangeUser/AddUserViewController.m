//
//  AddUserViewController.m
//  GripBall
//
//  Created by 贾辰 on 18/3/18.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "AddUserViewController.h"
#import "ModelLocator.h"
#import "JCAlertLogin.h"

@interface AddUserViewController ()<
UIPickerViewDelegate,
UIPickerViewDataSource,
UIImagePickerControllerDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
@property (strong, nonatomic) UITextField *txfName;
@property (strong, nonatomic) UITextField *txfHeight;
@property (strong, nonatomic) UITextField *txfWeight;

@property (strong, nonatomic) UIImage     *imgHead;//留备份以便上传至服务器

@property (strong, nonatomic) UIPickerView *pickerSex;
@property (strong, nonatomic) UIPickerView *pickerBirth;
@property (strong, nonatomic) UIPickerView *pickerHeight;
@property (strong, nonatomic) UIPickerView *pickerWeight;

@property (strong, nonatomic) UIButton     *btnFinish;
@property (strong, nonatomic) UIButton     *btnHeadPic;
@property (strong, nonatomic) UIButton     *btnSex;
@property (strong, nonatomic) UIButton     *btnBirth;
//@property (strong, nonatomic) UIButton     *btnHeight;
//@property (strong, nonatomic) UIButton     *btnWeight;

@property (strong, nonatomic) NSArray             *arrSex;
@property (strong, nonatomic) NSMutableArray      *arrYear;
@property (strong, nonatomic) NSMutableArray      *arrMonth;
@property (strong, nonatomic) NSMutableArray      *arrDay;
@property (strong, nonatomic) NSMutableArray      *arrHeight;
@property (strong, nonatomic) NSMutableArray      *arrWidth;

@property (strong, nonatomic) NSString *strYear,*strMonth,*strDay;

@property (strong, nonatomic) JCAlertLogin       *alert;

@property(nonatomic,strong) UIImagePickerController *imagePicker;   //相册图片控制器
@end

@implementation AddUserViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _arrSex = [NSArray arrayWithObjects:@"男",@"女",nil];
        _arrYear = [[NSMutableArray alloc]initWithCapacity:1];
        for (int i =1930; i<2017; i++) {
            [_arrYear addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _arrMonth = [[NSMutableArray alloc]initWithCapacity:1];
        for (int i =1; i<13; i++) {
            [_arrMonth addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _arrDay = [[NSMutableArray alloc]initWithCapacity:1];
        for (int i =1; i<32; i++) {
            [_arrDay addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _arrHeight = [[NSMutableArray alloc]initWithCapacity:1];
        for (int i =1; i<231; i++) {
            [_arrHeight addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _arrWidth = [[NSMutableArray alloc]initWithCapacity:1];
        for (int i =1; i<300; i++) {
            [_arrWidth addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _strYear = [_arrYear objectAtIndex:0];
        _strMonth = [_arrMonth objectAtIndex:0];
        _strDay  = [_arrDay objectAtIndex:0];
        
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self; //设置代理
        _imagePicker.allowsEditing = YES;
        
         [self createUI];
    }
    return self;
}

-(void)createUI
{
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.5]];
    
    UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(36, 30, SCREEN_WIDTH -72, SCREEN_HEIGHT-160)];
    [self.view addSubview:viewContainer];
    // Do any additional setup after loading the view.
    
    UIImageView *imvBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewContainer.frame.size.width, viewContainer.frame.size.height)];
    [imvBG setImage:[UIImage imageNamed:@"Login_white_BG_long"]];
    [viewContainer addSubview:imvBG];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20.f, 30.f, 10.f, 20.f)];
    [imgv setImage:[UIImage imageNamed:@"Change_btn_back2"]];
    [viewContainer addSubview:imgv];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10.f, 10.f, 60.f, 60.f)];
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack addTarget:self action:@selector(onBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [viewContainer addSubview:btnBack];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width/2 - 50.f,30.f, 100.f, 20.f)];
    [lblTitle setText:@"添加新用户"];
    [lblTitle setTextColor:[UIColor colorWithRed:75.f/255.f green:75.f/255.f blue:75.f/255.f alpha:1]];
    [lblTitle setFont:[UIFont fontWithName:@"ArialMT" size:16.f]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [viewContainer addSubview:lblTitle];
    
    _btnFinish = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-50.f, 25.f, 30.f, 30.f)];
    [_btnFinish setBackgroundImage:[UIImage imageNamed:@"Login_icon_ok_h"] forState:UIControlStateNormal];
    [_btnFinish addTarget:self action:@selector(onBtnFinish) forControlEvents:UIControlEventTouchUpInside];
    [viewContainer addSubview:_btnFinish];
    [_btnFinish setHidden:YES];
    
    UIImageView *imgvBtnFinishBG = [[UIImageView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-50.f, 25.f, 30.f, 30.f)];
    [imgvBtnFinishBG setImage:[UIImage imageNamed:@"Change_btn_ok"]];
    [viewContainer addSubview:imgvBtnFinishBG];
    
    _btnHeadPic = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width/2-37.f, 100.f, 74.f, 74.f)];
    [_btnHeadPic setBackgroundImage:[UIImage imageNamed:@"Login_headPic_placeholder"] forState:UIControlStateNormal];
    [_btnHeadPic addTarget:self action:@selector(onBtnHeadPic) forControlEvents:UIControlEventTouchUpInside];
    [_btnHeadPic.layer setCornerRadius:37.f];
    [_btnHeadPic.layer setMasksToBounds:YES];
    [viewContainer addSubview:_btnHeadPic];
    
    UILabel *lblHeadPicTip = [[UILabel alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width/2-50.f, 190.f, 100, 20.f)];
    [lblHeadPicTip setText:@"请上传头像"];
    [lblHeadPicTip setTextColor:[UIColor colorWithRed:100.f/255.f green:100.f/255.f blue:100.f/255.f alpha:1]];
    [lblHeadPicTip setFont:[UIFont fontWithName:@"ArialMT" size:15.f]];
    [lblHeadPicTip setTextAlignment:NSTextAlignmentCenter];
    [viewContainer addSubview:lblHeadPicTip];
    
    //姓名
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(40, 250.f, 40, 20.f)];
    [lblName setText:@"姓名"];
    [lblName setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
    [lblName setFont:[UIFont fontWithName:@"Arial" size:15.f]];
    [lblName setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:lblName];
    
    _txfName = [[UITextField alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-150.f, 250.f, 100.f, 20.f)];
    [_txfName setPlaceholder:@"请填写姓名"];
    _txfName.textColor = [UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1];
    _txfName.font = [UIFont fontWithName:@"Arial" size:15.0f];
    [_txfName setTextAlignment:NSTextAlignmentRight];
//    [_txfName setBackgroundColor:[UIColor redColor]];
    [viewContainer addSubview:_txfName];
    
    UIView *viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(35, 276,viewContainer.frame.size.width-70, 1)];
    [viewLine1 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [viewContainer addSubview:viewLine1];
    
    //Sex
    UILabel *lblSex = [[UILabel alloc] initWithFrame:CGRectMake(40, 290.f, 40, 20.f)];
    [lblSex setText:@"性别"];
    [lblSex setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
    [lblSex setFont:[UIFont fontWithName:@"Arial" size:15.f]];
    [lblSex setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:lblSex];
    
    _btnSex = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-150.f, 290.f, 125.f, 20.f)];
    [_btnSex setTitleColor:[UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1] forState:UIControlStateNormal];
    [_btnSex.titleLabel setFont:[UIFont fontWithName:@"Arial" size:15.f]];
    [_btnSex addTarget:self
                action:@selector(onBtnSex)
      forControlEvents:UIControlEventTouchUpInside];
    [_btnSex setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [_btnSex setBackgroundColor:[UIColor redColor]];
    [_btnSex setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 36)];
    [viewContainer addSubview:_btnSex];
    
    UIImageView *triangleSex = [[UIImageView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-35, 296, 8, 8)];
    [triangleSex setImage:[UIImage imageNamed:@"Login_icon_Triangle"]];
    [viewContainer addSubview:triangleSex];
    
    UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(35, 316,viewContainer.frame.size.width-70, 1)];
    [viewLine2 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [viewContainer addSubview:viewLine2];

    //Birthday
    UILabel *lblBirth = [[UILabel alloc] initWithFrame:CGRectMake(40, 330.f, 40, 20.f)];
    [lblBirth setText:@"生日"];
    [lblBirth setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
    [lblBirth setFont:[UIFont fontWithName:@"Arial" size:15.f]];
    [lblBirth setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:lblBirth];
    
    _btnBirth = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-175.f, 330.f, 150.f, 20.f)];
    [_btnBirth setTitleColor:[UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1] forState:UIControlStateNormal];
    [_btnBirth.titleLabel setFont:[UIFont fontWithName:@"Arial" size:15.f]];
    [_btnBirth addTarget:self
                  action:@selector(onBtnBirth)
        forControlEvents:UIControlEventTouchUpInside];
    [_btnBirth setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_btnBirth setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
    [viewContainer addSubview:_btnBirth];
//    [_btnBirth setBackgroundColor:[UIColor redColor]];
    
    UIImageView *triangleBirth = [[UIImageView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-35, 336, 8, 8)];
    [triangleBirth setImage:[UIImage imageNamed:@"Login_icon_Triangle"]];
    [viewContainer addSubview:triangleBirth];
    
    UIView *viewLine3 = [[UIView alloc] initWithFrame:CGRectMake(35, 356,viewContainer.frame.size.width-70, 1)];
    [viewLine3 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [viewContainer addSubview:viewLine3];
    
    //height
    UILabel *lblHeight = [[UILabel alloc] initWithFrame:CGRectMake(40, 370.f, 40, 20.f)];
    [lblHeight setText:@"身高"];
    [lblHeight setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
    [lblHeight setFont:[UIFont fontWithName:@"Arial" size:15.f]];
    [lblHeight setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:lblHeight];
    
    _txfHeight = [[UITextField alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-175.f, 370.f, 125.f, 20.f)];
    [_txfHeight setPlaceholder:@"请输入身高"];
    _txfHeight.textColor = [UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1];
    _txfHeight.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _txfHeight.keyboardType = UIKeyboardTypeNumberPad;
    [_txfHeight setTextAlignment:NSTextAlignmentRight];
    [viewContainer addSubview:_txfHeight];
    
    UILabel *lblHeightUnit = [[UILabel alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-35, 370, 30, 20)];
    lblHeightUnit.text = @"cm";
    [lblHeightUnit setTextColor:[UIColor grayColor]];
    [lblHeightUnit setFont:[UIFont fontWithName:@"ArialMT" size:15.f]];
    [lblHeightUnit setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:lblHeightUnit];
//    _btnHeight = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-150.f, 370.f, 125.f, 20.f)];
//    [_btnHeight setTitleColor:[UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1] forState:UIControlStateNormal];
//    [_btnHeight.titleLabel setFont:[UIFont fontWithName:@"Arial" size:15.f]];
//    [_btnHeight addTarget:self
//                   action:@selector(onBtnHeight)
//         forControlEvents:UIControlEventTouchUpInside];
//    [_btnHeight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [_btnHeight setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
//    [viewContainer addSubview:_btnHeight];

//    UIImageView *triangleHeight = [[UIImageView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-35, 376, 8, 8)];
//    [triangleHeight setImage:[UIImage imageNamed:@"Login_icon_Triangle"]];
//    [viewContainer addSubview:triangleHeight];
    
    UIView *viewLine4 = [[UIView alloc] initWithFrame:CGRectMake(35, 396,viewContainer.frame.size.width-70, 1)];
    [viewLine4 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [viewContainer addSubview:viewLine4];
    
    //weight
    UILabel *lblWeight = [[UILabel alloc] initWithFrame:CGRectMake(40, 410.f, 40, 20.f)];
    [lblWeight setText:@"体重"];
    [lblWeight setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
    [lblWeight setFont:[UIFont fontWithName:@"Arial" size:15.f]];
    [lblWeight setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:lblWeight];
    
    _txfWeight = [[UITextField alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-175.f, 410.f, 125.f, 20.f)];
    [_txfWeight setPlaceholder:@"请输入体重"];
    _txfWeight.textColor = [UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1];
    _txfWeight.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _txfWeight.keyboardType = UIKeyboardTypeNumberPad;
    [_txfWeight setTextAlignment:NSTextAlignmentRight];
    [viewContainer addSubview:_txfWeight];
    
    UILabel *lblWeightUnit = [[UILabel alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-35, 410, 30, 20)];
    lblWeightUnit.text = @"kg";
    [lblWeightUnit setTextColor:[UIColor grayColor]];
    [lblWeightUnit setFont:[UIFont fontWithName:@"ArialMT" size:15.f]];
    [lblWeightUnit setTextAlignment:NSTextAlignmentLeft];
    [viewContainer addSubview:lblWeightUnit];
    
//    _btnWeight = [[UIButton alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-150.f, 410.f, 125.f, 20.f)];
//    [_btnWeight setTitleColor:[UIColor colorWithRed:135.f/255.f green:175.f/255.f blue:242.f/255.f alpha:1] forState:UIControlStateNormal];
//    [_btnWeight.titleLabel setFont:[UIFont fontWithName:@"Arial" size:15.f]];
//    [_btnWeight addTarget:self
//                   action:@selector(onBtnWeight)
//         forControlEvents:UIControlEventTouchUpInside];
//    [_btnWeight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [_btnWeight setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
//    [viewContainer addSubview:_btnWeight];
//
//    UIImageView *triangleWeight = [[UIImageView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-35, 416, 8, 8)];
//    [triangleWeight setImage:[UIImage imageNamed:@"Login_icon_Triangle"]];
//    [viewContainer addSubview:triangleWeight];
    
    UIView *viewLine5 = [[UIView alloc] initWithFrame:CGRectMake(35, 436,viewContainer.frame.size.width-70, 1)];
    [viewLine5 setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
    [viewContainer addSubview:viewLine5];

    _pickerSex = [[UIPickerView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-110.f, 310.f, 110.f, 60.f)];
    _pickerSex.delegate = self;
    _pickerSex.dataSource = self;
    [_pickerSex setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_pickerSex];
    [_pickerSex setHidden:YES];
    
    _pickerBirth = [[UIPickerView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-160.f, 330.f, 160.f, 100.f)];
    _pickerBirth.delegate = self;
    _pickerBirth.dataSource = self;
    [_pickerBirth setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_pickerBirth];
    [_pickerBirth setHidden:YES];
    
    _pickerHeight = [[UIPickerView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-110.f, 366.f, 110.f, 100.f)];
    _pickerHeight.delegate = self;
    _pickerHeight.dataSource = self;
    [_pickerHeight setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_pickerHeight];
    [_pickerHeight setHidden:YES];
    
    _pickerWeight = [[UIPickerView alloc] initWithFrame:CGRectMake(viewContainer.frame.size.width-110.f, 406.f, 110.f, 100.f)];
    _pickerWeight.delegate = self;
    _pickerWeight.dataSource = self;
    [_pickerWeight setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_pickerWeight];
    [_pickerWeight setHidden:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_txfName resignFirstResponder];
    [_txfHeight resignFirstResponder];
    [_txfWeight resignFirstResponder];
    
    [_pickerSex setHidden:YES];
    [_pickerBirth setHidden:YES];
    [_pickerHeight setHidden:YES];
    [_pickerWeight setHidden:YES];
    
    if (_txfName.text.length>0 && _btnSex.titleLabel.text.length>0 && _btnBirth.titleLabel.text.length>0 && _txfHeight.text.length>0 && _txfWeight.text.length>0) {
        [_btnFinish setHidden:NO];
    }else{
        [_btnFinish setHidden:YES];
    }
}

#pragma mark - picker Delegate
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView == self.pickerBirth){
        return 3;
    }else{
        return 1;
    }
    
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.pickerSex) {
        return 2;
    }else if (pickerView == self.pickerBirth){
        if (component == 0) {
            return [_arrYear count];
        }else if (component ==1){
            return [_arrMonth count];
        }else{
            NSInteger numYear = [self.pickerBirth selectedRowInComponent:0];
            NSInteger numMonth = [self.pickerBirth selectedRowInComponent:1];
            if (((numYear%4 == 0)&&(numYear%100!=0))||(numYear%400==0)) {
                //闰年
                if ((numMonth == 0)||(numMonth == 2)||(numMonth == 4)||(numMonth == 6)||(numMonth == 7)||(numMonth == 9)||(numMonth == 11)) {
                    return 31;
                }else if(numMonth == 1){
                    return 29;
                }else{
                    return 30;
                }
            }else{
                if ((numMonth == 0)||(numMonth == 2)||(numMonth == 4)||(numMonth == 6)||(numMonth == 7)||(numMonth == 9)||(numMonth == 11)) {
                    return 31;
                }else if(numMonth == 1){
                    return 28;
                }else{
                    return 30;
                }
            }
        }
    }else if (pickerView == self.pickerHeight){
        return [_arrHeight count];
    }else if (pickerView == self.pickerWeight){
        return [_arrWidth count];
    }else{
        return 1;
    }
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.pickerSex) {
        [_btnSex setTitle:[_arrSex objectAtIndex:row] forState:UIControlStateNormal];
    }else if (pickerView == self.pickerBirth){
        if (component == 0) {
            _strYear = [_arrYear objectAtIndex:row];
        }else if(component == 1){
            _strMonth = [_arrMonth objectAtIndex:row];
        }else if (component == 2){
            _strDay = [_arrDay objectAtIndex:row];
        }
        [self.pickerBirth reloadComponent:2];
        [_btnBirth setTitle:[_strYear stringByAppendingFormat:@"年%@月%@日",_strMonth,_strDay] forState:UIControlStateNormal];
    }else if (pickerView == self.pickerHeight){
//        [_btnHeight setTitle:[_arrHeight objectAtIndex:row] forState:UIControlStateNormal];
    }else if (pickerView == self.pickerWeight){
//        [_btnWeight setTitle:[_arrWidth objectAtIndex:row] forState:UIControlStateNormal];
    }
}

////返回picker的组数
//-(NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
//}

//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 25.f;
}
// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (!view){
        view = [[UIView alloc]init];
    }
    if (pickerView == self.pickerSex) {
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.pickerSex.frame.size.width -15.f, 15)];
        text.textAlignment = NSTextAlignmentRight;
        [text setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
        [text setFont:[UIFont fontWithName:@"Arial" size:15.f]];
        text.text = [_arrSex objectAtIndex:row];
        [view addSubview:text];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.pickerSex.frame.size.width-30, 1)];
        [line setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
        [view addSubview:line];
        
        [self.pickerSex.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
        [self.pickerSex.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    }else if (pickerView == self.pickerBirth){
        if (component == 0) {
            UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,50, 15)];
            text.textAlignment = NSTextAlignmentCenter;
            [text setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
            [text setFont:[UIFont fontWithName:@"Arial" size:15.f]];
            text.text = [_arrYear objectAtIndex:row];
            [view addSubview:text];
            
            UIView *lineColumn = [[UIView alloc] initWithFrame:CGRectMake(51, 0, 1, 25)];
            [lineColumn setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
            [view addSubview:lineColumn];
        }else if (component == 1){
            UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,45, 15)];
            text.textAlignment = NSTextAlignmentCenter;
            [text setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
            [text setFont:[UIFont fontWithName:@"Arial" size:15.f]];
            text.text = [_arrMonth objectAtIndex:row];
            [view addSubview:text];
            
            UIView *lineColumn = [[UIView alloc] initWithFrame:CGRectMake(51, 0, 1, 25)];
            [lineColumn setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
            [view addSubview:lineColumn];
        }else{
            UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,45, 15)];
            text.textAlignment = NSTextAlignmentCenter;
            [text setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
            [text setFont:[UIFont fontWithName:@"Arial" size:15.f]];
            text.text = [_arrDay objectAtIndex:row];
            [view addSubview:text];
        }
        
        [self.pickerBirth.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
        [self.pickerBirth.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
        
    }else if (pickerView == self.pickerHeight){
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.pickerSex.frame.size.width -15.f, 15)];
        text.textAlignment = NSTextAlignmentRight;
        [text setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
        [text setFont:[UIFont fontWithName:@"Arial" size:15.f]];
        text.text = [_arrHeight objectAtIndex:row];
        [view addSubview:text];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.pickerSex.frame.size.width-30, 1)];
        [line setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
        [view addSubview:line];
        
        [self.pickerHeight.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
        [self.pickerHeight.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
        
    }else if (pickerView == self.pickerWeight){
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.pickerSex.frame.size.width -15.f, 15)];
        text.textAlignment = NSTextAlignmentRight;
        [text setTextColor:[UIColor colorWithRed:85.f/255.f green:85.f/255.f blue:85.f/255.f alpha:1]];
        [text setFont:[UIFont fontWithName:@"Arial" size:15.f]];
        text.text = [_arrWidth objectAtIndex:row];
        [view addSubview:text];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.pickerSex.frame.size.width-30, 1)];
        [line setBackgroundColor:[UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1]];
        [view addSubview:line];
        
        [self.pickerWeight.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
        [self.pickerWeight.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
        
    }
    return view;
    
}

#pragma mark - Btn Delegate
-(void)onBtnBack{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)onBtnFinish{
    [httpModel addUserWithName:_txfName.text
                        andSex:_btnSex.titleLabel.text
                   andBirthday:_btnBirth.titleLabel.text
                     andHeight:_txfHeight.text
                     andWeight:_txfWeight.text
                    Completion:^{
                        NSLog(@"成功");
                        
                        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
                    }
                         error:^(NSError *error,int num) {
                             if (num == 2 ) {
                                 self.alert = [[JCAlertLogin alloc] initWithTitle:@"" andDetailTitle:@"添加失败"];
                                 UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
                                 [rootWindow addSubview:self.alert];
                             }else{
                                 self.alert = [[JCAlertLogin alloc] initWithTitle:@"" andDetailTitle:@"请检查当前网络"];
                                 UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
                                 [rootWindow addSubview:self.alert];
                             }
                             
                         }];
}

-(void)onBtnHeadPic{
    self.alert = [[JCAlertLogin alloc] initWithThreeBtn];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.alert];
    
    [self.alert.btnAlbum addTarget:self
                            action:@selector(onAlertBtnAlbum)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.alert.btnCamera addTarget:self
                             action:@selector(onAlertBtnCamera)
                   forControlEvents:UIControlEventTouchUpInside];
}

-(void)onBtnSex{
    [_btnSex setTitle:@"男" forState:UIControlStateNormal];
    [_pickerSex setHidden:NO];
}
-(void)onBtnBirth{
    [_btnBirth setTitle:@"1930年1月1日" forState:UIControlStateNormal];
    [_pickerBirth setHidden:NO];
    
}
//-(void)onBtnHeight{
//    [_btnHeight setTitle:@"1" forState:UIControlStateNormal];
//    [_pickerHeight setHidden:NO];
//
//}
//-(void)onBtnWeight{
//    [_btnWeight setTitle:@"1" forState:UIControlStateNormal];
//    [_pickerWeight setHidden:NO];
//}

-(void)onAlertBtnAlbum{
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
    [self.alert removeFromSuperview];//close Alert
}
-(void)onAlertBtnCamera{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//图片来源
        _imagePicker.showsCameraControls = YES;//使用系统默认拍照按钮
        [self presentViewController:_imagePicker animated:YES completion:nil];
        
        [self.alert removeFromSuperview];//close Alert
    }else{
        NSLog(@"no spose camera");
    }
}

#pragma mark -实现图片选择器代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    [_btnHeadPic setBackgroundImage:image forState:UIControlStateNormal];  //给BtnHead赋值已经选择的相片
    
    _imgHead = image;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

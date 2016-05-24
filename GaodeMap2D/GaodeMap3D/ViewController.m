//
//  ViewController.m
//  GaodeMapDemo
//
//  Created by DIT on 16/5/22.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import "ViewController.h"
#import "RTMapView.h"
#import "FBContent.h"
#import "CFDB.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MBProgressHUD+NJ.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGTH    [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<CLLocationManagerDelegate,UITextFieldDelegate>
@property(strong,nonatomic)    CLLocationManager *theMangerLocation;//定位
@property (nonatomic,strong) UIView *weizhiView;
@property (nonatomic,strong)  RTMapView *rtmapView;
@property (nonatomic,strong) UILabel *gpsLabel;
@property (nonatomic,strong) UILabel *gaodeLabel;
@property (nonatomic,strong) UITextField *desTextFiled; //
@property (nonatomic,strong) UIButton *sendButton;
@property (nonatomic,strong) CFDB *manager;
@end




@implementation ViewController




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.rtmapView = [[RTMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.rtmapView];
    
    self.manager = [CFDB manager];
    
    
    BOOL isOpen = [self.manager openDB]; //打开数据库
    [self.manager createTable];
    
    [_rtmapView requestMapHostData];
    
    
    
    self.weizhiView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HIGTH - 100, SCREEN_WIDTH, 100)];
    self.weizhiView.backgroundColor = [UIColor redColor];
    self.weizhiView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.weizhiView];
    
    
    
    UIButton *theSelfLocationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    theSelfLocationBtn.frame=CGRectMake(5,60, 40, 40);
    [theSelfLocationBtn setImage:[UIImage imageNamed:@"iconfont-suodingweizhi"] forState:UIControlStateNormal];
    [self.weizhiView addSubview:theSelfLocationBtn];
    [theSelfLocationBtn addTarget:self action:@selector(mapLocation) forControlEvents:UIControlEventTouchUpInside];
    
    self.gpsLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 20)];
    self.gpsLabel.textAlignment = NSTextAlignmentCenter;
    
    //    self.gpsLabel.font = [UIFont systemFontOfSize:20];
    
    self.gaodeLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 20)];
    //    self.gaodeLabel.font = [UIFont systemFontOfSize:20];
    self.gaodeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.weizhiView addSubview:self.gpsLabel];
    [self.weizhiView addSubview:self.gaodeLabel];
    
    
    
    
    self.desTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(60, 60, SCREEN_WIDTH - 120, 40)];
    //self.desTextFiled.backgroundColor = [UIColor cyanColor];
    
    
    self.desTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.desTextFiled.placeholder = @"描述";
    self.desTextFiled.delegate = self;
    self.desTextFiled.clearButtonMode =UITextFieldViewModeWhileEditing;
    
    
    
    [self.weizhiView addSubview:self.desTextFiled];
    
    
    
    // self.sendButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 60, 40, 40)];
    self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sendButton.frame = CGRectMake(SCREEN_WIDTH - 50, 60, 40, 38);
    [self.sendButton setTitle:@"保存" forState:UIControlStateNormal];
    self.sendButton.backgroundColor = [UIColor whiteColor];
    [self.sendButton addTarget:self action:@selector(didClickSendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.weizhiView addSubview:self.sendButton];
    
    self.gpsLabel.text = [NSString stringWithFormat:@"GPS lon: %f lat: %f",[FBContent shartContent].coord2D.longitude,[FBContent shartContent].coord2D.latitude];
    self.gaodeLabel.text = [NSString stringWithFormat:@"高德 lon: %f lat: %f",self.rtmapView.mapView.userLocation.coordinate.longitude,self.rtmapView.mapView.userLocation.coordinate.latitude];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChnageFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //    [FBContent shartContent].coord2D = coordinate;
    //    //  //  NSLog(<#NSString * _Nonnull format, ...#>)
    //    // NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",[FBContent shartContent].coord2D.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //    //如果不需要实时定位，使用完即使关闭定位服务
    
    
    
    //    [self.weizhiView bringSubviewToFront:self.view];
    
    // Do any additional setup after loading the view, typically from a nib.
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.desTextFiled resignFirstResponder];
//   // [self.textSummary resignFirstResponder];
//}


//键盘的位置或大小发生变化
-(void)keyboardWillChnageFrame:(NSNotification *)sender{
    
    CGFloat duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect frame = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat offsetY = frame.origin.y - self.view.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [self.desTextFiled  resignFirstResponder];
    [self saveLocation];
    
    return YES;
}




-(void)mapLocation{
    [self.rtmapView mapLocation];
    self.gpsLabel.text = [NSString stringWithFormat:@"GPS lon: %f lat: %f",[FBContent shartContent].coord2D.longitude,[FBContent shartContent].coord2D.latitude];
    self.gaodeLabel.text = [NSString stringWithFormat:@"高德 lon: %f lat: %f",self.rtmapView.mapView.userLocation.coordinate.longitude,self.rtmapView.mapView.userLocation.coordinate.latitude];
}
-(void)didClickSendButtonAction:(UIButton *)button{
    [self.desTextFiled resignFirstResponder];
    [self saveLocation];
}




-(void)saveLocation{
    
    
//    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    progressHUD.color = [UIColor colorWithRed:0/255.0 green:187/255.0 blue:156/255.0 alpha:0.8];
    
    
    
   [MBProgressHUD showMessage:@"正在保存中....."];
    

    
    NSString * gpsLongitude =[NSString stringWithFormat:@"%f",[FBContent shartContent].coord2D.longitude];
    NSString *gpsLatitude =[NSString stringWithFormat:@"%f",[FBContent shartContent].coord2D.latitude];
    NSString *gaodeLongitude = [NSString stringWithFormat:@"%f",self.rtmapView.mapView.userLocation.coordinate.longitude];//
    NSString *gaodeLatitude =  [NSString stringWithFormat:@"%f",self.rtmapView.mapView.userLocation.coordinate.latitude];//
    NSString *mapDescription = self.desTextFiled.text;
    
    
    [self.manager insertDataWithGpsLongitude:gpsLongitude GpsLatitude:gpsLatitude GaodeLongitude:gaodeLongitude GaodeLatitude:gaodeLatitude MapDescription:mapDescription results:^{
        
        
        
    } ailure:^{
        
        
        
    }];
    
        AVObject *todo = [AVObject objectWithClassName:@"mapLocation"];
        [todo setObject:gpsLongitude forKey:@"gpsLongitude"];
        [todo setObject:gpsLatitude forKey:@"gpsLatitude"];
    
        [todo setObject:gaodeLongitude forKey:@"gaodeLongitude"];
        [todo setObject:gaodeLatitude forKey:@"gaodeLatitude"];
        [todo setObject:self.desTextFiled.text forKey:@"description"];
    
        [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // 存储成功
                
                [MBProgressHUD hideHUD];
                
                UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
               //[MBProgressHUD showMessage:@"添加成功....."];
                
             //   [MBProgressHUD hideHUD];
                
            } else {
                // 失败的话，请检查网络环境以及 SDK 配置是否正确
                
                
                [MBProgressHUD hideHUD];
              //  [MBProgressHUD showError:@"添加失败....."];
                UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"保存失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
              //  [MBProgressHUD hideHUD];
                
            }
        }];
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [MBProgressHUD hideHUD];
//    });
    
    
    
    
    
    
    
    
    
    
    
    
}



-(void)viewWillDisappear:(BOOL)animated{


    [self.manager closeDB];
}







//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//
//    CLLocation *location = [locations firstObject]; //取出第一位置
//    CLLocationCoordinate2D coordinate = location.coordinate;//位置坐标
//    [FBContent shartContent].coord2D = coordinate;
//
//
//
//
//    //  //  NSLog(<#NSString * _Nonnull format, ...#>)
//    //    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",[FBContent shartContent].coord2D.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
//    //如果不需要实时定位，使用完即使关闭定位服务
//
//
//}

//创建定位点的样式
//-(void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
//
//
//    MAAnnotationView *view = views[0];
//    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
//    if ([view.annotation isKindOfClass:[MAUserLocation class]])
//    {
//        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
//        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
//        pre.image = [UIImage imageNamed:@"jian"];
//        pre.lineWidth = 3;
//        pre.lineDashPattern = @[@6, @3];
//
//        [_mapView updateUserLocationRepresentation:pre];
//
//        view.calloutOffset = CGPointMake(0, 0);
//    }
//
//
//
//
//}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

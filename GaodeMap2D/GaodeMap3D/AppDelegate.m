//
//  AppDelegate.m
//  GaodeMapDemo
//
//  Created by DIT on 16/5/22.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import "AppDelegate.h"

#import <MAMapKit/MAMapKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "FBContent.h"
#import <AVOSCloud/AVOSCloud.h>
//#import "AVOSCloud/AVOSCloud.h"
@interface AppDelegate ()<CLLocationManagerDelegate>

//@property (nonatomic,strong) CLLocationManager *locationManager;
@property(strong,nonatomic)    CLLocationManager *theMangerLocation;//定位
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //如果使用美国站点，请加上这行代码 [AVOSCloud setServiceRegion:AVServiceRegionUS];
        [AVOSCloud setApplicationId:@"LxOHADXiKLeoyQSb5VmByCRh-gzGzoHsz"
                          clientKey:@"NJLaSl54fjRt7E4l24QS4bPL"];
        [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
        [testObject setObject:@"bar" forKey:@"foo"];
        [testObject save];
    
    
    
    
    [MAMapServices sharedServices].apiKey = @"d003b556bb2015c0d55c465eae24a073";
   // [AMapSearchServices sharedServices].apiKey = @"d003b556bb2015c0d55c465eae24a073";

    //self.locationManager = [[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"定位服务当前可能尚未打开，请社会打开");
    }
    
    
    self.theMangerLocation=[[CLLocationManager alloc]init];
    self.theMangerLocation.delegate=self;
    self.theMangerLocation.desiredAccuracy=kCLLocationAccuracyBest;
    //theMangerLocation.distanceFilter=10;
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [self.theMangerLocation requestWhenInUseAuthorization];
        [self.theMangerLocation requestAlwaysAuthorization];
        
    }
    
    self.theMangerLocation.pausesLocationUpdatesAutomatically = NO;
    // [self.theMangerLocation startUpdatingHeading];
    [self.theMangerLocation startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = self.theMangerLocation.location.coordinate;//位置坐标
    [FBContent shartContent].coord2D = coordinate;
    
    
    
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations firstObject]; //取出第一位置
    CLLocationCoordinate2D coordinate = location.coordinate;//位置坐标
    [FBContent shartContent].coord2D = coordinate;
    //  //  NSLog(<#NSString * _Nonnull format, ...#>)
    // NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",[FBContent shartContent].coord2D.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    
    
}












- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

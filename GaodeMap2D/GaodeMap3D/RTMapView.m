//
//  RTMapView.m
//  GaodeMapDemo
//
//  Created by DIT on 16/5/22.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import "RTMapView.h"
#import "FBBaiduMapItems.h"
#import "FBContent.h"

enum{
    OverlayViewControllerOverlayTypeCircle = 0,
    OverlayViewControllerOverlayTypePolygon,
    OverlayViewControllerOverlayTypePolyline,
    OverlayViewControllerOverlayTypeColoredPolyline,
    OverlayViewControllerOverlayTypeGradientPolyline
};
@interface RTMapView ()
@property (nonatomic,strong) NSMutableArray *thePointArr;
@property (nonatomic,strong) NSMutableArray *thepilygon;
@property (nonatomic,strong) UILabel *gpsLabel;
@property (nonatomic,strong) UILabel *gaodeLabel;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@property (nonatomic, strong) NSMutableArray *overlays;
@property(assign,nonatomic)CLLocationCoordinate2D cenCooder;

@end
@implementation RTMapView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self createMapView];
    }
    return self;
}
#pragma mark 经纬度转化
-(CLLocationCoordinate2D)gaodeLocationFromGPS:(CLLocationCoordinate2D )gpsLocation
{
    return MACoordinateConvert(gpsLocation, MACoordinateTypeGPS);
}


-(void)createMapView{
    
    
    
    
    self.mapView = [[MAMapView alloc]initWithFrame:self.bounds];
    self.mapView.delegate = self;
    [self addSubview:self.mapView];
    
    
    //    self.gpsLabel = [UILabel alloc]in;
    
    
    
    
    
    //    self.mapView.showsUserLocation = YES; //yes为打开定位，NO为关闭定位
    self.cenCooder=[self gaodeLocationFromGPS:[FBContent shartContent].coord2D];
    
    
    
    [self mapLocation];
    
    //    [_mapView setUserTrackingMode: MAUserTrackingModeFollowWithHeading animated:YES]; //地图跟着位置移动
    
    
    //    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    //    [self.mapView setZoomLevel:16.1 animated:YES]; //设置地图的缩放级别
    //
    
    
    
    self.mapView.pausesLocationUpdatesAutomatically = NO;
    self.mapView.allowsBackgroundLocationUpdates = YES;
    
    
    
    
    //   添加大头针
    //    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    //    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    //    pointAnnotation.title = @"方恒国际";
    //    pointAnnotation.subtitle = @"阜通东大街6号";
    //
    //    [_mapView addAnnotation:pointAnnotation];
    //
    
    
    
    
    
    
    
    
    _mapView.showsScale = NO; //设置成NO表示不显示比例尺，YES表示显示
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22); //设置比例尺的位置
    
    
    
    
    
    
    //     _mapView.zoomEnabled = YES;    //NO表示禁用缩放手势，YES表示开启
    
    
    //   [_mapView setCenterCoordinate:self.center animated:YES]; //地图平移时，缩放级别不变，可通过改变地图的中心点来移动地图
    
    
}


#pragma mark 经纬度转化


-(void)mapLocation{
    
    
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading; //
    [_mapView setZoomEnabled:YES];
    [_mapView setZoomLevel:18 animated:YES];
    //  _mapView.userLocation
    
    //    float zoomLevel = 0.001;
    //    MACoordinateRegion region = MACoordinateRegionMake(self.cenCooder, MACoordinateSpanMake(zoomLevel, zoomLevel));
    //    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    //    self.mapView.showsUserLocation=YES;
    
}








-(void)requestMapHostData{
    
    
    
    
    self.thepilygon = [[NSMutableArray alloc]init];
    self.thePointArr = [[NSMutableArray alloc]init];
    [FBBaiduMapItems getNearbyMapViewLong:[NSString stringWithFormat:@"%f",[FBContent shartContent].coord2D.longitude] andLatitu:[NSString stringWithFormat:@"%f",[FBContent shartContent].coord2D.latitude] andSuccess:^(NSDictionary *resultDict) {
        ;
        
        //  NSLog(@"================%@",resultDict);
        [_thePointArr removeAllObjects];
        
        [[FBContent shartContent].theNearLocation removeAllObjects];
        
        [self.mapView removeOverlays:self.mapView.overlays];
        
        [self addPointAnnotation:resultDict[@"location"]];
        //        [_thePointArr addObjectsFromArray:resultDict[@"location"]];
        [[FBContent shartContent].theNearLocation addObjectsFromArray:resultDict[@"location"]];
        
        [self addOverlayViews:resultDict[@"location"]];
        
    } andFail:^(NSString *errStr) {
        
        ;
    }];
    
    
}


//添加内置覆盖物
- (void)addOverlayViews:(NSMutableArray *)locations{
    
    
    [self.mapView removeOverlays:self.thepilygon];
    [self.thepilygon removeAllObjects];
    
    
    CLLocationCoordinate2D theCoordinate;
    
    for(FBBaiduMapItems *baiduMapItem in locations)
    {
        CLLocationCoordinate2D coords[4] = {0};
        theCoordinate=[self gaodeLocationFromGPS:CLLocationCoordinate2DMake([baiduMapItem.theMapLng0 doubleValue], [baiduMapItem.theMapLa0 doubleValue])];
        
        coords[0].latitude = theCoordinate.latitude;//[locations.theMapLa0 doubleValue];
        coords[0].longitude =theCoordinate.longitude;// [locations.theMapLng0 doubleValue];
        
        theCoordinate=[self gaodeLocationFromGPS:CLLocationCoordinate2DMake([baiduMapItem.theMapLng1 doubleValue], [baiduMapItem.theMapLa0 doubleValue])];
        coords[1].latitude = theCoordinate.latitude;//[locations.theMapLa0 doubleValue];
        coords[1].longitude = theCoordinate.longitude;//[locations.theMapLng1 doubleValue];
        
        theCoordinate=[self gaodeLocationFromGPS:CLLocationCoordinate2DMake([baiduMapItem.theMapLng1 doubleValue], [baiduMapItem.theMapLa1 doubleValue])];
        coords[2].latitude =theCoordinate.latitude;// [locations.theMapLa1 doubleValue];
        coords[2].longitude =theCoordinate.longitude;// [locations.theMapLng1 doubleValue];
        
        
        theCoordinate=[self gaodeLocationFromGPS:CLLocationCoordinate2DMake([baiduMapItem.theMapLng0 doubleValue], [baiduMapItem.theMapLa1 doubleValue])];
        coords[3].latitude = theCoordinate.latitude;//[locations.theMapLa1 doubleValue];
        coords[3].longitude =theCoordinate.longitude;// [locations.theMapLng0 doubleValue];
        
        MAPolygon  *polygon1 = [MAPolygon polygonWithCoordinates:coords count:4];
        //polygon = [MAPolygon polygonWithCoordinates:coords count:4];
        
        [self.thepilygon addObject:polygon1];
        
        
        
    }
    [self.mapView addOverlays:self.thepilygon];
}


- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonView *polygonView = [[MAPolygonView alloc] initWithPolygon:overlay];
        
        polygonView.lineWidth = 5.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        polygonView.fillColor = [UIColor colorWithRed:0.77 green:0.88 blue:0.94 alpha:0.8];
        
        return polygonView;
    }
    return nil;
}



//当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标


-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
}




//    定位图层由定位点处的标注（MAUserLocation）和精度圈（MACircle）组成。

//自定义定位图层
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        //  pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3]; //精度圈填充颜色
        //   pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0]; //精度圈边线颜色
        pre.image = [UIImage imageNamed:@"userPosition"]; //标注图片。若设置为nil，则为默认图片。
        //   pre.lineWidth = 3; //精度圈边线宽度,默认是2
        //  pre.lineDashPattern = @[@6, @3]; //边线虚线样式, 默认是nil
        pre.showsAccuracyRing = NO; //是否显示精度圈。默认为YES
        pre.showsHeadingIndicator = YES;//是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
        [self.mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }
}


//添加标注
- (void)addPointAnnotation:(NSArray *)potions
{
    
    //  NSLog(@"=================%@",potions);
    
    NSMutableArray *theT=[NSMutableArray array];
    for (FBBaiduMapItems *baiduItem in potions) {
        MAPointAnnotation *point=[[MAPointAnnotation alloc]init];
        
        point.coordinate = [self gaodeLocationFromGPS:CLLocationCoordinate2DMake([baiduItem.theLatitude doubleValue], [baiduItem.theLongitude doubleValue])];
        point.title = baiduItem.theMapName;
        [theT addObject:point];
    }
    [self.mapView addAnnotations:theT];
    
}
//添加大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        //系统默认的大头针
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        // annotationView.pinColor = MAPinAnnotationColorGreen;
        return annotationView;
    }
    return nil;
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

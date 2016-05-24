//
//  RTMapView.h
//  GaodeMapDemo
//
//  Created by DIT on 16/5/22.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
@interface RTMapView : UIView <MAMapViewDelegate>



@property (nonatomic,strong)    MAMapView *mapView;
@property(assign,nonatomic)CLLocationCoordinate2D coord2D;


-(void)requestMapHostData;



-(void)mapLocation;
@end

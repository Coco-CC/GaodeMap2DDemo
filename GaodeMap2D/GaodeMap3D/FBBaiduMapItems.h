//
//  FBBaiduMapItems.h
//  FBSelfMusicLocation
//
//  Created by fengbing on 15/8/15.
//  Copyright (c) 2015年 Fengbing. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface FBBaiduMapItems : NSObject

@property(strong,nonatomic)NSString *theMapID;
@property(strong,nonatomic)NSString *theMapName;
@property(strong,nonatomic)NSString *theCoordinate;
@property(strong,nonatomic)NSString *theDegree;
@property(strong,nonatomic)NSString *theLongitude;
@property(strong,nonatomic)NSString *theLatitude;
@property(strong,nonatomic)NSString *theOverlayDegree;


@property(strong,nonatomic)NSString *theID;
@property(strong,nonatomic)NSString *theMapLng0;
@property(strong,nonatomic)NSString *theMapLa0;
@property(strong,nonatomic)NSString *theMapLng1;
@property(strong,nonatomic)NSString *theMapLa1;

-(instancetype)initWithDictData:(NSDictionary *)dict;



/**
 app需要不断的向服务器发送用户位置信息，服务器返回当前位置的四个坐标。如果用户切换热点，服务器可能返回优先级高的内容。
 */
+(void)getUserLocationSubID:(NSString *)subID andSubType:(NSString *)subType andLocation:(NSString *)currentAdd andlag:(NSString *)lagStr andLon:(NSString *)lngStr andSuccess:(void(^)(FBBaiduMapItems *resultDict))success andFail:(void(^)(NSString *errStr))fail;

/**
 4.	热点的热门图片
 */
+(void)getAddressImagesID:(NSString *)addID andPage:(NSInteger)page andSuccess:(void(^)(NSArray *reslutArr,BOOL isNext))success andFail:(void(^)(NSString *errStr))fail;

/**
 标注
 */
+(void)getNearbyMapViewLong:(NSString *)lngStr andLatitu:(NSString *)latStr andSuccess:(void(^)(NSDictionary *resultDict))success andFail:(void(^)(NSString *errStr))fail;


/**
 根据用户指定的两个坐标点，计算这两个点的实际地理距离
 */
//
//-(CLLocationDistance)discoordinateTo:(CLLocationCoordinate2D)tolocate andcoordinateFr:(CLLocationCoordinate2D)frlocate;


@end

//
//  FBBaiduMapItems.m
//  FBSelfMusicLocation
//
//  Created by fengbing on 15/8/15.
//  Copyright (c) 2015年 Fengbing. All rights reserved.
//

#import "FBBaiduMapItems.h"
#import "URL.h"
#import "CFRNetWorkingTool.h"
@implementation FBBaiduMapItems
-(instancetype)initWithDictData:(NSDictionary *)dict
{
    if(self=[super init])
    {
        //        self.theMapID=kSetValue(dict, @"id");
        //        self.theID=kSetValue(dict, @"addressId");
        //        self.theMapLa0=kSetValue(dict, @"x1");
        //        self.theMapLa1=kSetValue(dict, @"x2");
        //
        //        self.theMapLng0=kSetValue(dict, @"y1");
        //        self.theMapLng1=kSetValue(dict, @"y2");
        //
        //        self.theMapName=kSetValue(dict, @"name");
        
        //        @property(strong,nonatomic)NSString *theMapID;
        //        @property(strong,nonatomic)NSString *theMapName;
        //        @property(strong,nonatomic)NSString *theCoordinate;
        //        @property(strong,nonatomic)NSString *theDegree;
        //        @property(strong,nonatomic)NSString *theLongitude;
        //        @property(strong,nonatomic)NSString *theLatitude;
        //
        //
        //        @property(strong,nonatomic)NSString *theID;
        //        @property(strong,nonatomic)NSString *theMapLng0;
        //        @property(strong,nonatomic)NSString *theMapLa0;
        //        @property(strong,nonatomic)NSString *theMapLng1;
        //        @property(strong,nonatomic)NSString *theMapLa1;
        
        
        self.theMapID = kSetValue(dict, @"id");
        self.theMapName = kSetValue(dict, @"name");
        self.theCoordinate = kSetValue(dict, @"coordinate");
        self.theDegree = kSetValue(dict, @"degree");
        self.theLongitude = kSetValue(dict, @"longitude");
        self.theLatitude = kSetValue(dict, @"latitude");
        self.theOverlayDegree = kSetValue(dict, @"overlayDegree");
        NSArray *mapArray = [dict objectForKey:@"locationList"];
        self.theID = kSetValue([mapArray lastObject], @"id");
        self.theMapLa0 =kSetValue([mapArray lastObject], @"x1");
        self.theMapLa1 =kSetValue([mapArray lastObject], @"x2");
        self.theMapLng0 = kSetValue([mapArray lastObject], @"y1");
        self.theMapLng1 = kSetValue([mapArray lastObject], @"y2");
        //kSetValue(dict, @"locationList");
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    return self;
}
/**
 app需要不断的向服务器发送用户位置信息，服务器返回当前位置的四个坐标。如果用户切换热点，服务器可能返回优先级高的内容。
 */
+(void)getUserLocationSubID:(NSString *)subID andSubType:(NSString *)subType andLocation:(NSString *)currentAdd andlag:(NSString *)lagStr andLon:(NSString *)lngStr andSuccess:(void(^)(FBBaiduMapItems *resultDict))success andFail:(void(^)(NSString *errStr))fail
{
    if(subID&&subType&&lagStr&&lngStr)
    {
        NSDictionary *params=@{@"subjectId":subID,@"subjectType":subType,@"latitude":lagStr,@"longitude":lngStr,@"currentAddressId":currentAdd,@"coordinate":@"1"};
        
        
        [[CFRNetWorkingTool cfrNetWorkingManager]postDataSourceWithURLString:@"appapi/addresses/user/loc" parameters:params result:^(id json) {
            if([json isKindOfClass:[NSDictionary class]])
            {
                if([kSetValue(json[kMETA], kCODEVAR) isEqual:kCODESUCCESS])
                {
                    
                    if([json[kDATA] isKindOfClass:[NSArray class]])
                    {
                        
                        if([json[kDATA] count]>0)
                        {
                            
                            FBBaiduMapItems *baiduM=[[FBBaiduMapItems alloc]initWithDictData:json[kDATA][0] ];
                            
                            success(baiduM);
                        }
                    }else
                    {
                        fail(@" 暂无热点 ");
                    }
                    
                }else
                {
                    fail(kSetValue(json[kMETA], kMESSAGE));
                    
                }
            }
            
            ;
        } failure:^(id failData) {
            DLog(@"用户位置==%@",errStr);
            fail(kNOWORK);
        } fractionCompleted:^(id progress) {
            
        }];
        
    }
}

/**
 4.	热点的热门图片
 */
+(void)getAddressImagesID:(NSString *)addID andPage:(NSInteger)page andSuccess:(void(^)(NSArray *reslutArr,BOOL isNext))success andFail:(void(^)(NSString *errStr))fail
{
    
}


/**
 标注
 */
+(void)getNearbyMapViewLong:(NSString *)lngStr andLatitu:(NSString *)latStr andSuccess:(void(^)(NSDictionary *resultDict))success andFail:(void(^)(NSString *errStr))fail
{
    NSDictionary *theDict=@{@"longitude":lngStr,@"latitude":latStr,@"coordinate":@"1",@"radius":@"1000"};
    
    
    
    //    NSLog(@"-=------===== %@",theDict);
    [[CFRNetWorkingTool cfrNetWorkingManager]postDataSourceWithURLString:@"http://123.57.230.238:8080/appapi/lbs/nearby/addr"  parameters:theDict result:^(id json) {
        if([json isKindOfClass:[NSDictionary class]])
        {
            
            //            NSLog(@"--------------%@",json);
            
            
            
            if([kSetValue(json[kMETA], kCODEVAR) isEqual:kCODESUCCESS])
            {
                
                
                
                
                
                if([json[kDATA] isKindOfClass:[NSDictionary class]])
                {
                    
                    
                    
                    NSMutableArray *theLocation=[NSMutableArray array];
                    
                    
                    for(NSDictionary *theDict in json[kDATA][@"addrInfoList"])
                    {
                        
                        FBBaiduMapItems *baiduM=[[FBBaiduMapItems alloc]initWithDictData:theDict];
                        
                        [theLocation addObject:baiduM];
                        
                        
                    }
                    //addrLocList
                    
                    //  NSLog(@"---info = %@ location = %@, ",resJson[kDATA][@"addrInfoList"],theLocation);
                    
                    
                    success(@{@"info":json[kDATA][@"addrInfoList"],@"location":theLocation});
                    
                    //success(resJson[kDATA][@"addrInfoList"]);
                    
                }else
                {
                    fail(@" 暂无附近的热点 ");
                }
                
            }else
            {
                fail(kSetValue(json[kMETA], kMESSAGE));
                
            }
        }
        
        
        ;
        
    } failure:^(id failData) {
        fail(kNOWORK);
        
    } fractionCompleted:^(id progress) {
        
    }];
    
    
    
    
    
}
/**
 根据用户指定的两个坐标点，计算这两个点的实际地理距离
 */

//-(CLLocationDistance)discoordinateTo:(CLLocationCoordinate2D)tolocate andcoordinateFr:(CLLocationCoordinate2D)frlocate
//{
//
//
//     BMKMapPoint point1 = BMKMapPointForCoordinate(tolocate);
//     BMKMapPoint point2 = BMKMapPointForCoordinate(frlocate);
//    
//    
//
//     CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
//    return distance;
//    
//    
//}
@end

//
//  FBContent.h
//  GaodeMapDemo
//
//  Created by DIT on 16/5/23.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface FBContent : NSObject

/**
 *  GPS 经纬度
 */
@property(assign,nonatomic)CLLocationCoordinate2D coord2D;

@property (nonatomic,strong) NSMutableArray *theNearLocation;
+(FBContent *)shartContent;


@end

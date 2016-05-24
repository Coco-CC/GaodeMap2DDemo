//
//  CFDB.h
//  GaodeMap3D
//
//  Created by DIT on 16/5/23.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFDB : NSObject


+(instancetype)manager;
//打开。关闭数据库
-(BOOL)openDB;
-(void)closeDB;
//创建表
-(void)createTable;




-(void)insertDataWithGpsLongitude:(NSString *)gpsLongitude GpsLatitude:(NSString *)gpsLatitude GaodeLongitude:(NSString *)gaodeLongitude GaodeLatitude:(NSString *)gaodeLatitude MapDescription:(NSString *)mapDescription  results:(void(^)())results  ailure:(void(^)())failure;

@end

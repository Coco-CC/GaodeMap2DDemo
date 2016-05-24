//
//  CFRNetWorkingTool.h
//  AFNetWorkingDemo
//
//  Created by DIT on 16/5/13.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



typedef enum {
    statusUnknown          = -1, // 未知网络
    statusNotReachable     = 0, //没有网络
    statusReachableViaWWAN = 1, //手机网络
    statusReachableViaWiFi = 2, //wifi
}Reachability;


@interface CFRNetWorkingTool : NSObject


@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;



+(CFRNetWorkingTool *)cfrNetWorkingManager;


/**
 *  get 方式请求数据
 *
 *  @param urlString 请求连接
 *  @param params       数据体
 *  @param result    请求成功返回值
 *  @param failure   请求失败返回值
 */
-(void)getDataSourceWithURLString:(NSString *)urlString;


/**
 *  post方式请求方式
 *
 *  @param urlString 请求连接
 *  @param para      参数
 *  @param result    请求成功返回值
 *  @param failure   请求失败返回值
 */
-(void)postDataSourceWithURLString:(NSString *)urlString
                        parameters:(NSDictionary *)para
                            result:(void(^)(id json))result
                           failure:(void(^)(id failData))failure
fractionCompleted:(void(^)(id progress))fractionCompleted;



/**
 *  上传文件
 *
 *  @param urlString 上传地址
 *  @param paraDict  参数
 *  @param data      上传数据
 *  @param dataName  上传数据名称
 * @param fileName  文件路径
 *  @param result    上传成功调用
 *  @param failure   上传失败调用
  *  @param fractionCompleted 进度
 */
-(void)uploadDataWithString:(NSString *)urlString
                 parameters:(NSDictionary *)paraDict
                 uploadData:(NSData *) data
                   dataName:(NSString *)dataName
                   fileName:(NSString *)fileName
                     result:(void(^)(id json))result
                    failure:(void(^)(id failData))failure
fractionCompleted:(void(^)(id progress))fractionCompleted;


/**
 *  下载文件
 *
 *  @param urlString 下载的连接
 *  @param  saveFile 保存的路径
 *  @param para      参数
 *  @param result    下载成功返回的数据
 *  @param failure   下载失败返回的数据
  *  @param fractionCompleted 进度
 */
-(void)downloadFileWithURLString:(NSString *)urlString
                 downDescription:(NSString *)description
                  saveFileString:(NSString *)saveFile
                      parameters:(NSDictionary *)para
                          result:(void(^)(id json))result
                         failure:(void(^)(id failData))failure
fractionCompleted:(void(^)(id progress))fractionCompleted;


/**
 *  暂停下载
 */
-(void)downLoadTaskSuspendWithDescription:(NSString *)downDescription;

/**
 *  获取用户的网络状态
 *
 *  @param state 返回值当前状态
 */
-(void)netWorkReachability:(void (^)(NSInteger reastate))reastate;


@end

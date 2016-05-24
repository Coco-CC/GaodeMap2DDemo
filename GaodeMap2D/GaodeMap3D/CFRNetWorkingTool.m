//
//  CFRNetWorkingTool.m
//  AFNetWorkingDemo
//
//  Created by DIT on 16/5/13.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import "CFRNetWorkingTool.h"
#define BaseUrl [NSURL URLWithString:@""]


@interface CFRNetWorkingTool ()

@property (nonatomic,strong)  NSMutableDictionary *downloadTaskDict;

@end


@implementation CFRNetWorkingTool



static CFRNetWorkingTool *s_cfrNetWorkingManager = nil;
+(CFRNetWorkingTool *)cfrNetWorkingManager{
    
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        s_cfrNetWorkingManager = [[self alloc]init];
        
    });
    return s_cfrNetWorkingManager;
}


-(NSMutableDictionary *)downloadTaskDict{
    
    if (!_downloadTaskDict) {
        
        _downloadTaskDict = [[NSMutableDictionary alloc]init];
    }
    return _downloadTaskDict;



}
/**
 *  get 方式请求数据
 *
 *  @param urlString 请求连接
 *  @param result    请求成功返回值
 *  @param failure   请求失败返回值
 */
-(void)getDataSourceWithURLString:(NSString *)urlString
                           params:(id )params
                           result:(void(^)(id json))result
                          failure:(void(^)(id failData))failure
fractionCompleted:(void(^)(id progress))fractionCompleted{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 20;
    NSString *fileString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    session.responseSerializer.acceptableContentTypes=[NSSet setWithArray:@[@"application/json;charset=UTF-8",@"application/json",@"text/javascript",@"text/json",@"text/plain;charset=UTF-8",@"text/html;charset=utf-8",@"text/plain"]];
    

    
    [session GET:fileString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        if (fractionCompleted) {
            fractionCompleted(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (result) {
            result(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        if (failure) {
            failure(error);
        }
        
    }];
}

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
      fractionCompleted:(void(^)(id progress))fractionCompleted{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes=[NSSet setWithArray:@[@"application/json;charset=UTF-8",@"application/json",@"text/javascript",@"text/json",@"text/plain;charset=UTF-8",@"text/html;charset=utf-8",@"text/plain"]];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 20;
    NSString *fileString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    
    [session POST:fileString parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (fractionCompleted) {
             fractionCompleted(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (result) {
            result(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  上传文件
 *
 *  @param urlString 上传地址
 *  @param paraDict  参数
 *  @param data      上传数据
 *  @param dataName  上传数据名称
 *  @param result    上传成功调用
 *  @param failure   上传失败调用
 */
-(void)uploadDataWithString:(NSString *)urlString
                 parameters:(NSDictionary *)paraDict
                 uploadData:(NSData *) data
                   dataName:(NSString *)dataName
                   fileName:(NSString *)fileName
                     result:(void(^)(id json))result
                    failure:(void(^)(id failData))failure
          fractionCompleted:(void(^)(id progress))fractionCompleted{


    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes=[NSSet setWithArray:@[@"application/json;charset=UTF-8",@"application/json",@"text/javascript",@"text/json",@"text/plain;charset=UTF-8",@"text/html;charset=utf-8",@"text/plain"]];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 20;
    NSString *fileString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [session POST:fileString parameters:paraDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFormData:data name:dataName];
      //  [formData appendPartWithFileData:<#(nonnull NSData *)#> name:<#(nonnull NSString *)#> fileName:<#(nonnull NSString *)#> mimeType:<#(nonnull NSString *)#>];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
       // NSLog(@"----------------------上传中");
        
        if (fractionCompleted) {
            fractionCompleted(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (result) {
            result(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            failure(error);
        }
        
        
    }];
}


/**
 *  下载文件
 *
 *  @param urlString 下载的连接
 *  @param  saveFile 保存的路径
 *  @param para      参数
 *  @param result    下载成功返回的数据
 *  @param failure   下载失败返回的数据
 */
-(void)downloadFileWithURLString:(NSString *)urlString
                 downDescription:(NSString *)downDescription
                  saveFileString:(NSString *)saveFile
                      parameters:(NSDictionary *)para
                          result:(void(^)(id json))result
                         failure:(void(^)(id failData))failure
               fractionCompleted:(void(^)(id progress))fractionCompleted{
    
    NSURLSessionDownloadTask *downloadTask;
    
    if ([self.downloadTaskDict objectForKey:downDescription]) {
        downloadTask = [self.downloadTaskDict objectForKey:downDescription];
      //  [downloadTask suspend];
        
    }else{
    
    NSURLSessionConfiguration *configguration = [NSURLSessionConfiguration defaultSessionConfiguration];
   
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configguration];
    NSString *fileString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *fileURL = [NSURL URLWithString:fileString];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
    
    downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
        NSString *jjj = [NSString stringWithFormat:@"下载进度：%.2f%%", downloadProgress.fractionCompleted * 100];
        
        NSLog(@"   这是下载进度------------%@", jjj    );
        if (fractionCompleted) {
            fractionCompleted(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                //指定下载文件保存的路径
                NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                NSString *path;
                if (saveFile) {
                    path = [saveFile stringByAppendingPathComponent:response.suggestedFilename];;
                }else {
                    
                path =[cache stringByAppendingPathComponent:response.suggestedFilename];
                }
                //URLWithString 返回的网络的URL,如果使用本地URL，需要注意NSURL *fileURL = [NSURL URLWithString:path];
                NSURL *fileURL = [NSURL fileURLWithPath:path];
                return fileURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        
        if([self.downloadTaskDict objectForKey:downDescription]){
        
            [self.downloadTaskDict removeObjectForKey:downDescription];
        
        }
        
      NSLog(@"   这是filePath    %@",filePath);
        NSLog(@"   这是response    %@",response);
        NSLog(@"   这是error    %@",error);
        if (!error) {
            if (result) {
                result(filePath);
            }
        }else{
        
            if (failure) {
                failure(error);
            }
        
        }
    }];
    
    downloadTask.taskDescription = downDescription;
    [self.downloadTaskDict setObject:downloadTask forKey:downDescription];
   
    }
    [downloadTask resume];

}






-(void)downLoadTaskSuspendWithDescription:(NSString *)downDescription{

    if ([self.downloadTaskDict objectForKey:downDescription]) {
        NSURLSessionDownloadTask *downloadTask = [self.downloadTaskDict objectForKey:downDescription];
        [downloadTask suspend];
    }

}






























/**
 *  获取用户的网络状态
 *
 *  @param state 返回值当前状态
 */
-(void)netWorkReachability:(void (^)(NSInteger reastate))reastate{
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                reastate(statusUnknown);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                reastate(statusNotReachable);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
               reastate(statusReachableViaWWAN);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reastate(statusReachableViaWiFi);
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
}




 -(void)makeTex{

    
//    NSURLSessionConfiguration*configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//     
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
//    
//    NSURL*URL = [NSURLURLWithString:@"http://example.com/download.zip"];
//    NSURLRequest*request = [NSURLRequest requestWithURL:URL];
//    NSURLSessionDownloadTask*downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL*(NSURL*targetPath,NSURLResponse*response) {
//        NSURL*documentsDirectoryURL = [[NSFileManagerdefaultManager]URLForDirectory:NSDocumentDirectoryinDomain:NSUserDomainMaskappropriateForURL:nilcreate:NOerror:nil];return[documentsDirectoryURLURLByAppendingPathComponent:[responsesuggestedFilename]];
//    }completionHandler:^(NSURLResponse*response,NSURL*filePath,NSError*error) {
//        
//        NSLog(@"File downloaded to:%@", filePath);
//    
//    }];
//     [downloadTask resume];
    
    
}







@end

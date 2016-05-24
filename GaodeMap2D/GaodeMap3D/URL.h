//
//  URL.h
//  GaodeMapDemo
//
//  Created by DIT on 16/5/23.
//  Copyright © 2016年 Coco. All rights reserved.
//

#ifndef URL_h
#define URL_h

#define kUIImageNamed(imageName) [UIImage imageNamed:imageName]
#define KPAGESIZE 20

#define kSetValue(dict,key) [dict[key] isKindOfClass:[NSNull class]] || dict[key] == nil || ([dict[key] isKindOfClass:[NSString class]] && [[dict[key] lowercaseString] isEqualToString:@"null"]) ? @"" : [NSString stringWithFormat:@"%@",dict[key]]
#define kUICOLOOR(RED,GREEN,BLUE)  [UIColor colorWithRed:RED/255.0 green:GREEN/255. blue:BLUE/255.0 alpha:1.0]
#define FBGCOLOR [UIColor colorWithRed:157./255 green:184./255 blue:199./255 alpha:1.]
#define FBGQIANCOLOR [UIColor colorWithRed:157./255 green:184./255 blue:199./255 alpha:.8]


#define kCOLOR(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255. green:GREEN/255. blue:BLUE/255. alpha:1.]


#ifdef DEBUG
#define DLog(fmt, ...) //NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)//
#endif


#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

#define kIsIOS8 ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)



#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kDATA @"data"
#define kCONTENTS @"contents"
#define kMETA @"meta"
#define kCODEVAR @"code"
#define kMESSAGE @"message"
#define kCODESUCCESS @"200"
#define kNOWORK @"哎呀,网络出问题了"

#define KHOTADDID @"HotAddID"
#define KHOTADDNAME @"HotAddName"
#define KHOTADDPROCESS @"HotAddProcess"
#define KHOTADDINFO @"HotAddInfo"
#define KHOTADDCOUNTSIZE @"HotAddCountSize"
#define KHOTADDNOWSIZE @"HotAddNowSize"
#define kHOTADDUPDATEDATE @"HotUpdate"
//#import <Foundation/Foundation.h>
//
//#import "ProgressHUD.h"
//#import "FBContent.h"
//#import "FBTools.h"
//#import "FBAudioPlay.h"
//#import <MAMapKit/MAMapKit.h>
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>
//#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>



#endif /* URL_h */

//
//  FBContent.m
//  GaodeMapDemo
//
//  Created by DIT on 16/5/23.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import "FBContent.h"

@implementation FBContent




+(FBContent *)shartContent{

    static FBContent *content = nil;
    static dispatch_once_t oneToKen;
    dispatch_once(&oneToKen, ^{
        
        content = [[FBContent alloc]init
        ];
        
        
        
    });

    return content;
}



-(NSMutableArray *)theNearLocation{

    if (!_theNearLocation) {
        _theNearLocation = [[NSMutableArray alloc]init];
        
    }
    return _theNearLocation;
}
@end

//
//  LocationNode.h
//  MapDemo
//
//  Created by pigpigdaddy on 14-10-8.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationNode : NSObject

// 主键
@property (nonatomic, assign) int index;
// 定位时间
@property (nonatomic, assign) int time;
// 位置经度
@property (nonatomic, assign) double lng;
// 位置纬度
@property (nonatomic, assign) double lat;
// 位置名称
@property (nonatomic, strong) NSString *street;

@end

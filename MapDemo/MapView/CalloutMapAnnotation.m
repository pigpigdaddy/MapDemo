//
//  CalloutMapAnnotation.m
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import "CalloutMapAnnotation.h"

@implementation CalloutMapAnnotation

/**
 TODO:初始化地标插图注释
 
 @param detailBean 地标插图信息数据节点
 
 @return 地标插图注释对象
 
 @author pigpigdaddy
 @since 3.0
 */
- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude{
    self = [super init];
    if (self){
        _coordinate.latitude = latitude;
        _coordinate.longitude = longitude;
    }
    return self;
}

@end

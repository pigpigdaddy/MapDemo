//
//  PlaceMark.m
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 凤凰优阅. All rights reserved.
//

#import "PlaceMark.h"

@implementation PlaceMark

/**
 TODO:初始化地标
 
 @param detailBean 地标信息数据节点
 
 @return 地标对象
 
 @author pigpigdaddy
 @since 3.0
 */
- (id)initWithPlace:(LocationNode *)detailBean{
    self = [super init];
    if (self){
        _coordinate.latitude = detailBean.lat;
        _coordinate.longitude = detailBean.lng;
        self.locationDetailBean = detailBean;
    }
    return self;
}

@end

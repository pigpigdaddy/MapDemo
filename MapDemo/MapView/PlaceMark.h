//
//  PlaceMark.h
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 凤凰优阅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationNode.h"

@interface PlaceMark : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D          coordinate;

@property (nonatomic, strong) LocationNode                *locationDetailBean;

@property (nonatomic, assign) MKPinAnnotationColor              pinColor;

/**
 TODO:初始化地标注释
 
 @param detailBean 地标信息数据节点
 
 @return 地标注释对象
 
 @author pigpigdaddy
 @since 3.0
 */
- (id)initWithPlace:(LocationNode *)detailBean;

@end

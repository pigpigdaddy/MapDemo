//
//  CalloutMapAnnotation.h
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationNode.h"

@interface CalloutMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong)LocationNode *node;

@property (nonatomic, assign) MKPinAnnotationColor pinColor;

/**
 TODO:初始化地标插图注释
 
 @param detailBean 地标插图信息数据节点
 
 @return 地标插图注释对象
 
 @author pigpigdaddy
 @since 3.0
 */
- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;

@end

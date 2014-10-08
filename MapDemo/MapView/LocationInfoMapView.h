//
//  LocationInfoMapView.h
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationInfoMapView;
@class LocationNode;
@protocol LocationInfoMapViewDelegate <NSObject>
@optional

/**
 TODO:点击地标显示callout回调
 
 @param mapView    地图
 @param locationNode 位置详情节点
 
 @author pigpigdaddy
 @since 3.0
 */
- (void)mapView:(LocationInfoMapView *)mapView didShowCallOutViewWithDetailBean:(LocationNode *)locationNode;

@end

@interface LocationInfoMapView : UIView

@property (nonatomic, assign) id<LocationInfoMapViewDelegate>           delegate;

/**
 TODO:显示地图标记
 
 @param annotations 地图标记注释数组
 
 @author pigpigdaddy
 @since 3.0
 */
-(void)showAnnotation:(NSArray *)annotations;

/**
 TODO:是当前位置居中与地图
 
 @param index
 
 @author pigpigdaddy
 @since 3.0
 */
-(void)makeAnnotationCenter:(LocationNode *)detailBean;

@end

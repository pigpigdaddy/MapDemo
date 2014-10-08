//
//  LocationInfoMapView.m
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 凤凰优阅. All rights reserved.
//

#import "LocationInfoMapView.h"
#import <MapKit/MapKit.h>
#import "PlaceMark.h"
#import "CalloutMapAnnotation.h"
#import "CallOutAnnotationView.h"
#import "CustomCalloutView.h"

@interface LocationInfoMapView ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView                   *mapView;
//路线点
@property (nonatomic, retain) NSArray                     *routes;
//地标插图注释
@property (retain, nonatomic) CalloutMapAnnotation        *calloutAnnotation;

@end

@implementation LocationInfoMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

#pragma mark ------------------------------------ init  -------------------------------------------------

/**
 TODO:初始化界面
 
 @author pigpigdaddy
 @since 1.0
 */
- (void)initView{
    [self initMapView];
}

/**
 TODO:初始化地图
 
 @author pigpigdaddy
 @since 1.0
 */
- (void)initMapView{
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self addSubview:self.mapView];
}

#pragma mark ------------------------------------ Private Methods  -------------------------------------------------

/**
 TODO:将地图居中显示
 
 @author pigpigdaddy
 @since 3.0
 */
- (void)centerMap {
    if (self.routes.count) {
        MKCoordinateRegion region;
        
        CLLocationDegrees maxLat = -90;
        CLLocationDegrees maxLon = -180;
        CLLocationDegrees minLat = 90;
        CLLocationDegrees minLon = 180;
        for(int idx = 0; idx < self.routes.count; idx++){
            CLLocation *currentLocation = [self.routes objectAtIndex:idx];
            if(currentLocation.coordinate.latitude > maxLat)
                maxLat = currentLocation.coordinate.latitude;
            if(currentLocation.coordinate.latitude < minLat)
                minLat = currentLocation.coordinate.latitude;
            if(currentLocation.coordinate.longitude > maxLon)
                maxLon = currentLocation.coordinate.longitude;
            if(currentLocation.coordinate.longitude < minLon)
                minLon = currentLocation.coordinate.longitude;
        }
        region.center.latitude     = (maxLat + minLat) / 2;
        region.center.longitude    = (maxLon + minLon) / 2;
        region.span.latitudeDelta  = 1.2 * (maxLat - minLat);
        region.span.longitudeDelta = 1.2 * (maxLon - minLon);
        
        
        //        if (region.span.longitudeDelta < 0 || region.span.longitudeDelta > 1){
        //            return;
        //        }
        //        if (region.span.latitudeDelta<0 || region.span.latitudeDelta > 1){
        //            return;
        //        }
        
        [self.mapView setRegion:region animated:NO];
    }else{
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location.coordinate,2000, 2000);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
        [self.mapView setRegion:adjustedRegion animated:YES];
    }
}

/**
 TODO:重新绘制导航视图
 
 @author pigpigdaddy
 @since 3.0
 */
- (void)updateRouteView{
    [self.mapView removeOverlays:self.mapView.overlays];
    
    CLLocationCoordinate2D pointsToUse[[self.routes count]];
    for (int i = 0; i < [self.routes count]; i++) {
        CLLocationCoordinate2D coords;
        CLLocation *loc = [self.routes objectAtIndex:i];
        coords.latitude = loc.coordinate.latitude;
        coords.longitude = loc.coordinate.longitude;
        pointsToUse[i] = coords;
    }
    MKPolyline *lineOne = [MKPolyline polylineWithCoordinates:pointsToUse count:[self.routes count]];
    [self.mapView addOverlay:lineOne];
}

#pragma mark ------------------------------------ Public Methods  -------------------------------------------------

/**
 TODO:显示地图标记
 
 @param annotations 地图标记注释数组
 
 @author pigpigdaddy
 @since 3.0
 */
-(void)showAnnotation:(NSArray *)annotations{
    //清除地图标记
    for (id annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[PlaceMark class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    
    NSMutableArray *routes = [[NSMutableArray alloc] init];
    for (LocationNode *detailBean in annotations) {
        PlaceMark *mark = [[PlaceMark alloc] initWithPlace:detailBean];
        [self.mapView addAnnotation:mark];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:mark.coordinate.latitude longitude:mark.coordinate.longitude];
        [routes addObject:location];
    }
    self.routes = routes;
    [self centerMap];
    [self updateRouteView];
}

/**
 TODO:是当前位置居中与地图
 
 @param detailBean 当前位置数据节点
 
 @author pigpigdaddy
 @since 3.0
 */
-(void)makeAnnotationCenter:(LocationNode *)detailBean{
    for (id annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[PlaceMark class]]) {
            PlaceMark *mark = (PlaceMark *)annotation;
            if (mark.locationDetailBean.index == detailBean.index) {
                [self.mapView selectAnnotation:mark animated:YES];
            }
        }
    }
}

#pragma mark ------------------------------------ MKMapViewDelegate  -------------------------------------------------

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineView *lineview = [[MKPolylineView alloc] initWithOverlay:overlay];
        //路线颜色
        lineview.strokeColor = [UIColor colorWithRed:0.0 green:126.0/255 blue:1.0 alpha:.75];
        lineview.lineWidth = 12.0;
        return lineview;
    }
    return nil;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation {
    if ([annotation isKindOfClass:[PlaceMark class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PlaceMark"];
        if(annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:@"PlaceMark"];
        }
        PlaceMark *mark = (PlaceMark *)annotation;
        annotationView.pinColor = mark.pinColor;
        annotationView.animatesDrop = NO;
        annotationView.canShowCallout = NO;
        return annotationView;
    }
    else if ([annotation isKindOfClass:[CalloutMapAnnotation class]]){
        CallOutAnnotationView *annotationView = (CallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        if (!annotationView) {
            annotationView = [[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
            CustomCalloutView  *cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCalloutView" owner:self options:nil] objectAtIndex:0];
            [annotationView.contentView addSubview:cell];
        }
        for (id subView in annotationView.contentView.subviews) {
            if ([subView isKindOfClass:[CustomCalloutView class]]) {
                CustomCalloutView *callout = (CustomCalloutView *)subView;
                CalloutMapAnnotation *mapMark = (CalloutMapAnnotation *)annotation;
                callout.addressLabel.text = mapMark.addr;
                callout.addressTimeLabel.text = mapMark.time;
            }
        }
        [annotationView showWithAnimation:YES];
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
	if ([view.annotation isKindOfClass:[PlaceMark class]]) {
        
        PlaceMark *placeMark = (PlaceMark *)view.annotation;
        self.calloutAnnotation = [[CalloutMapAnnotation alloc]
                                  initWithLatitude:view.annotation.coordinate.latitude
                                  andLongitude:view.annotation.coordinate.longitude];
        self.calloutAnnotation.addr = placeMark.locationDetailBean.street;
        if (placeMark.locationDetailBean.time) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            self.calloutAnnotation.time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:placeMark.locationDetailBean.time]];
        }
        
        [mapView addAnnotation:self.calloutAnnotation];
        //当前点居中
        [mapView setCenterCoordinate:self.calloutAnnotation.coordinate animated:YES];
        
        //同步学生位置表
        if (self.delegate && [self.delegate respondsToSelector:@selector(mapView:didShowCallOutViewWithDetailBean:)]) {
            [self.delegate mapView:self didShowCallOutViewWithDetailBean:placeMark.locationDetailBean];
        }
	}
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (self.calloutAnnotation && ![view isKindOfClass:[CalloutMapAnnotation class]]) {
        if (self.calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            self.calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:self.calloutAnnotation];
        }
    }
}

@end

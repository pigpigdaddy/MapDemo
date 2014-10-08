//
//  CallOutAnnotationView.h
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CallOutAnnotationView : MKAnnotationView

//内容视图
@property (nonatomic, strong) UIView                    *contentView;

/**
 TODO:展示动画
 
 @param animation 是否需要动画
 
 @author pigpigdaddy
 @since 3.0
 */
-(void)showWithAnimation:(BOOL)animation;

@end

//
//  CallOutAnnotationView.m
//  Education
//
//  Created by pigpigdaddy on 14-7-28.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import "CallOutAnnotationView.h"
#import <QuartzCore/QuartzCore.h>

#define  Arror_height 26
#define  Arror_width 13
#define  BOUNCE_ANIMATION_DURATION 0.3

@interface CallOutAnnotationView ()

@end

@implementation CallOutAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpAttributes];
        [self initContentView];
    }
    return self;
}

/**
 TODO:在设置基本属性
 
 @author pigpigdaddy
 @since 3.0
 */
- (void)setUpAttributes{
    self.alpha = 0.0f;
    self.backgroundColor = [UIColor clearColor];
    self.canShowCallout = NO;
    self.centerOffset = CGPointMake(0, -85);
    self.frame = CGRectMake(0, 0, 277, 102 + Arror_height);
}

/**
 TODO:初始化内容视图
 
 @author pigpigdaddy
 @since 3.0
 */
- (void)initContentView{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - Arror_height)];
    self.contentView.backgroundColor   = [UIColor clearColor];
    [self addSubview:self.contentView];
}


/**
 TODO:展示动画
 
 @param animation 是否需要动画
 
 @author pigpigdaddy
 @since 3.0
 */
-(void)showWithAnimation:(BOOL)animation{
    self.alpha = 0.0f;
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    CAMediaTimingFunction *easeInOut = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //    bounceAnimation.beginTime = CACurrentMediaTime() + 0.1;
    bounceAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.05],
                              [NSNumber numberWithFloat:1.11245],
                              [NSNumber numberWithFloat:0.951807],
                              [NSNumber numberWithFloat:1.0],nil];
    bounceAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],
                                [NSNumber numberWithFloat:4.0/9.0],
                                [NSNumber numberWithFloat:4.0/9.0+5.0/18.0],
                                [NSNumber numberWithFloat:1.0],nil];
    bounceAnimation.duration = animation ? BOUNCE_ANIMATION_DURATION : 0;
    bounceAnimation.timingFunctions = [NSArray arrayWithObjects:easeInOut, easeInOut, easeInOut, easeInOut,nil];
    bounceAnimation.delegate = self;
    
    [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
}

- (void)animationDidStart:(CAAnimation *)anim {
    // ok, animation is on, let's make ourselves visible!
    self.alpha = 1.0f;
}

@end

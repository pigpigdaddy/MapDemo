//
//  ViewController.m
//  MapDemo
//
//  Created by pigpigdaddy on 14-10-8.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import "ViewController.h"
#import "LocationNode.h"
#import "LocationInfoMapView.h"

@interface ViewController ()<LocationInfoMapViewDelegate>

@property (nonatomic, strong)NSMutableArray *locationArray;
@property (nonatomic, strong)LocationInfoMapView *mapView;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.locationArray = [[NSMutableArray alloc] init];
    LocationNode *node1 = [[LocationNode alloc] init];
    node1.index = 1;
    node1.lng = 118.7862;
    node1.lat = 32.05465;
    node1.time = 1412046912;
    node1.street = @"街道1";
    
    LocationNode *node2 = [[LocationNode alloc] init];
    node2.index = 2;
    node2.lng = 118.7392;
    node2.lat = 32.03229;
    node2.time = 1412046912;
    node2.street = @"街道2";
    
    LocationNode *node3 = [[LocationNode alloc] init];
    node3.index = 3;
    node3.lng = 118.6984;
    node3.lat = 32.16065;
    node3.time = 1412046912;
    node3.street = @"街道3";
    [self.locationArray addObject:node1];
    [self.locationArray addObject:node2];
    [self.locationArray addObject:node3];
}

- (void)initView
{
    self.mapView = [[LocationInfoMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.mapView showAnnotation:self.locationArray];
    [self.mapView makeAnnotationCenter:[self.locationArray firstObject]];
    [self.view addSubview:self.mapView];
}

@end

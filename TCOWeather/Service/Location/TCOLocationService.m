//
//  TCOLocationService.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "TCOLocationService.h"

@import Foundation;
@import CoreLocation;

@interface TCOLocationService ()

@property (nonatomic, strong, readwrite) TCOCondition *currentCondition;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong, readwrite) NSArray *hourlyForecast;
@property (nonatomic, strong, readwrite) NSArray *dailyForecast;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
//@property (nonatomic, strong) WXClient *client;

@end

@implementation TCOLocationService

+ (instancetype)sharedManager {
    
    static dispatch_once_t pred;
    static TCOLocationService *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[TCOLocationService alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    _locationManager.delegate = self;

  }
  return self;
}

- (void)findCurrentLocation {
  if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
  }
  
  self.isFirstUpdate = YES;
  [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  //  ignore the first location update because it is almost always cached
  
  if (self.isFirstUpdate) {
    self.isFirstUpdate = NO;
    return;
  }
  
  CLLocation *location = [locations lastObject];
  
  if (location.horizontalAccuracy > 0) {
    self.currentLocation = location;
    [self.locationManager stopUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TCONotification.Location.DidUpdate"
                                                        object:self];
  }
}

@end

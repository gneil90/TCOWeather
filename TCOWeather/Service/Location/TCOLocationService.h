//
//  TCOLocationService.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Foundation;
@import CoreLocation;
#import "TCOCoreDataEntity.h"

@interface TCOLocationService : NSObject<CLLocationManagerDelegate>

+ (instancetype)sharedManager;

@property (nonatomic, strong, readonly) CLLocation *currentLocation;

- (void)findCurrentLocation;

@end

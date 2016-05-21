//
//  TCOUserSettings.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "TCOUserSettings.h"
#import <CoreData/CoreData.h>
#import "TCOCity.h"

#import "NSManagedObject+Fetch.h"

NSString * const TCOSettingsLocationMy = @"My Location";

@implementation TCOUserSettings

// Insert code here to add functionality to your managed object subclass
+ (TCOUserSettings *)sharedSettingsInContext:(NSManagedObjectContext *)ctx {
  
  static TCOUserSettings * settings;
  static dispatch_once_t pred;
  
  dispatch_once(&pred, ^{
    settings = [TCOUserSettings TCO_findFirstInContext:ctx];
    if (!settings) {
      settings = [TCOUserSettings defaultSettingsInContext:ctx];
    }
  });
  return settings;
}

+ (TCOUserSettings *)defaultSettingsInContext:(NSManagedObjectContext *)ctx {
  TCOUserSettings * settings = [TCOUserSettings TCO_createEntityInContext:ctx];
  settings.locationName = TCOSettingsLocationMy;
  
  
  NSArray * cities = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultCityList" ofType:@"plist"]];
  
  
  TCOCity * city = [TCOCity TCO_createEntityInContext:ctx];
  city.name = TCOSettingsLocationMy;
  
  for (NSString * cityName in cities) {
    TCOCity * city = [TCOCity TCO_createEntityInContext:ctx];
    city.name = cityName;
  }
  
  return settings;
}


@end

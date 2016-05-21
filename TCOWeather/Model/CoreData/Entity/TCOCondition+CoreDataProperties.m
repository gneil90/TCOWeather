//
//  TCOCondition+CoreDataProperties.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TCOCondition+CoreDataProperties.h"

@implementation TCOCondition (CoreDataProperties)

@dynamic date;
@dynamic id_;
@dynamic locationName;
@dynamic humidity;
@dynamic temperature;
@dynamic tempHigh;
@dynamic tempLow;
@dynamic sunrise;
@dynamic sunset;
@dynamic windBearing;
@dynamic windSpeed;
@dynamic icon;
@dynamic weather_description;
@dynamic main;
@dynamic city;

@end

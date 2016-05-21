//
//  TCOCondition+CoreDataProperties.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TCOCondition.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCOCondition (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *id_;
@property (nullable, nonatomic, retain) NSString *locationName;
@property (nullable, nonatomic, retain) NSNumber *humidity;
@property (nullable, nonatomic, retain) NSNumber *temperature;
@property (nullable, nonatomic, retain) NSNumber *tempHigh;
@property (nullable, nonatomic, retain) NSNumber *tempLow;
@property (nullable, nonatomic, retain) NSDate *sunrise;
@property (nullable, nonatomic, retain) NSDate *sunset;
@property (nullable, nonatomic, retain) NSNumber *windBearing;
@property (nullable, nonatomic, retain) NSNumber *windSpeed;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *weather_description;
@property (nullable, nonatomic, retain) NSString *main;
@property (nullable, nonatomic, retain) TCOCity *city;

@end

NS_ASSUME_NONNULL_END

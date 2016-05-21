//
//  TCOWeatherDateFormatter.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCOWeatherDateFormatter : NSObject

+ (instancetype)sharedFormatter;
- (NSString *)forecastFormattedStringFromDate:(NSDate *)date;

@end

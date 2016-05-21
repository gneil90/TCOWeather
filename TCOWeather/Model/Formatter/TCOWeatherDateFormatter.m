//
//  TCOWeatherDateFormatter.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "TCOWeatherDateFormatter.h"

@interface TCOWeatherDateFormatter ()

@property (strong, nonatomic) NSDateFormatter * df;

@end

@implementation TCOWeatherDateFormatter

+ (instancetype)sharedFormatter {

    static dispatch_once_t pred;
    static TCOWeatherDateFormatter *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[TCOWeatherDateFormatter alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.df = [[NSDateFormatter alloc] init];
    self.df.dateStyle = kCFDateFormatterShortStyle;
    self.df.timeStyle = kCFDateFormatterShortStyle;
    self.df.doesRelativeDateFormatting = YES;

  }
  return self;
}

- (NSString *)forecastFormattedStringFromDate:(NSDate *)date {
  return [self.df stringFromDate:date];
}

@end

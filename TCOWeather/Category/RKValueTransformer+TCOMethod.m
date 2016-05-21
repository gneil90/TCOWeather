//
//  RKValueTransformer+TCOMethod.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "RKValueTransformer+TCOMethod.h"
#import "TCOWeather-Swift.h"
#import "TCOWeatherIconFactory.h"

@implementation RKValueTransformer (TCOMethod)

+ (RKValueTransformer *)timeIntervalStringSince1970ToDateValueTransformer {
  RKValueTransformer * timeIntervalStringSince1970ToDateValueTransformer = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class inputValueClass, __unsafe_unretained Class outputValueClass) {
    return [inputValueClass isSubclassOfClass:[NSString class]];
  } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, __unsafe_unretained Class outputClass, NSError *__autoreleasing *error) {
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[(NSString *)inputValue longLongValue]];

    *outputValue = date;
    return YES;
  }];
  return timeIntervalStringSince1970ToDateValueTransformer;
}

+ (RKValueTransformer *)degreeValueToCelciusTransformer {
  RKValueTransformer * degreeValueTransformer = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class inputValueClass, __unsafe_unretained Class outputValueClass) {
    return [inputValueClass isSubclassOfClass:[NSNumber class]];
  } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, __unsafe_unretained Class outputClass, NSError *__autoreleasing *error) {
    
    float value = [inputValue floatValue];
    *outputValue = @(value - 273.15);
    return YES;
  }];
  
  return degreeValueTransformer;
}

+ (RKValueTransformer *)weatherIconNameValueTransformer {
  RKValueTransformer * weatherIconNameValueTransformer = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class inputValueClass, __unsafe_unretained Class outputValueClass) {
    return [inputValueClass isSubclassOfClass:[NSArray class]];
  } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, __unsafe_unretained Class outputClass, NSError *__autoreleasing *error) {
    *outputValue = TCOWeatherIconFactory.weatherImageMap[[inputValue firstObject]];

    return YES;
  }];
  return weatherIconNameValueTransformer;
}

+ (RKValueTransformer *)arrayToFirstObjectValueTransformer {
  RKValueTransformer * arrayToFirstObjectValueTransformer = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class inputValueClass, __unsafe_unretained Class outputValueClass) {
    return [inputValueClass isSubclassOfClass:[NSArray class]];
  } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, __unsafe_unretained Class outputClass, NSError *__autoreleasing *error) {
    *outputValue = [inputValue firstObject];
    
    return YES;
  }];
  return arrayToFirstObjectValueTransformer;
}

@end

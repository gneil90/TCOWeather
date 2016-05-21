//
//  RKValueTransformer+TCOMethod.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import <RKValueTransformers/RKValueTransformers.h>

@interface RKValueTransformer (TCOMethod)

+ (RKValueTransformer *)timeIntervalStringSince1970ToDateValueTransformer;
+ (RKValueTransformer *)degreeValueToCelciusTransformer;
+ (RKValueTransformer *)weatherIconNameValueTransformer;
+ (RKValueTransformer *)arrayToFirstObjectValueTransformer;

@end

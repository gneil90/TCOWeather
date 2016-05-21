//
//  TCOCondition.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@class TCOCity, TCOCoord, TCOMain, TCOWind;

NS_ASSUME_NONNULL_BEGIN

@interface TCOCondition : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (id)findLatestConditionInContext:(NSManagedObjectContext *)ctx;

@end

NS_ASSUME_NONNULL_END

#import "TCOCondition+CoreDataProperties.h"

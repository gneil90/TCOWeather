//
//  TCOCity.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TCOCondition;

NS_ASSUME_NONNULL_BEGIN

@interface TCOCity : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (TCOCity *)myCityInContext:(NSManagedObjectContext *)ctx;
+ (TCOCity *)cityWithName:(NSString *)name inContext:(NSManagedObjectContext *)ctx;

@end

NS_ASSUME_NONNULL_END

#import "TCOCity+CoreDataProperties.h"

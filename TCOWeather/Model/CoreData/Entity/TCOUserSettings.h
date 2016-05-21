//
//  TCOUserSettings.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const TCOSettingsLocationMy;

@interface TCOUserSettings : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (TCOUserSettings *)sharedSettingsInContext:(NSManagedObjectContext *)ctx;

@end

NS_ASSUME_NONNULL_END

#import "TCOUserSettings+CoreDataProperties.h"

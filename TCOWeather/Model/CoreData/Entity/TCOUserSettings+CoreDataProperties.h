//
//  TCOUserSettings+CoreDataProperties.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TCOUserSettings.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCOUserSettings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *locationName;

@end

NS_ASSUME_NONNULL_END

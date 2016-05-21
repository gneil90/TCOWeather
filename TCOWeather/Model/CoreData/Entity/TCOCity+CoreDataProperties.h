//
//  TCOCity+CoreDataProperties.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TCOCity.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCOCity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<TCOCondition *> *conditions;

@end

@interface TCOCity (CoreDataGeneratedAccessors)

- (void)addConditionsObject:(TCOCondition *)value;
- (void)removeConditionsObject:(TCOCondition *)value;
- (void)addConditions:(NSSet<TCOCondition *> *)values;
- (void)removeConditions:(NSSet<TCOCondition *> *)values;

@end

NS_ASSUME_NONNULL_END

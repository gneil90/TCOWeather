//
//  NSManagedObject+Fetch.h
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Fetch)

+ (id)TCO_createEntityInContext:(NSManagedObjectContext *)ctx;

+ (id)TCO_findFirstWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)ctx;
+ (id)TCO_findFirstWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors inContext:(NSManagedObjectContext *)ctx;
+ (id)TCO_findFirstInContext:(NSManagedObjectContext *)ctx;

+ (id)TCO_findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors inContext:(NSManagedObjectContext *)ctx;
+ (id)TCO_findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors fetchLimit:(NSInteger)limit inContext:(NSManagedObjectContext *)ctx;


@end

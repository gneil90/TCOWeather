//
//  NSManagedObject+Fetch.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "NSManagedObject+Fetch.h"
@import CoreData;

@implementation NSManagedObject (Fetch)

+ (id)TCO_findFirstInContext:(NSManagedObjectContext *)ctx {
  return [self TCO_findFirstWithPredicate:nil inContext:ctx];
}


+ (id)TCO_findFirstWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)ctx
{
  return [self TCO_findFirstWithPredicate:predicate sortDescriptors:nil inContext:ctx];

}

+ (id)TCO_findFirstWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors inContext:(NSManagedObjectContext *)ctx {
  NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
  request.predicate = predicate;
  request.sortDescriptors = descriptors;
  NSError * err;
  NSArray * results = [ctx executeFetchRequest:request error:&err];
  
  return [results firstObject];
}

+ (id)TCO_findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors inContext:(NSManagedObjectContext *)ctx {
  return [self TCO_findWithPredicate:predicate sortDescriptors:descriptors fetchLimit:0 inContext:ctx];
}

+ (id)TCO_findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors fetchLimit:(NSInteger)limit inContext:(NSManagedObjectContext *)ctx {
  NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
  request.predicate = predicate;
  request.sortDescriptors = descriptors;
  if (limit > 0) {
    request.fetchLimit = limit;
  }
  
  NSError * err;
  NSArray * results = [ctx executeFetchRequest:request error:&err];
  return results;
}

+ (id)TCO_createEntityInContext:(NSManagedObjectContext *)ctx {
  id entity = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:ctx];
  return entity;
}

@end

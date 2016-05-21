//
//  TCOCondition.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "TCOCondition.h"
#import "NSManagedObject+Fetch.h"
#import <RestKit/RestKit.h>

@implementation TCOCondition

// Insert code here to add functionality to your managed object subclass
+ (id)findLatestConditionInContext:(NSManagedObjectContext *)ctx {
  return [TCOCondition TCO_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"date <= %@", [NSDate date]]
                                  sortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]
                                        inContext:ctx];
}

@end

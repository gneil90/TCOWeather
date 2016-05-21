//
//  TCOCity.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "TCOCity.h"
#import "TCOCondition.h"
#import "NSManagedObject+Fetch.h"
#import "TCOUserSettings.h"

@implementation TCOCity

// Insert code here to add functionality to your managed object subclass
+ (TCOCity *)myCityInContext:(NSManagedObjectContext *)ctx {
  return [self TCO_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name ==[c] %@", TCOSettingsLocationMy] inContext:ctx];
}
+ (TCOCity *)cityWithName:(NSString *)name inContext:(NSManagedObjectContext *)ctx {
  return [self TCO_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name ==[c] %@", name] inContext:ctx];
}



@end

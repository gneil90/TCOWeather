//
//  UIView+Parallax.m
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

#import "UIView+Parallax.h"

@implementation UIView (Parallax)

- (void)addDefaultParallax {
  UIInterpolatingMotionEffect *verticalMotionEffect =
  [[UIInterpolatingMotionEffect alloc]
   initWithKeyPath:@"center.y"
   type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
  verticalMotionEffect.minimumRelativeValue = @(-10);
  verticalMotionEffect.maximumRelativeValue = @(10);
  
  // Set horizontal effect
  UIInterpolatingMotionEffect *horizontalMotionEffect =
  [[UIInterpolatingMotionEffect alloc]
   initWithKeyPath:@"center.x"
   type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
  horizontalMotionEffect.minimumRelativeValue = @(-10);
  horizontalMotionEffect.maximumRelativeValue = @(10);
  
  // Create group to combine both
  UIMotionEffectGroup *group = [UIMotionEffectGroup new];
  group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];

  [self addMotionEffect:group];
}

@end

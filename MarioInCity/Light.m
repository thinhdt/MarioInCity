//
//  Light.m
//  MarioInCity
//
//  Created by mac on 8/5/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "Light.h"

@implementation Light

- (void) animate {
    self.view.center = CGPointMake(self.view.center.x + self.speed, self.view.center.y);
    
    if (self.view.frame.origin.x + self.view.bounds.size.width  < 0) {
        self.view.center = CGPointMake(self.scene.size.width + self.view.bounds.size.width * 0.5,
                                       self.view.center.y);
    }
}
@end

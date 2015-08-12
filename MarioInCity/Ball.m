//
//  Ball.m
//  MarioInCity
//
//  Created by mac on 8/6/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "Ball.h"

@implementation Ball

- (instancetype) initWithName:(NSString *)name inScene:(Scene *)scene  {
    
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]]
                       inScene:scene];
    
    return self;
}

- (void) showBall {
    if (!self.isShow) {
        [self.view setHidden:true];
    }
}

- (void) removeBall {
    
}
@end

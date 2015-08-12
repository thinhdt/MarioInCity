//
//  FireBall.h
//  MarioInCity
//
//  Created by mac on 8/6/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "Sprite.h"

@interface FireBall : Sprite
@property (nonatomic, assign) BOOL isFlying;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, weak) Sprite *fromSprite;

- (void) startFly: (CGFloat) speed;
@end

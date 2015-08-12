//
//  Ball.h
//  MarioInCity
//
//  Created by mac on 8/6/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "Sprite.h"

@interface Ball : Sprite
@property (nonatomic, assign) int totalBalls;
@property (nonatomic, assign) BOOL isShow;


- (void) showBall;
@end

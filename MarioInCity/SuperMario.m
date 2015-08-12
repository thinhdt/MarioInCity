//
//  SuperMario.m
//  MarioInCity
//
//  Created by mac on 8/5/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "SuperMario.h"
#import "FireBall.h"
#import "Ball.h"

@implementation SuperMario
{
    BOOL isRunning, isJumping;
    CGFloat jumpVelocity, fallAcceleration;
    int fireBallCount;
    
    Ball *ball;
}

- (instancetype) initWithName:(NSString *)name inScene:(Scene *)scene {
    self = [super initWithName:name inScene:scene];
    
    UIImageView *marioView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 102)];
    marioView.userInteractionEnabled = true;
    marioView.multipleTouchEnabled = true;
    
    marioView.animationImages = @[
                                  [UIImage imageNamed:@"1.png"],
                                  [UIImage imageNamed:@"2.png"],
                                  [UIImage imageNamed:@"3.png"],
                                  [UIImage imageNamed:@"4.png"],
                                  [UIImage imageNamed:@"5.png"],
                                  [UIImage imageNamed:@"6.png"],
                                  [UIImage imageNamed:@"7.png"],
                                  [UIImage imageNamed:@"8.png"]
                                  ];
    
    marioView.animationDuration  = 1.0;
    [marioView startAnimating];
    self.view = marioView;
    fireBallCount = 0;
    [self applyGestureRecognizer];
    self.alive = true;
   
    return self;
}

- (void) applyGestureRecognizer {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(startJump)];
    singleTap.numberOfTapsRequired = 1;
    [self.scene.view addGestureRecognizer:singleTap];
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(startJump)];
    
    doubleTap.numberOfTapsRequired = 2;
    [self.scene.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    ball = [[Ball alloc] init];
    ball.totalBalls = 7;
    
    if (ball.totalBalls > 0) {
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(fire)];
        
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self.scene.view addGestureRecognizer:swipeRight];

    }
    
}

- (void) startJump {
    if (!isJumping) {
        isJumping = true;
        jumpVelocity = - 40.0;
        fallAcceleration = 10.0;
    }
}

- (void) jump {
    if (!isJumping) {
        return;
    }
    
    CGFloat y = self.view.center.y;
     y += jumpVelocity;
    jumpVelocity += fallAcceleration;
    
    if (y > self.y0) {
        y = self.y0;
        isJumping = false;
    }
    self.view.center = CGPointMake(self.view.center.x, y);
    
}

- (void) fire {
    if (ball.totalBalls > 0) {
        fireBallCount++;
        ball.totalBalls--;
        
        [self.scene ListSprites];
        if (fireBallCount <= 7) {
            [self.scene removeSpriteByName:[NSString stringWithFormat:@"ball%d", fireBallCount]];
        }
        
        FireBall *fireBall = [[FireBall alloc]
                              initWithName:[NSString stringWithFormat:@"fireball%d.png", fireBallCount]
                              inScene:self.scene];
        
        fireBall.view.center = CGPointMake(self.view.center.x + 5,  self.view.center.y);
        fireBall.fromSprite = self;
        [self.scene addSprite:fireBall];
        
        [fireBall startFly:20];
    }
    
}

- (void) animate {
    if (!self.alive) {
        return;
    }
    
    [self jump];
}

@end

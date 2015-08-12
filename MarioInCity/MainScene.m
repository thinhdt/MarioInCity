//
//  MainScene.m
//  MarioInCity
//
//  Created by mac on 7/31/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "MainScene.h"
#import "City.h"
#import "Cloud.h"
#import "Light.h"
#import "SuperMario.h"
#import "FireBall.h"
#import "Ball.h"

#define city_backgroud_width 1498
@implementation MainScene
{
    City *city1, *city2;
    SuperMario *mario;
    CGSize citySize;
    NSTimer *timer;
    Cloud *cloud1, *cloud2, *cloud3;
    NSMutableArray *blocks;
    CGFloat marioRunSpeed;
    
    Light *light1, *light2, *light3;
    int fireBallCount;
}

- (void) viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusNavigationBarHeight);
    
    [self addCity];
    [self addClouds];
    [self addLights];
    [self addSuperMario];
    [self addFireBalls];
    
    marioRunSpeed = 20.0;
    fireBallCount = 7;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(gameloop)
                                           userInfo:nil
                                            repeats:true];
}

- (void) addCity {
    citySize = CGSizeMake(city_backgroud_width, 400);
    UIImage *cityBackgroud = [UIImage imageNamed:@"city"];
    
    city1 = [[City alloc] initWithName:@"city1"
                              ownView:[[UIImageView alloc] initWithImage:cityBackgroud]
                               inScene:self];
    
    city1.view.frame = CGRectMake(0, self.size.height - citySize.height, citySize.width, citySize.height);
    
    city2 = [[City alloc] initWithName:@"city2"
                               ownView:[[UIImageView alloc] initWithImage:cityBackgroud]
                               inScene:self];
    
    city2.view.frame = CGRectMake(citySize.width, self.size.height - citySize.height, citySize.width, citySize.height);

    [self.view addSubview:city1.view];
    [self.view addSubview:city2.view];
    
}

- (void) addClouds {
    cloud1 = [[Cloud alloc] initWithName:@"cloud1"
                                ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud1.png"]]
                                 inScene:self];
    
    // di lui
    cloud1.speed = -10.0;
    
    cloud2 = [[Cloud alloc] initWithName:@"cloud2"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud2.png"]]
                                 inScene:self];
    cloud2.speed = -5.0;
    
    cloud3 = [[Cloud alloc] initWithName:@"cloud3"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud3.png"]]
                                 inScene:self];
    cloud3.speed = -8.0;
    
    cloud1.view.frame = CGRectMake(20, 25, 100, 100);
    cloud2.view.frame = CGRectMake(150, 13, 80, 80);
    cloud3.view.frame = CGRectMake(260, 17, 90, 90);
    
    [self addSprite:cloud1];
    [self addSprite:cloud2];
    [self addSprite:cloud3];
    
}

- (void) addLights {
    NSArray *imageNames = @[@"light_on.png", @"light_off.png"];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    UIImageView* animationLight1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    animationLight1.animationImages = images;
    animationLight1.animationDuration = 1;
    animationLight1.animationRepeatCount = 0;
    
    UIImageView* animationLight2 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    animationLight2.animationImages = images;
    animationLight2.animationDuration = 1;
    animationLight2.animationRepeatCount = 0;
    
    UIImageView* animationLight3 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    animationLight3.animationImages = images;
    animationLight3.animationDuration = 1;
    animationLight3.animationRepeatCount = 0;
    
    
    light1 = [[Light alloc] initWithName:@"light1"
                                 ownView: animationLight1
                                 inScene:self];
    
    light1.view.frame = CGRectMake(20, 100, 35, 206);
    light1.speed = -5.0;

    light2 = [[Light alloc] initWithName:@"light2"
                                     ownView:animationLight2
                                     inScene:self];
    
    light2.view.frame = CGRectMake(200, 100, 35, 206);
    light2.speed = -5.0;
    
    
    light3 = [[Light alloc] initWithName:@"light3"
                                     ownView:animationLight3
                                     inScene:self];
    
    light3.view.frame = CGRectMake(400, 100, 35, 206);
    light3.speed = -5.0;
    
    [self addSprite:light1];
    [animationLight1 startAnimating];

    [self addSprite:light2];
    [animationLight2 startAnimating];

    [self addSprite:light3];
    [animationLight3 startAnimating];
    
}

- (void) addFireBalls {
    Ball *ball = [[Ball alloc] initWithName:@"ball1" inScene:self];
    ball.view.center = CGPointMake(self.size.width * 0.5 , 50);
    
    Ball *ball2 = [[Ball alloc] initWithName:@"ball2" inScene:self];
    ball2.view.center = CGPointMake(ball.view.frame.origin.x + 45, 50);
    
    Ball *ball3 = [[Ball alloc] initWithName:@"ball3" inScene:self];
    ball3.view.center = CGPointMake(ball2.view.frame.origin.x + 45, 50);
    
    Ball *ball4 = [[Ball alloc] initWithName:@"ball4" inScene:self];
    ball4.view.center = CGPointMake(ball3.view.frame.origin.x + 45, 50);
    
    Ball *ball5 = [[Ball alloc] initWithName:@"ball5" inScene:self];
    ball5.view.center = CGPointMake(ball4.view.frame.origin.x + 45, 50);
    
    Ball *ball6 = [[Ball alloc] initWithName:@"ball6" inScene:self];
    ball6.view.center = CGPointMake(ball5.view.frame.origin.x + 45, 50);
    
    Ball *ball7 = [[Ball alloc] initWithName:@"ball7" inScene:self];
    ball7.view.center = CGPointMake(ball6.view.frame.origin.x + 45, 50);
    
    
    [self addSprite:ball];
    [self addSprite:ball2];
    [self addSprite:ball3];
    [self addSprite:ball4];
    [self addSprite:ball5];
    [self addSprite:ball6];
    [self addSprite:ball7];

}

- (void) gameloop {
    
    [self moveCityBackAtSpeed:marioRunSpeed];
    for (Sprite *sprite in self.sprites.allValues) {
        [sprite animate];
    }
}


- (void) addSuperMario {
    mario = [[SuperMario alloc] initWithName:@"mario" inScene:self];
    
    mario.y0 = self.size.height - mario.view.frame.size.height * 0.5 - 10;
    mario.view.center = CGPointMake(self.size.width * 0.5 , mario.y0);
    
    [self addSprite:mario];
}

- (void) moveCityBackAtSpeed: (CGFloat) speed {
    city1.view.center = CGPointMake(city1.view.center.x - speed,  city1.view.center.y);
    city2.view.center = CGPointMake(city2.view.center.x - speed, city2.view.center.y);
    
    if (city1.view.frame.origin.x + citySize.width < 0.0) {
        city1.view.frame = CGRectMake(city2.view.frame.origin.x +
                                      city2.view.frame.size.width,
                                      self.size.height - citySize.height,
                                      citySize.width, citySize.height);
        
    }
    
    if (city2.view.frame.origin.x + citySize.width < 0.0) {
        city2.view.frame = CGRectMake(city1.view.frame.origin.x + city1.view.frame.size.width,
                                      city2.view.frame.origin.y,
                                      citySize.width, citySize.height);
    }
}



@end

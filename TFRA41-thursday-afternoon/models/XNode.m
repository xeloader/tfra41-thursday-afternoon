//
//  XNode.m
//  TFRA41-thursday-afternoon
//
//  Created by Victor Ingman on 2014-05-20.
//  Copyright (c) 2014 Victor Ingman. All rights reserved.
//

#import "XNode.h"
#import "XColors.h"

#define ALPHA_MIN 0.1
#define ALPHA_MAX 0.75
#define MOVE_BY_MAX 25

@implementation XNode

- (instancetype) init {
    
    self = [super init];
    
    if(self) {
        
        self.name = @NAME_NODE;
        self.strokeColor = [XColors predefinedColor:XColorYellow];
        self.fillColor = [XColors predefinedColor:XColorYellow];
        self.alpha = 0;
        
        [self runAction:[SKAction fadeAlphaTo:1 duration:1]];
        
    }
    
    return self;
    
}

- (instancetype) initWithRadius:(NSInteger)radius {
    
    self = [self init];
    
    if(self) {
        
        self.radius = radius;
        
        [self randomizeDepth];
        
    }
    
    return self;
    
}

- (void)randomizeDepth {
    
    float randomizedAlpha = ((arc4random() % (int)((ALPHA_MAX - ALPHA_MIN) * 100)) + (ALPHA_MIN * 100.0)) / 100.0;
    NSInteger radius = SIZE_NODE * randomizedAlpha;
    float newScale = randomizedAlpha;
    
    [self runAction:[SKAction group:@[
                                      [SKAction fadeAlphaTo:randomizedAlpha duration:3.0],
                                      [SKAction scaleTo:newScale duration:3.0],
                                      [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1 duration:3.0]
                                      ]]];
    //self.radius = radius;
    self.glowWidth = SIZE_NODE / radius;
    
}

- (void)kill {
    
    [self runAction:[SKAction fadeAlphaTo:0 duration:5.0] completion:^{
       
        [self removeFromParent];
        
    }];
    
}

- (void)move {
    
    NSInteger x = arc4random() % MOVE_BY_MAX;
    NSInteger y = arc4random() % MOVE_BY_MAX;
    
    x = (arc4random() % 2 == 0) ? x * -1 : x;
    y = (arc4random() % 2 == 0) ? y * -1 : y;
    
    [self runAction:[SKAction moveBy:CGVectorMake(x, y) duration:3.0]];
    
}

- (void)setRadius:(NSInteger)radius {
    
    _radius = radius;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 0,0, _radius, 0, (M_PI * 2), YES);
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_radius];
    self.path = path;
    
    
}

- (CGPoint)randomizePositionInParent {
    
    CGRect parentFrame = [self parent].frame;
    NSInteger randomX = arc4random() % (int)parentFrame.size.width;
    NSInteger randomY = arc4random() % (int)parentFrame.size.height;
    
    return CGPointMake(randomX, randomY);
    
}

@end

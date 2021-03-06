//
//  MyScene.m
//  TFRA41-thursday-afternoon
//
//  Created by Victor Ingman on 2014-05-20.
//  Copyright (c) 2014 Victor Ingman. All rights reserved.
//

#import "MyScene.h"
#import "XColors.h"

#define SPAWN_MAXIMUM 10
#define SPAWN_START 25

@implementation MyScene

- (id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    if (self) {
        
//        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
//        background.position = (CGPoint) {CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)};
//        [self addChild:background];
        [self setBackgroundColor:[XColors predefinedColor:XColorPaper]];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:[self frame]];
        [self.physicsWorld setGravity:CGVectorMake(0, 0)];
        
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerLoop) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(resizeLoop) userInfo:nil repeats:YES];
        
        [self spawnNodes];
        
    }
    
    return self;
    
}

- (void)timerLoop {
    
    //move the nodes and make it sweet-ah.
    
    [self.nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        XNode *node = obj;
            
        [node move];
        
        if(![node hasActions]) {
        
            [node randomizeDepth];
            
        }
        
    }];
    
    if(arc4random() % 100 > 65) {
        
        [self spawnNodeAt:[self randomScenePoint]];
        
    }
    
}

- (CGPoint)randomScenePoint {
    
    return CGPointMake(arc4random() % (int)self.frame.size.width, arc4random() % (int)self.frame.size.height);
    
}

- (void)resizeLoop {
    
    [self.nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        XNode *node = obj;
        if(arc4random() % 100 > 25) {
            [node randomizeDepth];
        } else {
            [node kill];
        }
        
    }];
    
    [self spawnNodes];
    
}

- (void)spawnNodes {
    
    for(NSInteger index = 0; index < SPAWN_START; index++) {
        
        if(arc4random() % 10 < 3) {
        
            [self spawnNodeAt:[self randomScenePoint]];
            
        }
        
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if([touches count] > 3) {
        
        [self removeAllChildren];
        
    } else {
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        [self spawnNodeAt:location];
        
    }
        
    }
    
}

- (void)spawnNodeAt:(CGPoint)point {
    
    XNode *node = [[XNode alloc] initWithRadius:16];
    node.position = point;
    
    [self.nodes addObject:node];
    [self addChild:node];
    
}

- (void)update:(CFTimeInterval)currentTime {
    
    [self updateGravity];
    
}

- (void)updateGravity {
    
    CMAccelerometerData *data = [self.motionManager accelerometerData];
    
    if(data) {
        
        double x = data.acceleration.x * 0.25;
        double y = data.acceleration.y * 0;
        
        [self.physicsWorld setGravity:CGVectorMake(x, y)];
        
    }
    
}

- (CMMotionManager *)motionManager {
    
    if(!_motionManager) {
        
        _motionManager = [[CMMotionManager alloc] init];
        [_motionManager startAccelerometerUpdates];
        
    }
    
    return _motionManager;
    
}

- (NSMutableArray *)nodes {
    
    if(!_nodes) {
        
        _nodes = [[NSMutableArray alloc] init];
        
    }
    
    return _nodes;
    
}

@end

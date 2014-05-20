//
//  MyScene.m
//  TFRA41-thursday-afternoon
//
//  Created by Victor Ingman on 2014-05-20.
//  Copyright (c) 2014 Victor Ingman. All rights reserved.
//

#import "MyScene.h"
#import "XColors.h"

@implementation MyScene

- (id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    if (self) {
        
        self.backgroundColor = [XColors predefinedColor:XColorBlue];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:[self frame]];
        [self.physicsWorld setGravity:CGVectorMake(0, 0)];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerLoop) userInfo:nil repeats:YES];
        
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
        
        [self spawnNodeAt:CGPointMake(arc4random() % (int)self.frame.size.width, arc4random() % (int)self.frame.size.height)];
        
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        [self spawnNodeAt:location];
        
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

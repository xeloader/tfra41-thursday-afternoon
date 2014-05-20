//
//  MyScene.h
//  TFRA41-thursday-afternoon
//

//  Copyright (c) 2014 Victor Ingman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CoreMotion/CoreMotion.h"

#import "XNode.h"

@interface MyScene : SKScene

@property (nonatomic) NSMutableArray *nodes;
@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) NSTimer *timer;

@end

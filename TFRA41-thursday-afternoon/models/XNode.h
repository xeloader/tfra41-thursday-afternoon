//
//  XNode.h
//  TFRA41-thursday-afternoon
//
//  Created by Victor Ingman on 2014-05-20.
//  Copyright (c) 2014 Victor Ingman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define NAME_NODE "xnode"
#define SIZE_NODE 8

@interface XNode : SKShapeNode

@property (nonatomic) NSInteger radius;

- (instancetype)initWithRadius:(NSInteger)radius;

- (void)randomizeDepth;
- (void)move;

@end

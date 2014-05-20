//
//  XColors.h
//  TFRA41-thursday-afternoon
//
//  Created by Victor Ingman on 2014-05-20.
//  Copyright (c) 2014 Victor Ingman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    XColorBlue = 1,
    XColorYellow = 2
    
} XColor;

@interface XColors : NSObject

+ (UIColor *)predefinedColor:(XColor)colorIndex;

@end

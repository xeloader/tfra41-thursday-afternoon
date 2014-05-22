//
//  XColors.m
//  TFRA41-thursday-afternoon
//
//  Created by Victor Ingman on 2014-05-20.
//  Copyright (c) 2014 Victor Ingman. All rights reserved.
//

#import "XColors.h"

@implementation XColors

+ (UIColor *)predefinedColor:(XColor)colorIndex {
    
    float red = 0.0;
    float green = 0.0;
    float blue = 0.0;
    float alpha = 1.0;
    
    switch(colorIndex) {
            
        case XColorBlue:
            
            red = 22.0;
            green = 35.0;
            blue = 80.0;
            
            break;
            
        case XColorYellow:
            
//            red = 255.0;
//            green = 252.0;
//            blue = 1.0;
            red = 0;
            green = 0;
            blue = 0;
            
            break;
            
        case XColorPaper:
            
            red = 255;
            green = 249;
            blue = 220;
            
            break;
            
    }
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    
}

@end

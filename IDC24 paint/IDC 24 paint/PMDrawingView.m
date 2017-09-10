//
//  PMDrawingView.m
//  IDC 24 paint
//
//  Created by Петр Первухин on 24.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDrawingView.h"

@implementation PMDrawingView




-(void) startDrawingInPoint:(CGPoint) point {
 
    self.lastPoint = point;
    [self drawLineAtPoint:point];

    
}

-(void) continueDrawingInPoint:(CGPoint) point{
    
    self.lastPoint = point;
    [self drawLineAtPoint:point];
    
}

-(void) endDrawingInPoint:(CGPoint) point{
    
    [self drawLineAtPoint:point];
    
}

-(void) drawLineAtPoint:(CGPoint) point{
    UIGraphicsBeginImageContext(self.frame.size);
    
    CGRect drawRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self.image drawInRect:drawRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 20);
    
    CGContextSetStrokeColorWithColor(context,self.brushColor.CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
    
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextStrokePath(context);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.lastPoint = point;
}




@end

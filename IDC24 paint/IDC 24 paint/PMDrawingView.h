//
//  PMDrawingView.h
//  IDC 24 paint
//
//  Created by Петр Первухин on 24.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMDrawingView : UIImageView

@property(strong,nonatomic) UIColor* brushColor;
@property(assign,nonatomic) CGFloat textWidth;
@property(assign,nonatomic) CGPoint lastPoint;


-(void)startDrawingInPoint:(CGPoint) point;
-(void) continueDrawingInPoint:(CGPoint) point;
-(void) endDrawingInPoint:(CGPoint) point;
-(void) drawLineAtPoint:(CGPoint) point;

@end

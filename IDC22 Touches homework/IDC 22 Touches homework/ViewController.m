//
//  ViewController.m
//  IDC 22 Touches homework
//
//  Created by Петр Первухин on 20.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak,nonatomic) UIView* draggingView;

@property (weak, nonatomic) IBOutlet UIView *playground;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *blackCell;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *greenPawns;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *redPawns;

@property( assign ,nonatomic) CGPoint touchOfSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   /* UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    NSLog(@" %f",(CGRectGetMidX(view1.bounds)));
  */
    
}


-(UIColor*) randomColor{
    CGFloat r = (CGFloat)(arc4random()%256)/255;
    CGFloat g = (CGFloat)(arc4random()%256)/255;
    CGFloat b = (CGFloat)(arc4random()%256)/255;
    
    return [[UIColor alloc]initWithRed:r green:g blue:b alpha:1];
}



-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.playground];
    
    UIView* view = [self.playground hitTest:point withEvent:event];
    
    if ([self.redPawns containsObject:view] || [self.greenPawns containsObject:view]){
        self.draggingView = view;
        CGPoint touchPoint = [touch locationInView:self.draggingView];
        self.touchOfSet = CGPointMake(CGRectGetMidX(self.draggingView.bounds)-touchPoint.x,
                                      CGRectGetMidY(self.draggingView.bounds)-touchPoint.y);
        
    }else{
        self.draggingView = nil;
    }
    
    
    
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if(self.draggingView){
        [self.playground bringSubviewToFront:self.draggingView];
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.playground];
        
        self.draggingView.center = CGPointMake(point.x+self.touchOfSet.x, point.y+self.touchOfSet.y);
    }
    
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
   
    if (self.draggingView){
        [self.playground sendSubviewToBack:self.draggingView];
        
        UIView* view = [self.playground hitTest:self.draggingView.center withEvent:event];
        
        if ([self.blackCell containsObject:view] && [view isEqual:[self.playground hitTest:view.center withEvent:event]]){
            self.draggingView.center = view.center;
        }else {
            UIView* nearestCell;
            int distance = self.view.frame.size.height;
            for (UIView *cell in self.blackCell){
                int i = ABS(cell.center.x - self.draggingView.center.x)+ABS(cell.center.y - self.draggingView.center.y);
                if (distance > i && [cell isEqual:[self.playground hitTest:cell.center withEvent:event]]){
                    distance = i;
                    nearestCell = cell;
                }
            }
            self.draggingView.center = nearestCell.center;
        }
        [self.playground bringSubviewToFront:self.draggingView];
    }
}

-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  IDC 20 IBOutlets homework 2
//
//  Created by Петр Первухин on 18.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//




#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *Board;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *blackCells;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *playerOneChekers;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *playerTwoChekers;


@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *chekers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [UIView animateWithDuration:2 animations:^{
        
    [self setRandomColorForBlackCells];
        
    }];
    
}

-(void) setRandomColorForBlackCells{
    UIColor* randomColor = [self randomColor];
    
    for (UIView* blackCell in self.blackCells){
        blackCell.backgroundColor = randomColor;
        }
    
    
}

-(void) shakeChekers {
    NSInteger numberOfPlayerOneChekers = self.playerOneChekers.count;
    NSInteger randomIndexOne = arc4random() % numberOfPlayerOneChekers;
    UIView* cellFrom = [self.playerOneChekers objectAtIndex:(randomIndexOne)];
    CGRect from = [cellFrom convertRect:cellFrom.bounds toView:self.Board];
    UIView * chekerFrom = [self chekerInRect:from];
    
    
    
}

-(UIView*) chekerInRect:(CGRect) rect{
 
    UIView* result = nil;
    
    for (UIView* cheker in self.chekers){
        if (CGRectContainsPoint(rect, cheker.center)){
            result = cheker;
        }
    }
    
    
    return result;
}


-(UIColor*) randomColor{
    
    CGFloat r = (float)(arc4random() % 256)/255;
    CGFloat g = (float)(arc4random() % 256)/255;
    CGFloat b = (float)(arc4random() % 256)/255;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

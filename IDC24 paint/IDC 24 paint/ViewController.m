//
//  ViewController.m
//  IDC 24 paint
//
//  Created by Петр Первухин on 24.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"
#import "PMDrawingView.h"
@interface ViewController () <UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    panGesture.delegate = self;
    self.drawingView.brushColor = [UIColor redColor];

}

-(void) handlePanGesture:(UIPanGestureRecognizer*) panGesture{
    CGPoint point = [panGesture locationInView:self.drawingView];
    if(panGesture.state == UIGestureRecognizerStateBegan){
        [self.drawingView startDrawingInPoint:point];
    }else if(panGesture.state == UIGestureRecognizerStateChanged){
        [self.drawingView continueDrawingInPoint:point];
    }else if((panGesture.state == UIGestureRecognizerStateEnded) || (panGesture.state ==UIGestureRecognizerStateCancelled)){
        [self.drawingView endDrawingInPoint:point];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.drawingView setNeedsDisplay];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    
    }];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
}

-(UIInterfaceOrientationMask) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clearButton:(UIButton *)sender {
    self.drawingView.image = nil;

}

- (IBAction)redColorButton:(UIButton *)sender {
    self.drawingView.brushColor = [UIColor redColor];

}

- (IBAction)yellowColorButton:(UIButton *)sender {
    self.drawingView.brushColor = [UIColor yellowColor];

}

- (IBAction)orangeColorButton:(UIButton *)sender {
    self.drawingView.brushColor = [UIColor orangeColor];

}

- (IBAction)blueColorButton:(UIButton *)sender {
    self.drawingView.brushColor = [UIColor blueColor];

}

- (IBAction)blackColorButton:(UIButton *)sender {
    self.drawingView.brushColor = [UIColor blackColor];

}

- (IBAction)greenColorButton:(UIButton *)sender {

    self.drawingView.brushColor = [UIColor greenColor];
}

@end

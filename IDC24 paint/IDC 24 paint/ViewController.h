//
//  ViewController.h
//  IDC 24 paint
//
//  Created by Петр Первухин on 24.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMDrawingView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet PMDrawingView *drawingView;

- (IBAction)clearButton:(UIButton *)sender;
- (IBAction)redColorButton:(UIButton *)sender;
- (IBAction)yellowColorButton:(UIButton *)sender;
- (IBAction)orangeColorButton:(UIButton *)sender;
- (IBAction)blueColorButton:(UIButton *)sender;
- (IBAction)blackColorButton:(UIButton *)sender;
- (IBAction)greenColorButton:(UIButton *)sender;

@end


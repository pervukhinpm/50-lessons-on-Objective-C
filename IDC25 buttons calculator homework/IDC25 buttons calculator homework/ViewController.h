//
//  ViewController.h
//  IDC25 buttons calculator homework
//
//  Created by Петр Первухин on 24.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    plusOperation,
    minusOperation,
    multiplyOperation,
    divideOperation,
} operand;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (strong,nonatomic) NSMutableString* displayString;
@property (assign,nonatomic) operand operation;
@property (assign,nonatomic) double firstOperand;
@property (assign,nonatomic) double secondOperand;

- (IBAction)clickDigit:(UIButton *)sender;
- (IBAction)clearDisplay:(UIButton *)sender;
- (IBAction)operationButton:(UIButton *)sender;
- (IBAction)equaleButton:(UIButton *)sender;
- (IBAction)dotButton:(UIButton *)sender;


@end


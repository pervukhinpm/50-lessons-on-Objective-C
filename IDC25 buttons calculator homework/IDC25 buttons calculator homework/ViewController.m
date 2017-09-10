//
//  ViewController.m
//  IDC25 buttons calculator homework
//
//  Created by Петр Первухин on 24.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (assign,nonatomic) BOOL canPressEquale;
@property (assign,nonatomic) BOOL canPressDot;
@property (assign,nonatomic) BOOL canPressOperation;
@property (assign,nonatomic) BOOL thisIsFirstOperand;
@property (assign,nonatomic) BOOL thisIsSecondOperand;
@property (assign,nonatomic) BOOL operationPressed;
@property (assign,nonatomic) BOOL dotHasBeenPressed;
@property (assign,nonatomic) BOOL first;

@end

@implementation ViewController
{
    double result;
    double roundResult;
    int rank;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    result = 0;
    [self reset];
  }

-(void) reset{
    self.canPressEquale = NO;
    self.thisIsFirstOperand = YES;
    self.thisIsSecondOperand = NO;
    self.canPressDot = NO;
    self.dotHasBeenPressed = NO;
    self.display.text = @"0";
    self.firstOperand = 0;
    self.secondOperand = 0;
}
-(void) resetAfterOperation{
    self.display.text = @"0";
    self.thisIsFirstOperand = NO;
    self.canPressDot=NO;
    self.thisIsSecondOperand = YES;
    self.canPressOperation = NO;
    self.dotHasBeenPressed = NO;
}

-(IBAction) clickDigit :(UIButton*) sender{
    NSInteger number = sender.tag;
    if(self.dotHasBeenPressed){
        [self proccesDigitWithDot:number];
    }else{
        [self proccesDigit:number];
    }
}


-(void) proccesDigit:(NSInteger) number{
    
    if(self.thisIsFirstOperand){
        self.firstOperand = self.firstOperand*10 + number;
        self.display.text = [NSString stringWithFormat:@"%0.f",self.firstOperand];
        self.canPressDot = YES;
        self.canPressOperation = YES;
    }
    if (self.thisIsSecondOperand){
        self.secondOperand =self.secondOperand*10 + number;
        self.display.text = [NSString stringWithFormat:@"%0.f",self.secondOperand];
        self.canPressDot = YES;
        self.canPressOperation = NO;
        self.canPressEquale = YES;
    }
}

- (IBAction)dotButton:(UIButton *)sender {
    if( self.canPressDot){
        if(self.thisIsFirstOperand){
            self.display.text = [NSString stringWithFormat:@"%0.f.",self.firstOperand];
        }
        if (self.thisIsSecondOperand){
            self.display.text = [NSString stringWithFormat:@"%0.f.",self.secondOperand];
        }
        self.dotHasBeenPressed = YES;
        self.first = YES;
        self.canPressDot = NO;
    }
}

-(void) proccesDigitWithDot:(NSInteger) number{
    
    if(self.thisIsFirstOperand){
        if(self.first){
            rank = 1;
        }
        NSLog(@"rank = %d",rank);
        self.firstOperand = self.firstOperand + number/pow(10, rank);
        NSLog(@"%f",self.firstOperand);
        [self displayFormat:_firstOperand];
        self.canPressDot = NO;
        self.canPressOperation = YES;
        rank = rank+1;
        NSLog(@"after rank = %d",rank);
        self.first = NO;

    }
    if (self.thisIsSecondOperand){
        if(self.first){
            rank = 1;
        }
        NSLog(@"rank = %d",rank);
        self.secondOperand = self.secondOperand + number/pow(10,rank);
        [self displayFormat:_secondOperand];
        self.canPressDot = NO;
        self.canPressOperation = NO;
        self.canPressEquale = YES;
        rank = rank+1;
        NSLog(@"after rank = %d",rank);
        self.first = NO;
    }
}

- (IBAction)clearDisplay:(UIButton *)sender {
    [self reset];
}



- (IBAction)operationButton:(UIButton *)sender {
    
    self.operation = (operand)sender.tag;
    if(self.canPressOperation){
    switch (self.operation) {
            
        case plusOperation:
            [self resetAfterOperation];
            self.operation = plusOperation;
            break;
        case minusOperation:
            [self resetAfterOperation];
            self.operation = minusOperation;
            break;
        case multiplyOperation:
            [self resetAfterOperation];
            self.operation = multiplyOperation;
            break;
        case divideOperation:
            [self resetAfterOperation];
            self.operation = divideOperation;
            break;
            
        default:
            
            break;
        }
    }
}

- (IBAction)equaleButton:(UIButton *)sender {
    
    if (self.canPressEquale){
        
        switch (self.operation) {
            case plusOperation:
                
                result = self.firstOperand + self.secondOperand;
                [self displayFormat:result];
                self.canPressDot = NO;
                self.firstOperand = result;
                self.secondOperand = 0;
                self.canPressEquale = NO;
                self.canPressOperation = YES;

                break;
                
            case minusOperation:
                
                result = self.firstOperand - self.secondOperand;
                [self displayFormat:result];
                self.canPressDot = NO;
                self.firstOperand = result;
                self.secondOperand = 0;
                self.canPressEquale = NO;
                self.canPressOperation = YES;

                break;
                
            case multiplyOperation:
                
                result = self.firstOperand * self.secondOperand;
                [self displayFormat:result];
                self.canPressDot = NO;
                self.firstOperand = result;
                self.secondOperand = 0;
                self.canPressEquale = NO;
                self.canPressOperation = YES;
                break;
                
            case divideOperation:
                
                result = self.firstOperand / self.secondOperand;
                [self displayFormat:result];
                self.canPressDot = NO;
                self.firstOperand = result;
                self.secondOperand = 0;
                self.canPressEquale = NO;
                self.canPressOperation = YES;
                break;
                
            default:
                
                break;
        }
    }
}

-(void) displayFormat:(double) format{
    
    self.display.text = [NSString stringWithFormat:@"%f",format];;
    
    if ([self.display.text containsString:@"."]){
        
        NSInteger length = [self.display.text length];
        
        while (length > 1){
            if ([[self.display.text substringFromIndex:(length-1)] isEqualToString:@"0"]){
                self.display.text = [self.display.text substringToIndex:(length -1)];
                length--;
            }else{
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end




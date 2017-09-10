//
//  ViewController.h
//  UITextField 27-28 homework
//
//  Created by Петр Первухин on 27.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

typedef enum {
    PMFirstNameTextField,
    PMLastNameTextField,
    PMLoginTextField,
    PMPasswordTextField,
    PMAgeTextField,
    PMPhoneNumberTextField,
    PMEmailTextField,
    PMAdressTextField
}PMTextField;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabel;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *allTextFields;

- (IBAction)clearButton:(UIButton *)sender;



- (IBAction)editingChanged:(UITextField *)sender;

@end


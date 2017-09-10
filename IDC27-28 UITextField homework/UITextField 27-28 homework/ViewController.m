//
//  ViewController.m
//  UITextField 27-28 homework
//
//  Created by Петр Первухин on 27.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//
/*

Ученик.

1. Создайте поля (и лейблы напротив как в уроке): имя, фамилия, логин, пароль, возраст, телефон, имеил адрес.
2. Установите правильные виды клавиатур для каждого текстового поля.
3. У всех текстовых полей кроме последнего кнопка ретерн должна быть NEXT, а у последнего DONE.
4. Осуществите переход по кнопкам NEXT и уберите клаву с экрана кнопкой DONE.
5. Каждое поле при нажатии должно иметь кнопку очистки

Студент

6. Совет, чтобы осуществить переход по NEXT без проверки тонны пропертей, попробуйте использовать UIOutletCollection
7. Создайте соответствующие каждому текстовому полю UILabel чтобы выводить туда информацию из текстовых полей. Сделайте их мелкими и другого цвета.
8. По изменению текста (даже буквы) обновляйте эти лейблы (не забудте про CLEAR button)

Мастер

9. Для поля ввода телефона используйте мой код из видео, можете поместить его в какой-то оотдельный метод если надо
10. Этот код должен работать только для поля телефона и не для какого другого

Супермен

11. Для поля ввода имеила ограничте ввод символов недопустимых в адресе
12. Более того, сибвол "@" может быть введен только 1 раз
13. установите разумное ограничение для этого поля

*/


#import "ViewController.h"

@interface ViewController ()

@property(assign,nonatomic) BOOL atSymbolIsPossible;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for(UITextField* currentTextField in self.allTextFields){
        currentTextField.delegate = self;
        
        if (currentTextField.tag == PMFirstNameTextField){
            [currentTextField becomeFirstResponder];
        }
    }
    self.atSymbolIsPossible = YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSInteger currentTextFieldIndex = [self.allTextFields indexOfObject:textField];
    
    NSInteger lastTextFieldIndex = [self.allTextFields indexOfObject:[self.allTextFields lastObject]];
    
    if (textField.tag != lastTextFieldIndex){
        UITextField* nextTextField = [self.allTextFields objectAtIndex:++currentTextFieldIndex];
        [nextTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (textField.tag == PMEmailTextField) {
        self.atSymbolIsPossible = TRUE;
    }
    return YES;
}


#pragma mark - Actions

- (IBAction)clearButton:(UIButton *)sender {
    
}

- (IBAction)editingChanged:(UITextField *)sender {
    
    UILabel* currentLabel = [self.allLabel objectAtIndex:[self.allTextFields indexOfObject:sender]];
    currentLabel.text = sender.text;
}


- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL changeOrNo = YES;

    if (textField.tag == PMPhoneNumberTextField) {
    
        changeOrNo = [self checkPhoneTextField:textField inRange:range replacementString:string];
    
    } else if (textField.tag == PMAgeTextField) {
    
        changeOrNo = [self checkAgeTextField:textField inRange:range replacementString:string];
    
    } else if (textField.tag == PMEmailTextField) {
    
        changeOrNo = [self checkEmailTextField:textField inRange:range replacementString:string];

        }
    return changeOrNo;
}

#pragma mark - Methods for UITextFieldDelegate

- (BOOL) checkPhoneTextField:(UITextField*) textField inRange:(NSRange)range replacementString:(NSString*)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    NSMutableString *resultString = [NSMutableString string];
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberMaxLength > 0) {
        
        NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        [resultString appendString:number];
        
        if ([resultString length] > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if ([newString length] > localNumberMaxLength) {
        
        NSInteger areaCodeLength = MIN([newString length] - localNumberMaxLength, areaCodeMaxLength);
        NSRange areaRange = NSMakeRange([newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        NSString *area = [newString substringWithRange:areaRange];
        area = [NSString stringWithFormat:@"(%@)",area];
        [resultString insertString:area atIndex:0];
    }
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
        
        NSInteger countryCodeLength = MIN([newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        NSRange countryRange = NSMakeRange(0, countryCodeLength);
        NSString *countryCode = [newString substringWithRange:countryRange];
        countryCode = [NSString stringWithFormat:@"+%@", countryCode];
        [resultString insertString:countryCode atIndex:0];
        
    }
    
    textField.text = resultString;
    UILabel *currentLabel = [self.allLabel objectAtIndex:[self.allTextFields indexOfObject:textField]];
    currentLabel.text = resultString;
    
    return NO;
}

- (BOOL) checkAgeTextField:(UITextField*)textField inRange:(NSRange)range replacementString:(NSString*)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    return [resultString length] <= 3;
}

- (BOOL) checkEmailTextField: (UITextField*) textField inRange:(NSRange)range replacementString:(NSString*)string {
    
    NSMutableString *badSymbols = [[NSMutableString alloc]initWithString:@"|!#=][}{$%^&*()+,/\?~`;:"];
    NSCharacterSet *validationSet = [NSCharacterSet characterSetWithCharactersInString:badSymbols];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;

    } else if (textField.text.length == 0 && [string isEqualToString:@"@"]) {
        return NO;
        
    } else if ([string isEqualToString:@"@"] && self.atSymbolIsPossible) {
        self.atSymbolIsPossible = FALSE;
        
    } else if ([string isEqualToString:@"@"] && !self.atSymbolIsPossible) {
        return NO;
    }
    
    return  YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

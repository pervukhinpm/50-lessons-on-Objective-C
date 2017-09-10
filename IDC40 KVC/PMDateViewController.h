//
//  PMDateViewController.h
//  IDC40 KVC
//
//  Created by Петр Первухин on 03.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMStudent;

@protocol DateViewDelegate <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;

@property (strong,nonatomic) PMStudent *student;

@end


@interface PMDateViewController : UIViewController
@property(strong,nonatomic) id <DateViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)actionDateChanged:(UIDatePicker *)sender;
- (IBAction)actionDonePressed:(UIButton *)sender;


@end

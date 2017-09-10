//
//  PMDateViewController.h
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 26.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@end

@interface PMDateViewController : UIViewController

@property (weak, nonatomic) id <ViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)actionDateChanged:(UIDatePicker *)sender;
- (IBAction)actionDonePressed:(UIButton *)sender;

@end

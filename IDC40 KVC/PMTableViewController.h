//
//  PMTableViewController.h
//  IDC40 KVC
//
//  Created by Петр Первухин on 03.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMDateViewController.h"

@class PMStudent;

@interface PMTableViewController : UITableViewController <DateViewDelegate>

@property (strong, nonatomic) PMStudent *student;

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *gradeField;

- (IBAction)actionGenderChanged:(UISegmentedControl *)sender;
- (IBAction)actionReset:(UIButton *)sender;

@end

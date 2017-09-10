//
//  PMTableViewController.h
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 25.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMDateViewController.h"
#import "PMEducationTableViewController.h"

@interface PMTableViewController : UITableViewController <ViewControllerDelegate,EducationDelegate>

- (IBAction)infoButtonAction:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *educationTextField;


@end

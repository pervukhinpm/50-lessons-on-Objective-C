//
//  TableViewController.h
//  IDC29 UITableView Static Cells homework
//
//  Created by Петр Первухин on 29.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginFields;
@property (weak, nonatomic) IBOutlet UITextField *passwordFields;
@property (weak, nonatomic) IBOutlet UISegmentedControl *levelControl;
@property (weak, nonatomic) IBOutlet UISwitch *shadowsSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *texturesControl;
@property (weak, nonatomic) IBOutlet UISlider *soundSlider;
@property (weak, nonatomic) IBOutlet UISlider *musicSlider;


- (IBAction)actionTextChanged:(UITextField *)sender;
- (IBAction)actionValueChangrd:(id)sender;

@end
